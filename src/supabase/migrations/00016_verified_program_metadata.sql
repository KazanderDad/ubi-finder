-- Migration 00015: Comprehensive Verified Metadata for Programs


UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 37000,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Illinois']::text[],
    municipalities = ARRAY['Evanston', 'Cook County']::text[],
    sources = ARRAY['https://www.cityofevanston.org/residents/community_resources/guaranteed_income_program_2026.php']::text[]
WHERE name = 'Evanston Guaranteed Income Program 2026';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 93600,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Maryland']::text[],
    municipalities = ARRAY['Howard County', 'Columbia']::text[],
    sources = ARRAY['https://cac-hc.org/gbi2/']::text[]
WHERE name = 'Howard County Guaranteed Basic Income 2';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = 'female',
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia']::text[],
    sources = ARRAY['https://www.neighborstrust.org/program', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[]
WHERE name = 'Healthy Mama, Healthy Baby';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = 'female',
    max_household_income_usd = 100000,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia']::text[],
    sources = ARRAY['https://philacityfund.org/programs/philly-joy-bank/', 'https://www.phillyjoybank.org/', 'https://www.phillyjoybank.org/faqs']::text[]
WHERE name = 'Philly Joy Bank';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = 'female',
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Michigan']::text[],
    municipalities = ARRAY['Flint', 'Genesee County', 'Kalamazoo', 'Dearborn']::text[],
    sources = ARRAY['https://rxkids.org/', 'https://rxkids.org/communities/', 'https://rxkids.aidkit.org/']::text[]
WHERE name = 'Rx Kids';

UPDATE public.programs
SET min_age = 65,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 44150,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['California']::text[],
    municipalities = ARRAY['Santa Monica']::text[],
    sources = ARRAY['https://www.santamonica.gov/housing-pod', 'https://www.santamonica.gov/housing-pod-faqs']::text[]
WHERE name = 'Preserving Our Diversity';

UPDATE public.programs
SET min_age = 18,
    max_age = 24,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['California']::text[],
    municipalities = ARRAY['Los Angeles']::text[],
    sources = ARRAY['https://communityinvestment.lacity.gov/programs-resources', 'https://cityclerk.lacity.org/onlinedocs/2021/21-0717-S3_rpt_cao_06-04-25.pdf', 'https://lasentinel.net/price-leads-new-stay-safe-guaranteed-income-expansion.html']::text[]
WHERE name = 'Supporting Transitional-Aged Youth (STAY) Los Angeles';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Ireland']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Dublin', 'Nationwide']::text[],
    sources = ARRAY['https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-guidelines-for-application/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-faq/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/press-releases/minister-odonovan-announces-the-new-basic-income-for-the-arts-scheme/']::text[]
WHERE name = 'Basic Income for the Arts Scheme 2026-2029';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['South Korea']::text[],
    required_states = ARRAY['Gyeonggi', 'Gangwon', 'North Chungcheong', 'South Chungcheong', 'North Jeolla', 'South Jeolla', 'North Gyeongsang', 'South Gyeongsang']::text[],
    municipalities = ARRAY['Participating Counties']::text[],
    sources = ARRAY['https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG']::text[]
WHERE name = 'Rural Basic Income Pilot Programme';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Marshall Islands']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Majuro', 'Nationwide']::text[],
    sources = ARRAY['https://mof.gov.mh/usdm1/enra/', 'https://mof.gov.mh/usdm1-whitepaper/', 'https://marshallislandsjournal.com/enra-bump-up/']::text[]
WHERE name = 'ENRA Universal Basic Income Program';

UPDATE public.programs
SET min_age = NULL,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Alaska']::text[],
    municipalities = ARRAY['Statewide']::text[],
    sources = ARRAY['https://pfd.alaska.gov/', 'https://pfd.alaska.gov/eligibility/eligibility-requirements', 'https://pfd.alaska.gov/application/filing-period']::text[]
WHERE name = 'Alaska Permanent Fund Dividend 2026';

UPDATE public.programs
SET min_age = NULL,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['China']::text[],
    required_states = ARRAY['Macao Special Administrative Region']::text[],
    municipalities = ARRAY['Macao SAR']::text[],
    sources = ARRAY['https://www.planocp.gov.mo/en/about/intro', 'https://www.planocp.gov.mo/en/timetable', 'https://www.planocp.gov.mo/en/request/atleast183_2026']::text[]
WHERE name = 'Macao Wealth Partaking Scheme 2026';

UPDATE public.programs
SET min_age = 18,
    max_age = 64,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Canada']::text[],
    required_states = ARRAY['Quebec']::text[],
    municipalities = ARRAY['Province-wide']::text[],
    sources = ARRAY['https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program']::text[]
WHERE name = 'Québec Basic Income Program';

UPDATE public.programs
SET min_age = 65,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 16500,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Canada']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide']::text[],
    sources = ARRAY['https://www.canada.ca/en/services/benefits/publicpensions/old-age-security/guaranteed-income-supplement.html']::text[]
WHERE name = 'Guaranteed Income Supplement';

UPDATE public.programs
SET min_age = 23,
    max_age = 64,
    gender_requirement = NULL,
    max_household_income_usd = 10200,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Spain']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide']::text[],
    sources = ARRAY['https://imv.seg-social.es/', 'https://www.seg-social.es/wps/portal/wss/internet/Trabajadores/PrestacionesPensionesTrabajadores/65850d68-8d06-4645-bde7-05374ee42ac7']::text[]
WHERE name = 'Ingreso Mínimo Vital';

UPDATE public.programs
SET min_age = 18,
    max_age = 59,
    gender_requirement = NULL,
    max_household_income_usd = 440,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['South Africa']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide']::text[],
    sources = ARRAY['https://srd.sassa.gov.za/', 'https://srd.sassa.gov.za/said']::text[]
WHERE name = 'Social Relief of Distress Grant';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'mobile_money',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Kenya']::text[],
    required_states = ARRAY['Siaya', 'Bomet']::text[],
    municipalities = ARRAY['Bondo', 'Ugunja']::text[],
    sources = ARRAY['https://www.givedirectly.org/ubi', 'https://www.givedirectly.org/2023-ubi-results']::text[]
WHERE name = 'GiveDirectly 12-Year Universal Basic Income Study';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'lottery_raffle',
    payout_rail = 'direct_deposit',
    funding_source = 'community_crowdfund',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Global']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Berlin', 'Global']::text[],
    sources = ARRAY['https://www.mein-grundeinkommen.de/', 'https://www.mein-grundeinkommen.de/verlosung']::text[]
WHERE name = 'Mein Grundeinkommen Basic Income Raffle';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'daily_claim_protocol',
    payout_rail = 'crypto_wallet',
    funding_source = 'protocol_yield',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Global']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Global']::text[],
    sources = ARRAY['https://support.world.org/hc/en-us/articles/30969185598739-Updates-to-the-Airdrop-Program', 'https://whitepaper.world.org/designing-for-scale/2026-03-24']::text[]
WHERE name = 'World WLD Airdrop Program';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Saudi Arabia']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide']::text[],
    sources = ARRAY['https://eservices.ca.gov.sa/', 'https://www.hrsd.gov.sa/en/care-about-you/social-protection']::text[]
WHERE name = 'Citizen Account Program';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'daily_claim_protocol',
    payout_rail = 'crypto_wallet',
    funding_source = 'protocol_yield',
    involvement_level = 'automated_claim',
    available_regions = ARRAY['Global']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Global']::text[],
    sources = ARRAY['https://wallet.gooddollar.org', 'https://www.gooddollar.org', 'https://dashboard.gooddollar.org']::text[]
WHERE name = 'GoodDollar';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Planned',
    status = 'upcoming',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'crypto_wallet',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Germany', 'France', 'Spain', 'Italy', 'Ireland', 'Netherlands', 'Belgium', 'Austria', 'Portugal', 'Finland', 'Greece']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Eurozone']::text[],
    sources = ARRAY['https://www.ecb.europa.eu/paym/digital_euro/', 'https://www.centralbank.ie/consumer-hub/digital-euro']::text[]
WHERE name = 'European Digital Euro Pilot';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'daily_claim_protocol',
    payout_rail = 'crypto_wallet',
    funding_source = 'protocol_yield',
    involvement_level = 'automated_claim',
    available_regions = ARRAY['Global']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Global']::text[],
    sources = ARRAY['https://fundloop-website.vercel.app/en', 'https://fundloop.org']::text[]
WHERE name = 'FundLoop';

UPDATE public.programs
SET min_age = 18,
    max_age = 29,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'managed_application',
    available_regions = ARRAY['Canada']::text[],
    required_states = ARRAY['New Brunswick']::text[],
    municipalities = ARRAY['Moncton', 'Saint John']::text[],
    sources = ARRAY['https://www2.gnb.ca']::text[]
WHERE name = 'New Brunswick Youth Basic Income Pilot';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Planned',
    status = 'upcoming',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Illinois']::text[],
    municipalities = ARRAY['Cook County', 'Chicago']::text[],
    sources = ARRAY['https://www.cookcountyil.gov/promise', 'https://arpa.cookcountyil.gov/promise-guaranteed-income-pilot-program']::text[]
WHERE name = 'Cook County Promise Guaranteed Income Program — Next Phase';

UPDATE public.programs
SET min_age = 60,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Planned',
    status = 'upcoming',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['California']::text[],
    municipalities = ARRAY['San Joaquin County', 'Stockton']::text[],
    sources = ARRAY['https://www.cdss.ca.gov/inforesources/guaranteed-income-pilot-program/older-californians', 'https://www.cdss.ca.gov/Portals/9/GIPP/2025-intent-award-final.pdf', 'https://www.givedirectly.org/cashsjc', 'https://cashsjc.aidkit.org/apply']::text[]
WHERE name = 'California Guaranteed Income Pilot Program for Older Californians (CASH SJC)';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = 'female',
    max_household_income_usd = 44000,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['New York', 'Arkansas', 'Maryland', 'Kentucky', 'Ohio', 'West Virginia', 'Tennessee']::text[],
    municipalities = ARRAY['New York', 'Baltimore', 'Appalachia']::text[],
    sources = ARRAY['https://www.bridgeproject.org/', 'https://www.bridgeproject.org/apply', 'https://governor.maryland.gov/news/press-releases/governor-moore-announces-partnership-bridge-project']::text[]
WHERE name = 'The Bridge Project';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = 'female',
    max_household_income_usd = 12000,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Mississippi']::text[],
    municipalities = ARRAY['Jackson']::text[],
    sources = ARRAY['https://springboardto.org/socioeconomic-well-being/magnolia-mothers-trust/', 'https://springboardto.org/the-7th-cohort/']::text[]
WHERE name = 'The Magnolia Mother’s Trust';

UPDATE public.programs
SET min_age = 16,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'lottery_raffle',
    payout_rail = 'direct_deposit',
    funding_source = 'community_crowdfund',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Global']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Global']::text[],
    sources = ARRAY['https://www.ubi4all.org/', 'https://www.ubi4all.org/register', 'https://www.ubi4all.org/terms-and-conditions']::text[]
WHERE name = 'UBI4ALL European Basic Income Raffle';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Minnesota']::text[],
    municipalities = ARRAY['Saint Paul', 'Otter Tail County']::text[],
    sources = ARRAY['https://springboardforthearts.org/programs/guaranteed-income/', 'https://springboardforthearts.org/wp-content/uploads/2023/02/Press_Release_GMI_2023_SBftA.pdf']::text[]
WHERE name = 'Guaranteed Income for Artists';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['California']::text[],
    municipalities = ARRAY['Sacramento']::text[],
    sources = ARRAY['https://www.cityofsacramento.gov/ccs/oac/funding-and-grants/creative-growth-fellowship-program.html', 'https://sacramentocityexpress.com/2025/09/05/city-awards-2-04-million-to-200-artists-through-creative-growth-fellowship/']::text[]
WHERE name = 'Sacramento Creative Growth Fellowship Program';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 80000,
    application_status = 'Pilot completed',
    status = 'closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Massachusetts']::text[],
    municipalities = ARRAY['Boston']::text[],
    sources = ARRAY['https://campharborview.org/family-services/guaranteed-income-program/', 'https://www.bostonindicators.org/reports/report-detail-pages/dignity-dividend', 'https://www.dotare.io/resources/programs/camp-harbor-view-guaranteed-income-program']::text[]
WHERE name = 'Camp Harbor View Guaranteed Income Program';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 45000,
    application_status = 'Pilot completed',
    status = 'closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia']::text[],
    sources = ARRAY['https://phdcphila.org/phlhousing-plus/', 'https://www.housinginitiative.org/phlhousing.html', 'https://www.housinginitiative.org/phlhousing-housing-outcomes-at-two-years.html', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC11938205/']::text[]
WHERE name = 'PHLHousing+';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 30000,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia', 'Delaware Valley']::text[],
    sources = ARRAY['https://clinicaltrials.gov/study/NCT06611982', 'https://pc3i.upenn.edu/our-work/projects/giftt/', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects', 'https://www.federalregister.gov/documents/2023/03/31/2023-06706/guaranteed-income-financial-treatment-trial-giftt']::text[]
WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment Pilot';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia']::text[],
    sources = ARRAY['https://philacityfund.org/rfp-gbi/', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects', 'https://philacityfund.org/wp-content/uploads/2022/12/RFP-HVIP-GBI-Pilot-2022_final.pdf']::text[]
WHERE name = 'Guaranteed Income for Survivors of Firearm Violence';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Philadelphia']::text[],
    sources = ARRAY['https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[]
WHERE name = 'Network Economic Support Transfers (NEST) Pilot';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'philanthropic_grant',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY['Pennsylvania']::text[],
    municipalities = ARRAY['Pittsburgh', 'Allegheny County']::text[],
    sources = ARRAY['https://unitedwayswpa.org/our-impact/community-change-collaboratives/thriving-providers-project/', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[]
WHERE name = 'Thriving Providers Project — Pittsburgh';

UPDATE public.programs
SET min_age = NULL,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 850,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Brazil']::text[],
    required_states = ARRAY['Rio de Janeiro']::text[],
    municipalities = ARRAY['Maricá']::text[],
    sources = ARRAY['https://rendabasicacidadania.marica.rj.gov.br/', 'https://www.marica.rj.gov.br/noticia/prefeitura-de-marica-segue-com-recadastramento-do-programa-de-renda-basica-de-cidadania/']::text[]
WHERE name = 'Programa de Renda Básica de Cidadania de Maricá';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 500,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Brazil']::text[],
    required_states = ARRAY['Rio de Janeiro']::text[],
    municipalities = ARRAY['Niterói']::text[],
    sources = ARRAY['https://niteroi.rj.gov.br/arariboia/', 'https://niteroi.rj.gov.br/assistencia-social-de-niteroi-inicia-entrega-dos-novos-cartoes-da-moeda-arariboia/', 'https://niteroi.rj.gov.br/prefeito-rodrigo-neves-sanciona-reajuste-de-12-da-moeda-arariboia-e-anuncia-abono-natalino-para-50-mil-familias/']::text[]
WHERE name = 'Moeda Social Arariboia';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = 600,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Brazil']::text[],
    required_states = ARRAY['Rio de Janeiro']::text[],
    municipalities = ARRAY['Saquarema']::text[],
    sources = ARRAY['https://www.saquarema.rj.gov.br/prefeitura-vai-iniciar-recadastramento-da-moeda-social-saqua/', 'https://transparencia.saquarema.rj.gov.br/wp-content/uploads/2026/07/Lei2881_01072026112424.pdf', 'https://transparencia.saquarema.rj.gov.br/wp-content/uploads/2022/02/LO-2189-2022.pdf']::text[]
WHERE name = 'Renda Básica da Cidadania de Saquarema';

UPDATE public.programs
SET min_age = 24,
    max_age = 24,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'prepaid_card',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['South Korea']::text[],
    required_states = ARRAY['Gyeonggi Province']::text[],
    municipalities = ARRAY['Participating Municipalities']::text[],
    sources = ARRAY['https://apply.jobaba.net/special/gibon/main.do', 'https://youth.gg.go.kr/gg/intro/youth-policy-housing-test.do?articleNo=8940&mode=view', 'https://gnews.gg.go.kr/news/news_detail.do?number=202603191948215837C094&s_code=C094']::text[]
WHERE name = 'Gyeonggi Youth Basic Income';

UPDATE public.programs
SET min_age = 19,
    max_age = 34,
    gender_requirement = NULL,
    max_household_income_usd = 35000,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'municipal_government',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['South Korea']::text[],
    required_states = ARRAY['Seoul']::text[],
    municipalities = ARRAY['Seoul']::text[],
    sources = ARRAY['https://youth.seoul.go.kr/infoData/plcyInfo/view.do?key=2309150002&plcyBizId=V202600005&sprtInfoId=', 'https://news.seoul.go.kr/gov/archives/578136', 'https://mediahub.seoul.go.kr/archives/2018273']::text[]
WHERE name = 'Seoul Youth Allowance';

UPDATE public.programs
SET min_age = NULL,
    max_age = 17,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Accepting applications',
    status = 'active_open',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'state_federal',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['Poland']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide', 'Warsaw']::text[],
    sources = ARRAY['https://www.zus.pl/swiadczenia/swiadczenia-dla-rodzin/swiadczenie-wychowawcze-800-plus', 'https://www.zus.pl/-/mo%C5%BCna-ju%C5%BC-sk%C5%82ada%C4%87-wnioski-o-800-na-nowy-okres-%C5%9Bwiadczeniowy', 'https://www.gov.pl/web/gov/skorzystaj-z-programu-rodzina-500']::text[]
WHERE name = 'Rodzina 800+';

UPDATE public.programs
SET min_age = 18,
    max_age = NULL,
    gender_requirement = NULL,
    max_household_income_usd = NULL,
    application_status = 'Ongoing',
    status = 'active_closed',
    distribution_type = 'guaranteed_recurrent',
    payout_rail = 'direct_deposit',
    funding_source = 'community_crowdfund',
    involvement_level = 'external_self_apply',
    available_regions = ARRAY['United States']::text[],
    required_states = ARRAY[]::text[],
    municipalities = ARRAY['Nationwide', 'San Francisco']::text[],
    sources = ARRAY['https://www.comingle.us/', 'https://www.comingle.us/faqs']::text[]
WHERE name = 'Comingle';