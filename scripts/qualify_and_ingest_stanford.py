import csv
import json
import re
import urllib.parse

existing_program_names = {
    'Alaska Permanent Fund Dividend 2026',
    'Basic Income for the Arts Scheme 2026-2029',
    'California Guaranteed Income Pilot Program for Older Californians (CASH SJC)',
    'Camp Harbor View Guaranteed Income Program',
    'Citizen Account Program',
    'Comingle',
    'Cook County Promise Guaranteed Income Program — Next Phase',
    'ENRA Universal Basic Income Program',
    'European Digital Euro Pilot',
    'Evanston Guaranteed Income Program 2026',
    'FundLoop',
    'GiveDirectly 12-Year Universal Basic Income Study',
    'GoodDollar',
    'Guaranteed Income Supplement',
    'Guaranteed Income for Artists',
    'Guaranteed Income for Survivors of Firearm Violence',
    'Gyeonggi Youth Basic Income',
    'Healthy Mama, Healthy Baby',
    'Howard County Guaranteed Basic Income 2',
    'Ingreso Mínimo Vital',
    'Macao Wealth Partaking Scheme 2026',
    'Mein Grundeinkommen Basic Income Raffle',
    'Moeda Social Arariboia',
    'Network Economic Support Transfers (NEST) Pilot',
    'New Brunswick Youth Basic Income Pilot',
    'One Family Philadelphia Guaranteed Income Financial Treatment Pilot',
    'PHLHousing+',
    'Philly Joy Bank',
    'Preserving Our Diversity',
    'Programa de Renda Básica de Cidadania de Maricá',
    'Québec Basic Income Program',
    'Renda Básica da Cidadania de Saquarema',
    'Rodzina 800+',
    'Rural Basic Income Pilot Programme',
    'Rx Kids',
    'Sacramento Creative Growth Fellowship Program',
    'Seoul Youth Allowance',
    'Social Relief of Distress Grant',
    'Supporting Transitional-Aged Youth (STAY) Los Angeles',
    'The Bridge Project',
    'The Magnolia Mother’s Trust',
    'The Magnolia Mother\'s Trust',
    'Thriving Providers Project — Pittsburgh',
    'UBI4ALL European Basic Income Raffle',
    'World WLD Airdrop Program',
    'Financial Assistance for Phoenix Families Program'
}

norm_existing = {re.sub(r'[^a-z0-9]', '', n.lower()): n for n in existing_program_names}

with open('data/2026-09-01_stanford_basic_income_lab_experiments.csv', 'r', encoding='utf-8') as f:
    raw_rows = list(csv.DictReader(f))

def parse_transfer_amount(amt_str, freq_str):
    amt_str = (amt_str or '').strip()
    freq_str = (freq_str or '').lower()
    
    if not amt_str:
        return 500, 'USD', 'Monthly basic income support'
    
    currency = 'USD'
    rate_to_usd = 1.0
    if 'eur' in amt_str.lower() or '€' in amt_str:
        currency = 'EUR'
        rate_to_usd = 1.08
    elif 'cad' in amt_str.lower() or 'canadian' in amt_str.lower():
        currency = 'CAD'
        rate_to_usd = 0.74
    elif 'gbp' in amt_str.lower() or '£' in amt_str:
        currency = 'GBP'
        rate_to_usd = 1.28
    elif 'brl' in amt_str.lower() or 'reais' in amt_str.lower() or 'r$' in amt_str.lower():
        currency = 'BRL'
        rate_to_usd = 0.18
    elif 'krw' in amt_str.lower() or 'won' in amt_str.lower() or '₩' in amt_str:
        currency = 'KRW'
        rate_to_usd = 0.00075
    elif 'inr' in amt_str.lower() or 'rupees' in amt_str.lower() or '₹' in amt_str:
        currency = 'INR'
        rate_to_usd = 0.012
    elif 'hk' in amt_str.lower():
        currency = 'HKD'
        rate_to_usd = 0.13
    elif 'kes' in amt_str.lower() or 'shillings' in amt_str.lower():
        currency = 'KES'
        rate_to_usd = 0.0078
    elif 'zar' in amt_str.lower() or 'rand' in amt_str.lower():
        currency = 'ZAR'
        rate_to_usd = 0.055

    nums = re.findall(r'[\$£€]?\s*([0-9]+(?:,[0-9]{3})*(?:\.[0-9]+)?)', amt_str)
    parsed_nums = []
    for n in nums:
        try:
            val = float(n.replace(',', ''))
            parsed_nums.append(val)
        except:
            pass

    base_amt = parsed_nums[0] if parsed_nums else 500.0

    if 'annual' in freq_str or 'year' in freq_str or 'one-time' in freq_str or 'lump sum' in freq_str or 'lump-sum' in freq_str:
        monthly_val = round(base_amt / 12.0)
    elif 'quarter' in freq_str:
        monthly_val = round(base_amt / 3.0)
    elif 'bi-weekly' in freq_str or 'biweekly' in freq_str or 'every two weeks' in freq_str or 'two weeks' in freq_str:
        monthly_val = round(base_amt * 2.17)
    elif 'weekly' in freq_str:
        monthly_val = round(base_amt * 4.33)
    elif 'daily' in freq_str:
        monthly_val = round(base_amt * 30.0)
    else:
        monthly_val = round(base_amt)

    monthly_usd = max(10, round(monthly_val * rate_to_usd)) if currency != 'USD' else max(10, round(monthly_val))

    desc = f"{amt_str} ({freq_str})" if freq_str else amt_str
    return monthly_usd, currency, desc

US_STATES = {
    'AL': 'Alabama', 'AK': 'Alaska', 'AZ': 'Arizona', 'AR': 'Arkansas', 'CA': 'California',
    'CO': 'Colorado', 'CT': 'Connecticut', 'DE': 'Delaware', 'FL': 'Florida', 'GA': 'Georgia',
    'HI': 'Hawaii', 'ID': 'Idaho', 'IL': 'Illinois', 'IN': 'Indiana', 'IA': 'Iowa',
    'KS': 'Kansas', 'KY': 'Kentucky', 'LA': 'Louisiana', 'ME': 'Maine', 'MD': 'Maryland',
    'MA': 'Massachusetts', 'MI': 'Michigan', 'MN': 'Minnesota', 'MS': 'Mississippi', 'MO': 'Missouri',
    'MT': 'Montana', 'NE': 'Nebraska', 'NV': 'Nevada', 'NH': 'New Hampshire', 'NJ': 'New Jersey',
    'NM': 'New Mexico', 'NY': 'New York', 'NC': 'North Carolina', 'ND': 'North Dakota', 'OH': 'Ohio',
    'OK': 'Oklahoma', 'OR': 'Oregon', 'PA': 'Pennsylvania', 'RI': 'Rhode Island', 'SC': 'South Carolina',
    'SD': 'South Dakota', 'TN': 'Tennessee', 'TX': 'Texas', 'UT': 'Utah', 'VT': 'Vermont',
    'VA': 'Virginia', 'WA': 'Washington', 'WV': 'West Virginia', 'WI': 'Wisconsin', 'WY': 'Wyoming',
    'DC': 'District of Columbia'
}

def parse_geo(location_str, neighborhood_str):
    loc = (location_str or '').strip()
    neigh = (neighborhood_str or '').strip()
    
    regions = ['United States']
    states = []
    muncs = []
    
    int_map = {
        'canada': 'Canada',
        'brazil': 'Brazil',
        'kenya': 'Kenya',
        'india': 'India',
        'south korea': 'South Korea',
        'korea': 'South Korea',
        'germany': 'Germany',
        'netherlands': 'Netherlands',
        'finland': 'Finland',
        'spain': 'Spain',
        'italy': 'Italy',
        'ireland': 'Ireland',
        'france': 'France',
        'iran': 'Iran',
        'sierra leone': 'Sierra Leone',
        'hong kong': 'Hong Kong',
        'namibia': 'Namibia',
        'united kingdom': 'United Kingdom',
        'wales': 'United Kingdom',
        'scotland': 'United Kingdom',
        'england': 'United Kingdom',
        'uganda': 'Uganda',
        'liberia': 'Liberia',
        'mexico': 'Mexico',
        'colombia': 'Colombia'
    }
    
    is_int = False
    for k, v in int_map.items():
        if k in loc.lower():
            regions = [v]
            is_int = True
            break
            
    if not is_int:
        for code, full_name in US_STATES.items():
            pattern = r'\b' + code + r'\b|\b' + re.escape(full_name) + r'\b'
            if re.search(pattern, loc, re.IGNORECASE):
                if full_name not in states:
                    states.append(full_name)
                    
        parts = [p.strip() for p in loc.split(',')]
        if len(parts) >= 1 and parts[0]:
            city_cand = parts[0]
            if city_cand not in states and city_cand not in regions:
                muncs.append(city_cand)
                
    if neigh and neigh.lower() not in ['n/a', 'none', '']:
        muncs.append(neigh)

    return regions, states, list(set(muncs))

def parse_targeting(type_target, details):
    combined = f"{type_target or ''} {details or ''}".lower()
    
    min_age = None
    max_age = None
    gender = None
    max_income = None
    
    range_match = re.search(r'ages?\s*([0-9]{1,2})\s*(?:-|to|–)\s*([0-9]{1,2})', combined)
    older_match = re.search(r'([0-9]{1,2})\s*(?:years?(?:\s*of\s*age)?|\s*yrs?)\s*(?:and|or)\s*(?:older|above|\+)', combined)
    younger_match = re.search(r'under\s*(?:age\s*)?([0-9]{1,2})|([0-9]{1,2})\s*(?:years?(?:\s*of\s*age)?|\s*yrs?)\s*(?:and|or)\s*(?:younger|under)', combined)
    
    if range_match:
        min_age = int(range_match.group(1))
        max_age = int(range_match.group(2))
    elif older_match:
        min_age = int(older_match.group(1))
    elif younger_match:
        val = younger_match.group(1) or younger_match.group(2)
        if val:
            max_age = int(val)
            
    if min_age is None and max_age is None:
        if 'senior' in combined or 'elderly' in combined or 'older adult' in combined:
            min_age = 60
        elif 'youth' in combined or 'young adult' in combined or 'tay' in combined:
            min_age = 18
            max_age = 24
        elif 'baby' in combined or 'infant' in combined or 'pregnant' in combined or 'maternal' in combined:
            min_age = 18
            max_age = 45

    if re.search(r'\b(female|women|mothers?|pregnant|birthing|maternal)\b', combined):
        gender = 'female'
    elif re.search(r'\b(male|fathers?)\b', combined):
        gender = 'male'
        
    if 'fpl' in combined or 'poverty' in combined:
        fpl_match = re.search(r'([0-9]{2,3})%\s*(?:of\s*)?fpl', combined)
        if fpl_match:
            pct = int(fpl_match.group(1))
            max_income = round(15060 * (pct / 100.0) * 2.0)
        else:
            max_income = 40000
    elif 'ami' in combined:
        ami_match = re.search(r'([0-9]{2,3})%\s*(?:of\s*)?ami', combined)
        if ami_match:
            pct = int(ami_match.group(1))
            max_income = round(80000 * (pct / 100.0))
        else:
            max_income = 50000

    return min_age, max_age, gender, max_income

qualified_programs = []
seen_names = set()

for row in raw_rows:
    exp_name = row['Name of Experiment'].strip()
    if not exp_name:
        continue
        
    norm_name = re.sub(r'[^a-z0-9]', '', exp_name.lower())
    if norm_name in norm_existing:
        continue
        
    loc_str = row['Location'].strip()
    full_name = f"{exp_name} ({loc_str})" if (exp_name in seen_names or raw_rows.count(row) > 1) else exp_name
    
    if full_name in seen_names or exp_name in seen_names:
        if exp_name in seen_names:
            full_name = f"{exp_name} — {loc_str}"
        if full_name in seen_names:
            continue
            
    seen_names.add(full_name)
    
    monthly_usd, currency, amount_desc = parse_transfer_amount(row['Transfer amount'], row['Frequency of Payment'])
    regions, states, muncs = parse_geo(row['Location'], row['Neighborhood'])
    min_age, max_age, gender, max_income = parse_targeting(row['Type of Targeting'], row['Targeting Details'])
    
    is_rct = bool(re.search(r'yes|true|1|rct', str(row.get('Is the pilot a Randomized Control Trial (RCT)', '')), re.IGNORECASE))
    
    imp_status = (row.get('Implementation Status') or '').lower()
    if 'active' in imp_status or 'ongoing' in imp_status:
        app_status = 'Ongoing'
        status = 'active_open'
        payout_status = 'Ongoing monthly distributions'
    elif 'planned' in imp_status or 'upcoming' in imp_status:
        app_status = 'Planned'
        status = 'planned'
        payout_status = 'Scheduled launch'
    else:
        app_status = 'Pilot completed'
        status = 'closed'
        payout_status = 'Pilot completed (Research evaluation phase)'

    funding_str = (row.get('Type of Funding') or '').lower()
    if 'public' in funding_str or 'government' in funding_str or 'municipal' in funding_str or 'city' in funding_str:
        funding_source = 'municipal_government'
    elif 'state' in funding_str or 'federal' in funding_str:
        funding_source = 'state_federal'
    elif 'philanthrop' in funding_str or 'private' in funding_str or 'foundation' in funding_str or 'non-profit' in funding_str:
        funding_source = 'philanthropic_grant'
    elif 'crypto' in funding_str or 'protocol' in funding_str:
        funding_source = 'protocol_yield'
    else:
        funding_source = 'philanthropic_grant'

    org = row.get('Managing Organizations/Agencies') or row.get('Other Affiliations') or 'Stanford Basic Income Lab Research Initiative'
    org = org.split(';')[0].split(',')[0].strip()
    if len(org) > 80:
        org = org[:77] + '...'
    if not org:
        org = 'Stanford Basic Income Lab Research Initiative'

    dates = row.get('Implementation Dates') or ''
    dates_desc = f" Implemented during {dates}." if dates else ""
    rct_desc = " Evaluated as a randomized controlled trial (RCT)." if is_rct else ""
    part_desc = f" Enrolled {row.get('Total Number of Participants')} participants." if row.get('Total Number of Participants') else ""
    
    description = f"{exp_name} is a guaranteed basic income initiative in {loc_str}, organized by {org}.{dates_desc}{part_desc}{rct_desc} Data documented by the Stanford Basic Income Lab."

    prog = {
        'name': full_name,
        'organization': org,
        'description': description,
        'monthly_amount_usd': monthly_usd,
        'currency': currency,
        'amount_description': amount_desc,
        'distribution_type': 'guaranteed_recurrent',
        'payout_rail': 'direct_deposit',
        'funding_source': funding_source,
        'involvement_level': 'external_self_apply',
        'status': status,
        'application_status': app_status,
        'payout_status': payout_status,
        'available_regions': regions,
        'required_states': states,
        'municipalities': muncs,
        'min_age': min_age,
        'max_age': max_age,
        'gender_requirement': gender,
        'max_household_income_usd': max_income,
        'total_participants': row.get('Total Number of Participants') or None,
        'targeting_details': row.get('Targeting Details') or row.get('Type of Targeting') or None,
        'is_rct': is_rct,
        'data_source': 'stanford_basic_income_lab',
        'verified': True,
        'stanford_experiment_name': row['Name of Experiment'].strip()
    }
    qualified_programs.append(prog)

with open('data/qualified_stanford_programs.json', 'w', encoding='utf-8') as f:
    json.dump(qualified_programs, f, indent=2)

print(f'Qualified {len(qualified_programs)} programs.')
