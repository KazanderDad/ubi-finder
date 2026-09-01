import json
import re

with open('data/qualified_stanford_programs.json', 'r', encoding='utf-8') as f:
    programs = json.load(f)

# Matched experiment names from migration 00017:
matched_names = {
    'alaska permanent dividend fund',
    'basic income kenya study',
    'basic income for the arts',
    'camp harbor view guaranteed income pilot',
    'cook county promise guaranteed income',
    'creative growth fellowship',
    'guaranteed income pilot program',
    'guaranteed income for artists',
    'youth basic income program',
    'wealth partaking scheme',
    'my basic income',
    'one family philadelphia guaranteed income financial treatment (giftt)',
    'phlhousing+',
    'preserving our diversity',
    'renda basica de cidadania (citizens',
    'rx kids',
    'seoul stepping stone income project (ssip)',
    'the bridge project',
    'the magnolia mother’s trust',
    'the magnolia mother\'s trust',
    'thriving providers project'
}

ENRICHMENTS = {
    'Stockton Economic Empowerment Demonstration': {
        'website': 'https://www.stocktondemonstration.org/',
        'org': 'Mayors for a Guaranteed Income & City of Stockton',
        'research': 'Center for Guaranteed Income Research (UPenn), Dr. Amy Castro & Dr. Stacia West'
    },
    'Breathe: LA County’s Guaranteed Income Program': {
        'website': 'https://ceo.lacounty.gov/antiracism/breathe/',
        'org': 'Los Angeles County Chief Executive Office & Strength in Numbers',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'BIG:LEAP': {
        'website': 'https://bigleap.lacity.gov/',
        'org': 'City of Los Angeles Community Investment for Families Department',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'Compton Pledge': {
        'website': 'https://comptonpledge.org/',
        'org': 'Fund for Guaranteed Income (F4GI) & City of Compton',
        'research': 'Jain Family Institute (JFI)'
    },
    'HudsonUP': {
        'website': 'https://hudsonup.org/',
        'org': 'The Spark of Hudson & Jain Family Institute',
        'research': 'Jain Family Institute (JFI)'
    },
    'In Her Hands': {
        'website': 'https://www.thegrofund.org/in-her-hands',
        'org': 'Georgia Resilience and Opportunity (GRO) Fund & GiveDirectly',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'Newark Movement for Economic Equity': {
        'website': 'https://www.uwnpc.org/nmee',
        'org': 'City of Newark & United Way of Greater Newark',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'Denver Basic Income Project': {
        'website': 'https://www.denverbasicincomeproject.org/',
        'org': 'Denver Basic Income Project & City of Denver',
        'research': 'University of Denver Center for Housing and Homelessness Research'
    },
    'Ontario Basic Income Pilot': {
        'website': 'https://www.ontario.ca/page/ontario-basic-income-pilot',
        'org': 'Government of Ontario Ministry of Community and Social Services',
        'research': 'McMaster University & Ryerson University'
    },
    'Finland Basic Income Experiment': {
        'website': 'https://www.kela.fi/web/en/basic-income-experiment',
        'org': 'Kela (Social Insurance Institution of Finland)',
        'research': 'Kela & Ministry of Social Affairs and Health'
    },
    'Manitoba Basic Annual Income Experiment (MINCOME)': {
        'website': 'https://www.utpjournals.press/doi/abs/10.3138/cpp.37.3.283',
        'org': 'Canadian Federal Government & Province of Manitoba',
        'research': 'Dr. Evelyn Forget, University of Manitoba'
    },
    'Abundant Birth Project': {
        'website': 'https://abundantbirthproject.org/',
        'org': 'Expecting Justice & San Francisco Department of Public Health',
        'research': 'University of California, San Francisco (UCSF)'
    },
    'Baby’s First Years': {
        'website': 'https://www.babysfirstyears.com/',
        'org': 'Teachers College, Columbia University & New York University',
        'research': 'Columbia, NYU, UC Irvine, UCLA, University of Wisconsin-Madison'
    },
    'Austin Guaranteed Income Pilot': {
        'website': 'https://www.austintexas.gov/department/equity-office',
        'org': 'City of Austin & UpTogether',
        'research': 'Urban Institute'
    },
    'Baltimore Young Families Success Fund': {
        'website': 'https://www.baltimorecity.gov/byfsf',
        'org': 'Mayor\'s Office of Children & Family Success (Baltimore)',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'Cambridge RISE': {
        'website': 'https://www.cambridgema.gov/rise',
        'org': 'City of Cambridge & Cambridge Economic Opportunity Authority',
        'research': 'Center for Guaranteed Income Research (UPenn)'
    },
    'Chelsea Eats': {
        'website': 'https://www.chelseama.gov/',
        'org': 'City of Chelsea, Massachusetts',
        'research': 'Harvard Kennedy School Rappaport Institute'
    },
    'Chicago Resilient Communities Pilot': {
        'website': 'https://www.chicago.gov/city/en/sites/resilient-communities-pilot/home.html',
        'org': 'City of Chicago Department of Family & Support Services',
        'research': 'University of Chicago Inclusive Economy Lab'
    },
    'Gary Income Maintenance Experiment': {
        'website': 'https://www.irp.wisc.edu/',
        'org': 'U.S. Department of Health, Education, and Welfare & Indiana University',
        'research': 'Institute for Research on Poverty, University of Wisconsin-Madison'
    },
    'Seattle-Denver Income Maintenance Experiment (SIME/DIME)': {
        'website': 'https://www.irp.wisc.edu/',
        'org': 'U.S. Department of Health, Education, and Welfare & Stanford Research Institute (SRI)',
        'research': 'Stanford Research Institute & Mathematica Policy Research'
    },
    'New Jersey Negative Income Tax Experiment': {
        'website': 'https://www.irp.wisc.edu/',
        'org': 'Office of Economic Opportunity & Princeton University',
        'research': 'Mathematica & Institute for Research on Poverty'
    },
    'Rural Income Maintenance Experiment': {
        'website': 'https://www.irp.wisc.edu/',
        'org': 'Office of Economic Opportunity & University of Wisconsin',
        'research': 'Institute for Research on Poverty'
    }
}

sql_lines = []
sql_lines.append("-- Migration 00019: Ingest and qualify all remaining Stanford Basic Income Lab experiments into public.programs")
sql_lines.append("-- 1. Fix handle_new_program_submission to use submitter_email")
sql_lines.append("""
CREATE OR REPLACE FUNCTION public.handle_new_program_submission()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  IF NEW.verified = FALSE OR NEW.status = 'pending_approval' THEN
    INSERT INTO public.admin_notifications (type, title, message, program_id, submitter_id)
    VALUES (
      'program_submitted',
      'New Program Submitted for Review: ' || NEW.name,
      'A new program has been submitted by ' || COALESCE(NEW.submitter_email, 'a contributor') || ' and is awaiting verification.',
      NEW.id,
      auth.uid()
    );
  END IF;
  RETURN NEW;
END;
$$;
""")

start_prog_id = 101
inserted_count = 0

for p in programs:
    exp_name = p['stanford_experiment_name'].lower().strip()
    if any(m in exp_name for m in matched_names):
        continue

    prog_id = start_prog_id + inserted_count
    inserted_count += 1
    
    # Check enrichment
    enrich = None
    for k, v in ENRICHMENTS.items():
        if k.lower() in p['name'].lower():
            enrich = v
            break
            
    name_esc = p['name'].replace("'", "''")
    org_esc = (enrich['org'] if enrich else p['organization']).replace("'", "''")
    website_sql = f"'{enrich['website'].replace('\'', '\'\'')}'" if enrich else "NULL"
    
    desc_extra = f" Evaluation conducted by {enrich['research']}." if enrich else ""
    desc_esc = (p['description'] + desc_extra).replace("'", "''")
    
    amount_desc_esc = p['amount_description'].replace("'", "''")
    payout_status_esc = p['payout_status'].replace("'", "''")
    app_status_esc = p['application_status'].replace("'", "''")
    
    # Status enum validation
    status_val = p['status']
    if status_val not in ['active', 'active_open', 'active_closed', 'upcoming', 'closed', 'pending_approval']:
        status_val = 'closed' if 'closed' in status_val else 'active_open'
        
    # Gender enum validation
    gender_val = p['gender_requirement']
    if gender_val not in ['female', 'male', 'other', None]:
        gender_val = None
    gender_sql = f"'{gender_val}'::public.program_gender_requirement" if gender_val else "NULL"
    
    regions_sql = "ARRAY[" + ", ".join(f"'{r.replace('\'', '\'\'')}'" for r in p['available_regions']) + "]" if p['available_regions'] else "ARRAY['United States']"
    states_sql = "ARRAY[" + ", ".join(f"'{s.replace('\'', '\'\'')}'" for s in p['required_states']) + "]" if p['required_states'] else "ARRAY[]::TEXT[]"
    muncs_sql = "ARRAY[" + ", ".join(f"'{m.replace('\'', '\'\'')}'" for m in p['municipalities']) + "]" if p['municipalities'] else "ARRAY[]::TEXT[]"
    
    min_age_sql = str(p['min_age']) if p['min_age'] is not None else "NULL"
    max_age_sql = str(p['max_age']) if p['max_age'] is not None else "NULL"
    income_sql = str(p['max_household_income_usd']) if p['max_household_income_usd'] is not None else "NULL"
    part_sql = f"'{p['total_participants'].replace('\'', '\'\'')}'" if p['total_participants'] else "NULL"
    target_sql = f"'{p['targeting_details'].replace('\'', '\'\'')}'" if p['targeting_details'] else "NULL"
    rct_sql = "TRUE" if p['is_rct'] else "FALSE"
    exp_name_esc = p['stanford_experiment_name'].replace("'", "''")

    sql = f"""
INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    {prog_id},
    '{name_esc}',
    '{org_esc}',
    '{desc_esc}',
    {p['monthly_amount_usd']},
    '{p['currency']}',
    '{amount_desc_esc}',
    'standard'::public.payment_method,
    '{p['distribution_type']}',
    '{p['payout_rail']}',
    '{p['funding_source']}',
    '{p['involvement_level']}',
    '{status_val}'::public.program_status,
    '{app_status_esc}',
    '{payout_status_esc}',
    {regions_sql},
    {states_sql},
    {muncs_sql},
    {min_age_sql},
    {max_age_sql},
    {gender_sql},
    {income_sql},
    {part_sql},
    {target_sql},
    {rct_sql},
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = '{exp_name_esc}' LIMIT 1),
    {website_sql},
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = '{name_esc}'
);
"""
    sql_lines.append(sql.strip())

output_sql = "\n\n".join(sql_lines)
with open('supabase/migrations/00019_ingest_unmatched_stanford_experiments.sql', 'w', encoding='utf-8') as f:
    f.write(output_sql)

with open('src/supabase/migrations/00019_ingest_unmatched_stanford_experiments.sql', 'w', encoding='utf-8') as f:
    f.write(output_sql)

print(f"Generated clean migration 00019 with {inserted_count} unmatched programs!")
