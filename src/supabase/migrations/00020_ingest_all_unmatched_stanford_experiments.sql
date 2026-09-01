-- Migration 00020: Ingest all qualified Stanford experiments
DELETE FROM public.programs WHERE program_id >= 100;

-- 1. Fix handle_new_program_submission to use submitter_email

CREATE OR REPLACE FUNCTION public.handle_new_program_submission()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS 33517
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
33517;

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    101,
    'Alaska Permanent Dividend Fund',
    'Alaska Dept of Revenue',
    'Alaska Permanent Dividend Fund is a guaranteed basic income initiative in N/A, organized by Alaska Dept of Revenue. Implemented during January 1982 -. Enrolled 667,047 participants. Data documented by the Stanford Basic Income Lab.',
    93,
    'USD',
    '1114 USD (2021) (yearly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['N/A'],
    NULL,
    NULL,
    NULL,
    NULL,
    '667,047',
    'N/A',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Alaska Permanent Dividend Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Alaska Permanent Dividend Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    102,
    'Embrace Mothers',
    'City of Birmingham',
    'Embrace Mothers is a guaranteed basic income initiative in Birmingham, AL, organized by City of Birmingham. Implemented during March 2022 - February 2023. Enrolled 110 participants. Data documented by the Stanford Basic Income Lab.',
    375,
    'USD',
    '$375 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Birmingham'],
    18,
    NULL,
    'female'::public.program_gender_requirement,
    50000,
    '110',
    '18 years or older, female identifying as single head of a family with children in the household under 18 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Embrace Mothers' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Embrace Mothers'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    103,
    'Returning Home Career Grant',
    'Rubicon Programs',
    'Returning Home Career Grant is a guaranteed basic income initiative in Alameda and Contra Costa Counties, CA, organized by Rubicon Programs. Implemented during May 2021 - May 2022. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alameda and Contra Costa Counties'],
    NULL,
    NULL,
    NULL,
    NULL,
    '25',
    'Primarily black and brown individuals returning home after incarceration',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Returning Home Career Grant' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Returning Home Career Grant'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    104,
    'Community-Based Roads to Prosperity',
    'United Way Bay Area',
    'Community-Based Roads to Prosperity is a guaranteed basic income initiative in Alameda County, CA, organized by United Way Bay Area. Implemented during 8/1/2024 - 1/1/2025. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alameda County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Individuals over the age of 18 who received services from SparkPoint Oakland, SparkPoint Fremont, and/or SparkPoint at Chabot College prior to July 31, 2024, regardless of citizenship or immigration status',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Community-Based Roads to Prosperity' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Community-Based Roads to Prosperity'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    105,
    'NET Growth Movement',
    'Bay Area Community Services',
    'NET Growth Movement is a guaranteed basic income initiative in Alameda County, CA, organized by Bay Area Community Services. Implemented during 1/1/2023 - 12/31/2025. Enrolled 67 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alameda County'],
    18,
    24,
    NULL,
    NULL,
    '67',
    'Former non-minor dependents who exited the foster youth system in 2022 or who would''ve exited in 2022',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'NET Growth Movement' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'NET Growth Movement'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    106,
    'Coco Go BIG',
    'Comment Studio',
    'Coco Go BIG is a guaranteed basic income initiative in Antioch, CA, organized by Comment Studio. Implemented during 1/15/2024 - 6/15/2024. Enrolled 30 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD for adults, 200 USD for foster youth (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['94509, 94531', 'Antioch'],
    18,
    24,
    NULL,
    NULL,
    '30',
    'The Sycamore corridor in Antioch.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Coco Go BIG' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Coco Go BIG'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    107,
    'Rise Up Alameda',
    'City of Alameda',
    'Rise Up Alameda is a guaranteed basic income initiative in Alameda, CA, organized by City of Alameda. Implemented during 12/15/2023 - 12/15/2025. Enrolled 150 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['94501 and 94502 zip codes', 'Alameda'],
    18,
    NULL,
    NULL,
    NULL,
    '150',
    'Must be living in the City of Alameda; must be 18 years of age or older; and have a yearly household income at or below 50% of average median income of Alameda County',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rise Up Alameda' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rise Up Alameda'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    108,
    'ELEVATE Concord: Family Economic Equity Pilot',
    'Monument Impact',
    'ELEVATE Concord: Family Economic Equity Pilot is a guaranteed basic income initiative in Concord, CA, organized by Monument Impact. Implemented during 11/6/2023 - 10/31/2024. Enrolled 120 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD + one time stabilization gift of 2,500 USD at start of pilot (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Concord'],
    NULL,
    12,
    NULL,
    NULL,
    '120',
    'Single parent, has at least one child under 12 years old, makes less than 55k',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'ELEVATE Concord: Family Economic Equity Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'ELEVATE Concord: Family Economic Equity Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    109,
    'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program',
    'Mission Asset Fund (MAF)',
    'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program is a guaranteed basic income initiative in Coachella, CA, organized by Mission Asset Fund (MAF). Implemented during October 2022 - 2024. Enrolled 140 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Coachella'],
    18,
    NULL,
    NULL,
    NULL,
    '140',
    '18 years of age or older, who have a current, non-expired, government-issued photo ID, at least one child under the age of 12 who was living in the household in 2021, earned less than $75,000 in 2021 or have a total household income below $150,000 in 2021, and have filed a 2019 or 2020 tax return or gave the IRS information as a non-filer in 2020 or 2021',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    110,
    'Compton Pledge',
    'City of Compton',
    'Compton Pledge is a guaranteed basic income initiative in Compton, CA, organized by City of Compton. Implemented during December 2020 - November 2022. Enrolled 800 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '300, 400 and 600 USD (bi-weekly or quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Compton'],
    NULL,
    NULL,
    NULL,
    NULL,
    '800',
    'Individuals who are low-income, including people who are undocumented and who are formerly incarcerated',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Compton Pledge' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Compton Pledge'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    111,
    'Family Income for Empowerment Program',
    'Jewish Family Service of San Diego',
    'Family Income for Empowerment Program is a guaranteed basic income initiative in County of San Diego, CA, organized by Jewish Family Service of San Diego. Implemented during 7/1/2023 - 12/31/2026. Enrolled 485 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['County of San Diego'],
    NULL,
    18,
    NULL,
    40000,
    '485',
    '1. Referred by  County of San Diego Department of Child and Family Well-Being (Inconclusive or substantiated allegations of general neglect, physical abuse, or emotional abuse with no new opened child welfare case);

2. Resident of San Diego County (priority for unhoused families and those residing in the 39 Health Equity ZIP codes);

3. At least one child in the household under 18 ;

4. Annual household income at or below 200% of the Federal Poverty Level (FPL);

5. Able to provide identity and income documentation for eligibility verification.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Income for Empowerment Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Income for Empowerment Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    112,
    'City of El Monte Guaranteed Income Program',
    'City of El Monte',
    'City of El Monte Guaranteed Income Program is a guaranteed basic income initiative in El Monte, CA, organized by City of El Monte. Enrolled 125 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['El Monte'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    40000,
    '125',
    'Program is applicable to female heads of households living within El motne City Limits and making below the poverty line and were financially impacted by the COVID-19 pandemic.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'City of El Monte Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'City of El Monte Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    113,
    'Advancing Fresno County Guaranteed Income',
    'Fresno EOC',
    'Advancing Fresno County Guaranteed Income is a guaranteed basic income initiative in Fresno, CA, organized by Fresno EOC. Implemented during 7/1/2024 - July 2025. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Zipcodes 93706 and 93234', 'Fresno'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '150',
    'Residents in the 93706 (Southwest Fresno) or 93234 (Huron) zipcodes, who are adults over 18, and pregnant or have a child under five, are eligible if they have an income that is 80 percent or less of the Area Median Income. For Huron residents that would be $35,103 or less, and $30,615 or less for those residing in Southwest Fresno.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Advancing Fresno County Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Advancing Fresno County Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    114,
    'HIP (Humboldt Income Program)',
    'McKinleyville Family Resource Center (McKinleyville Community Collaborative)',
    'HIP (Humboldt Income Program) is a guaranteed basic income initiative in Humboldt County, CA, organized by McKinleyville Family Resource Center (McKinleyville Community Collaborative). Implemented during 1/25/2024 - 11/25/2025. Enrolled 150 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    920,
    'USD',
    '920 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Humboldt County'],
    NULL,
    28,
    'female'::public.program_gender_requirement,
    40000,
    '150',
    'Pregnant people in 1 st or 2nd trimester of pregnancy (under  28 weeks pregnant) during the enrollment period (December  2023-May 2024),18 years old or over and living in Humboldt County. At 200% or below of the federal poverty level not including  unborn child.

Referrals to the program will be through local medical providers to relieve administrative burdens on clients and require less documentation.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'HIP (Humboldt Income Program)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'HIP (Humboldt Income Program)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    115,
    'Breathe: LA County''s Guaranteed Income Program',
    'Strength Based Community Change',
    'Breathe: LA County''s Guaranteed Income Program is a guaranteed basic income initiative in LA County, CA, organized by Strength Based Community Change. Implemented during June 2022 - July 2025. Enrolled 1000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['LA County'],
    NULL,
    NULL,
    NULL,
    96000,
    '1000',
    'Individuals 18 and older who reside in a neighborhood identified as being at or below LA County’s Area Median Income (AMI), in a single person household that falls at or below AMI or a household with two or more persons that falls at or below 120% AMI, and have been financially negatively affected by the COVID-19 pandemic.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Breathe: LA County''s Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Breathe: LA County''s Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    116,
    'LA County Breathe - Former Foster Youth Expansion 1',
    'Strength Based Community Change',
    'LA County Breathe - Former Foster Youth Expansion 1 is a guaranteed basic income initiative in LA County, CA, organized by Strength Based Community Change. Implemented during 2023-8/31/2025. Enrolled 200 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['LA County'],
    21,
    24,
    NULL,
    NULL,
    '200',
    'Former foster youth ages 21 to 24.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'LA County Breathe - Former Foster Youth Expansion 1' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'LA County Breathe - Former Foster Youth Expansion 1'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    117,
    'LA County Breathe - Former Foster Youth Expansion 2',
    'Strength Based Community Change',
    'LA County Breathe - Former Foster Youth Expansion 2 is a guaranteed basic income initiative in LA County, CA, organized by Strength Based Community Change. Implemented during 2024-4/30/2026. Enrolled 2000 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['LA County'],
    18,
    21,
    NULL,
    NULL,
    '2000',
    'Former foster youth ages 18 to 21. Payments provided as $500 monthly or $1,500 quarterly.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'LA County Breathe - Former Foster Youth Expansion 2' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'LA County Breathe - Former Foster Youth Expansion 2'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    118,
    'TAYportunity Guaranteed Income Program',
    'LA County DPSS',
    'TAYportunity Guaranteed Income Program is a guaranteed basic income initiative in LA County, CA, organized by LA County DPSS. Implemented during 8/1/2022 - 8/1/2025. Enrolled 300 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['LA County'],
    18,
    24,
    NULL,
    NULL,
    '300',
    'Youth between the ages of 18 and 24 who are currently receiving County employment services through the General Relief Opportunities for Work (GROW) Program.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'TAYportunity Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'TAYportunity Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    119,
    'Long Beach Guaranteed Income Pilot Program',
    'City of Long Beach',
    'Long Beach Guaranteed Income Pilot Program is a guaranteed basic income initiative in Long Beach, CA, organized by City of Long Beach. Implemented during 3/1/2024 - 2/1/2025. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['90802, 90804, 90805,90806, and 90810 zipcodes', 'Long Beach'],
    NULL,
    NULL,
    NULL,
    40000,
    '200',
    'Households with dependent children and gross household income (before taxes) of 100% or less of the federal poverty level. This number depends on how many individuals are in your household/family unit. Long Beach residents in the 90802, 90804, 908095,90806, and 90810 zipcode.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Long Beach Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Long Beach Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    120,
    'Long Beach Pledge (Cohort 1)',
    'City of Long Beach',
    'Long Beach Pledge (Cohort 1) is a guaranteed basic income initiative in Long Beach, CA, organized by City of Long Beach. Implemented during November 2022 - October 2023. Enrolled 250 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['90813 Zip code', 'Long Beach'],
    NULL,
    NULL,
    NULL,
    40000,
    '250',
    'Single headed families (families with dependents and a single income earner), with incomes at or below the federal poverty level in the 90813 zip-code, with a gross household income (before taxes) of 100% or less of the federal poverty level, based on household size.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Long Beach Pledge (Cohort 1)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Long Beach Pledge (Cohort 1)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    121,
    'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot)',
    'City of Los Angeles',
    'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot) is a guaranteed basic income initiative in Los Angeles, CA, organized by City of Los Angeles. Implemented during January 2022 - March 2023. Enrolled 3204 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles'],
    18,
    45,
    'female'::public.program_gender_requirement,
    40000,
    '3204',
    'Individuals at or below the Federal Poverty Line based on household size facing economic and/or medical hardship from COVID-19, and with at least one dependent child (younger than 18 or a student younger than 24) or are pregnant',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    122,
    'Family Goal Fund',
    'LIFT',
    'Family Goal Fund is a guaranteed basic income initiative in Los Angeles, CA, organized by LIFT. Implemented during January 2018 -. Enrolled 800+ participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '150 USD (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles'],
    NULL,
    NULL,
    NULL,
    NULL,
    '800+',
    'Households in the LIFT program with low-income and children 0-8 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Goal Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Goal Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    123,
    'BOOST: Building Outstanding Opportunities for Students to Thrive',
    'Foundation for the Los Angeles Community Colleges',
    'BOOST: Building Outstanding Opportunities for Students to Thrive is a guaranteed basic income initiative in Students of East LA College, LA Southwest College, LA City College, and/or LA Trade-Tech College, organized by Foundation for the Los Angeles Community Colleges. Implemented during 11/25/2024 - 10/15/2025. Enrolled 251 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Students of East LA College'],
    NULL,
    NULL,
    NULL,
    NULL,
    '251',
    'BOOST aims to help bridge the gap between financial aid, wages, and the cost of living for students attending the Los Angeles Community College District (LACCD) and pursuing careers in clinical, allied, and behavioral healthcare. This program enrolled a cohort of 251 students to receive a guaranteed payment of $1000 per month over a one-year period. BOOST includes a mixed-methods evaluation with a randomized controlled trial (RCT) conducted by the Center for Guaranteed Income Research (CGIR) at the University of Pennsylvania. Students who met all of the eligibility criteria were invited to apply to participate in BOOST. Eligible students who completed the online application were randomly assigned to one of three groups: treatment, control, or non-participants. The evaluation included 251 individuals in the treatment group receiving the payments and 370 individuals in the control group. All costs associated with the project are funded by private donors.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'BOOST: Building Outstanding Opportunities for Students to Thrive' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'BOOST: Building Outstanding Opportunities for Students to Thrive'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    124,
    'Pregnancy Assistance Income with Dignity (P.A.I.D.)',
    'National Council of Jewish Women | Los Angeles (NCJW|LA)',
    'Pregnancy Assistance Income with Dignity (P.A.I.D.) is a guaranteed basic income initiative in Los Angeles County, organized by National Council of Jewish Women | Los Angeles (NCJW|LA). Implemented during 4/8/2024 - 3/1/2026. Enrolled 180 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '180',
    'Pregnant People over age 18 who are in their 1st or 2nd trimester of pregnancy and live in Los Angeles County and are not participating in another GI program, with income within HUD 2023 Adjusted Low-Income levels. The RCT evaluation includes 180 individuals in the treatment group and 180 in the control group.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Pregnancy Assistance Income with Dignity (P.A.I.D.)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Pregnancy Assistance Income with Dignity (P.A.I.D.)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    125,
    'NCJWLA Guaranteed Income Project',
    'National Council of Jewish Women-LA',
    'NCJWLA Guaranteed Income Project is a guaranteed basic income initiative in Los Angeles, CA, organized by National Council of Jewish Women-LA. Implemented during July 2021 - July 2022. Enrolled 12 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '12',
    'Individuals who identify as women earning between 50-80% of area-level median income in caregiving/healthcare professions',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'NCJWLA Guaranteed Income Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'NCJWLA Guaranteed Income Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    126,
    'Miracle Money',
    'Miracle Messages',
    'Miracle Money is a guaranteed basic income initiative in Los Angeles, San Francisco, and Oakland, CA, organized by Miracle Messages. Implemented during May 2022 - July 2024. Enrolled 103 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles'],
    NULL,
    NULL,
    NULL,
    NULL,
    '103',
    'Unhoused individuals who expressed interest in the Miracle Friends program',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Miracle Money' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Miracle Money'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    127,
    'MOMentum',
    'Marin Community Foundation',
    'MOMentum is a guaranteed basic income initiative in Marin County, CA, organized by Marin Community Foundation. Implemented during June 2021 - May 2023. Enrolled 125 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Marin County'],
    NULL,
    18,
    'female'::public.program_gender_requirement,
    NULL,
    '125',
    'Women of color with low income and children under 18',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'MOMentum' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'MOMentum'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    128,
    'Alas',
    'Ventures',
    'Alas is a guaranteed basic income initiative in Monterey Bay Area, CA, organized by Ventures. Implemented during 2022 -. Enrolled 60+ participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Monterey Bay Area'],
    NULL,
    NULL,
    NULL,
    50000,
    '60+',
    'Designed to help working class Latino families build community, self-determination, and financial stability. Structured as a cohort model. Participants also receive monthly workshops and financial coaching.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Alas' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Alas'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    129,
    'Elevate MV',
    'City of Mountain View',
    'Elevate MV is a guaranteed basic income initiative in Mountain View, CA, organized by City of Mountain View. Implemented during November 2022 - October 2023. Enrolled 166 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Mountain View'],
    NULL,
    NULL,
    NULL,
    50000,
    '166',
    'Households with an income below 30% Area Median Income (AMI), and parents/custodial caregiver for at least one child under the age of 18 at the time of application.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Elevate MV' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Elevate MV'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    130,
    'Miracle Money  - Thriving Community Fund (TCF) expansion',
    'Miracle Messages',
    'Miracle Money  - Thriving Community Fund (TCF) expansion is a guaranteed basic income initiative in Multiple communities in CA, organized by Miracle Messages. Implemented during 2025 -. Enrolled 110 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Multiple communities in CA'],
    NULL,
    NULL,
    NULL,
    NULL,
    '110',
    'The TCF is an expansion of Miracle Message''s Miracle Money program. It is a statewide pilot designed to test the impact of combining direct, unconditional cash assistance for unhoused individuals with established, trust-based relationships delivered through community-based organizations.  TCF was implemented through partnerships with community-based organizations that have deep roots, cultural competence, and longstanding relationships with populations experiencing housing instability. Rather than imposing a single service model, TCF intentionally leaned into each organization’s leadership, allowing partners to adapt the cash intervention to their population and local and organizational context.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Miracle Money  - Thriving Community Fund (TCF) expansion' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Miracle Money  - Thriving Community Fund (TCF) expansion'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    131,
    'Abundant Birth Project',
    'Expecting Justice',
    'Abundant Birth Project is a guaranteed basic income initiative in San Francisco, CA, organized by Expecting Justice. Implemented during 6/1/2021- 1/30/2024. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '150',
    'Black or Pacific Islander pregnant people in their 1st or 2nd trimester and making less than $100,000',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Abundant Birth Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Abundant Birth Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    132,
    'California Abundant Birth Project',
    'Expecting Justice',
    'California Abundant Birth Project is a guaranteed basic income initiative in Alameda County, CA, organized by Expecting Justice. Implemented during 1/29/2024 - 4/30/2026. Enrolled 950 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600-1,000 USD depending on county (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alameda County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '950',
    'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'California Abundant Birth Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'California Abundant Birth Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    133,
    'California Abundant Birth Project — Contra Costa County, CA',
    'Expecting Justice',
    'California Abundant Birth Project is a guaranteed basic income initiative in Contra Costa County, CA, organized by Expecting Justice. Implemented during 1/29/2024 - 4/30/2026. Enrolled 950 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600-1,000 USD depending on county (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Contra Costa County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '950',
    'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'California Abundant Birth Project — Contra Costa County, CA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'California Abundant Birth Project — Contra Costa County, CA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    134,
    'California Abundant Birth Project — Los Angeles County, CA',
    'Expecting Justice',
    'California Abundant Birth Project is a guaranteed basic income initiative in Los Angeles County, CA, organized by Expecting Justice. Implemented during 1/29/2024 - 4/30/2026. Enrolled 950 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600-1,000 USD depending on county (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Los Angeles County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '950',
    'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'California Abundant Birth Project — Los Angeles County, CA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'California Abundant Birth Project — Los Angeles County, CA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    135,
    'California Abundant Birth Project — Riverside County',
    'Expecting Justice',
    'California Abundant Birth Project is a guaranteed basic income initiative in Riverside County, organized by Expecting Justice. Implemented during 1/29/2024 - 4/30/2026. Enrolled 950 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600-1,000 USD depending on county (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Riverside County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '950',
    'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'California Abundant Birth Project — Riverside County' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'California Abundant Birth Project — Riverside County'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    136,
    'Restorative Reentry Fund',
    'UpTogether',
    'Restorative Reentry Fund is a guaranteed basic income initiative in Oakland, CA, organized by UpTogether. Implemented during 2/1/2023 - 9/1/2024. Enrolled 38 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 a month for 12 months, followed by $500 a month for six months (monthly (variable amounts))',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Oakland'],
    NULL,
    NULL,
    NULL,
    NULL,
    '38',
    'Justice-affected individuals',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Restorative Reentry Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Restorative Reentry Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    137,
    'Oakland Resilient Families',
    'UpTogether',
    'Oakland Resilient Families is a guaranteed basic income initiative in Oakland, CA, organized by UpTogether. Implemented during June 2021 - June 2024. Enrolled 600 (2 cohorts) participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Oakland', 'East Oakland'],
    NULL,
    50,
    NULL,
    40000,
    '600 (2 cohorts)',
    'Cohort 1: Individuals in a one square mile area of East Oakland with an income under 50% of area level median and at least one child under 18.
Cohort 2: Households with an income of no more than 138% of the Federal Poverty Line based on household size, and at least one child under 18',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Oakland Resilient Families' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Oakland Resilient Families'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    138,
    'Miracle Money — Oakland, San Francisco, and Los Angeles, CA',
    'Miracle Messages',
    'Miracle Money is a guaranteed basic income initiative in Oakland, San Francisco, and Los Angeles, CA, organized by Miracle Messages. Implemented during May 2022 - July 2024. Enrolled 103 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Oakland'],
    NULL,
    NULL,
    NULL,
    NULL,
    '103',
    'Unhoused individuals who expressed interest in the Miracle Friends program',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Miracle Money — Oakland, San Francisco, and Los Angeles, CA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Miracle Money — Oakland, San Francisco, and Los Angeles, CA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    139,
    'Palm Springs'' Universal Basic Income pilot',
    'DAP Health',
    'Palm Springs'' Universal Basic Income pilot is a guaranteed basic income initiative in Palm Springs, CA, organized by DAP Health. Implemented during 2022 to May 2025. Enrolled 14 participants. Data documented by the Stanford Basic Income Lab.',
    800,
    'USD',
    '$800 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Palm Springs'],
    NULL,
    NULL,
    NULL,
    NULL,
    '14',
    'Individuals who lived, worked, or spent most of their time in the City of Palm Springs and had income of less than $17,000 per year.  Program management was transferred to DAP Health in 2024 after mismanagement by a previous nonprofit partner.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Palm Springs'' Universal Basic Income pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Palm Springs'' Universal Basic Income pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    140,
    'City of Pomona Household Universal Grants Pilot Program (Pomona HUG)',
    'City of Pomona',
    'City of Pomona Household Universal Grants Pilot Program (Pomona HUG) is a guaranteed basic income initiative in Pomona, CA, organized by City of Pomona. Implemented during Aug 2024 - Dec 2025. Enrolled 600 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Pomona'],
    18,
    NULL,
    NULL,
    NULL,
    '600',
    'Resident of Pomona, 18 years or older, parent or legal guardian of a child under 4 years old, meet ARPA requirement. Treament group included 250 participants receiving $500 per month, control group included 350 participants receiving $20 per month.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'City of Pomona Household Universal Grants Pilot Program (Pomona HUG)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'City of Pomona Household Universal Grants Pilot Program (Pomona HUG)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    141,
    'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program',
    'Inland Southern California United Way',
    'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program is a guaranteed basic income initiative in Riverside County, San Bernardino County, CA, organized by Inland Southern California United Way. Implemented during 1/25/2024 - 3/25/2027. Enrolled 620 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '$600 Pregnant; $750 FFY (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Riverside County'],
    18,
    24,
    'female'::public.program_gender_requirement,
    NULL,
    '620',
    'Pregnant People in Riverside County; those aging out of extended foster care at 21 in Riverside or San Bernardino Counties',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    142,
    'Creative Growth Fellowship',
    'City of Sacramento',
    'Creative Growth Fellowship is a guaranteed basic income initiative in Sacramento, CA, organized by City of Sacramento. Implemented during 9/1/2025 - 8/31/2026. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    850,
    'USD',
    '$850 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento'],
    NULL,
    NULL,
    NULL,
    NULL,
    '200',
    'Artists living in the City of Sacramento',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Creative Growth Fellowship' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Creative Growth Fellowship'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    143,
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1',
    'United Way California Capital Region',
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1 is a guaranteed basic income initiative in Sacramento, CA, organized by United Way California Capital Region. Implemented during 6/1/2021 - 5/31/2023. Enrolled 100 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    144,
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2',
    'United Way California Capital Region',
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2 is a guaranteed basic income initiative in Sacramento, CA, organized by United Way California Capital Region. Implemented during 7/1/2023 - 6/30/2024. Enrolled 80 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento'],
    NULL,
    NULL,
    NULL,
    NULL,
    '80',
    'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    145,
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3',
    'United Way California Capital Region',
    'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3 is a guaranteed basic income initiative in Sacramento, CA, organized by United Way California Capital Region. Implemented during 1/1/2024 - 12/31/2024. Enrolled 130 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento'],
    NULL,
    NULL,
    NULL,
    NULL,
    '130',
    'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    146,
    'Collegiate Guaranteed Income Program',
    'United Way California Capital Region (UWCCR)',
    'Collegiate Guaranteed Income Program is a guaranteed basic income initiative in Sacramento and Davis, CA, organized by United Way California Capital Region (UWCCR). Implemented during May 2024 - June 2026. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento and Davis'],
    18,
    24,
    NULL,
    NULL,
    '20',
    'Former foster youth attending college and part of the Guardian Scholars programs at Sacramento State University and University of California, Davis',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Collegiate Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Collegiate Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    147,
    'Family First Economic Support Pilot',
    'Sacramento County Division of Child',
    'Family First Economic Support Pilot is a guaranteed basic income initiative in Sacramento County, CA, organized by Sacramento County Division of Child. Implemented during 2023 -. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    725,
    'USD',
    '$725 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sacramento County', 'Zip codes 95815, 95821, 95823, 95825, 95828​​​ and 95838'],
    NULL,
    NULL,
    NULL,
    40000,
    '200',
    'Residents of targeted zip codes who are parents or legal guardians of a child aged 0 to 5 with annual household income of less than 200% of the federal poverty line',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family First Economic Support Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family First Economic Support Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    148,
    'Black Women''s Resilience Project',
    'Café X',
    'Black Women''s Resilience Project is a guaranteed basic income initiative in San Diego, CA, organized by Café X. Implemented during 3/1/2022 - 3/1/2025. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Diego'],
    NULL,
    NULL,
    NULL,
    50000,
    '150',
    'Families selected have at least one child in the family 12 years old or younger, with a maximum income of $53,000 for a family of four.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Black Women''s Resilience Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Black Women''s Resilience Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    149,
    'San Diego for Every Child',
    'San Diego for Every Child',
    'San Diego for Every Child is a guaranteed basic income initiative in San Diego, CA, organized by San Diego for Every Child. Implemented during March 2022 - March 2024. Enrolled 150 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Encanto, Paradise Hills, National City, San Ysidro', 'San Diego'],
    18,
    NULL,
    NULL,
    NULL,
    '150',
    'Individuals 18 years and older in eligible zip codes with at least one child under 12 years of age living in the home',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Diego for Every Child' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Diego for Every Child'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    150,
    'It All Adds Up pilot (Bay Area Thriving Families study)',
    'Compass Family Services',
    'It All Adds Up pilot (Bay Area Thriving Families study) is a guaranteed basic income initiative in San Francisco, CA, organized by Compass Family Services. Implemented during 11/1/2023 -. Enrolled 450 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    50000,
    '450',
    'Targeted to families that recently experienced homelessness who are preparing to exit a rapid re-housing program through Compass Family Services or Hamilton Families. It All Adds Up is a five-year pilot. It includes a randomized controlled trial (RCT) evaluation study -- called Bay Area Thriving Families -- led by the NYU Furman Center Housing Solutions Lab, in collaboration with UC Berkeley Terner Center for Housing Innovation. A total of 450 families will be enrolled in the study, with 225 randomly assigned to the treatment group receiving $1,000 per month and 225 randomly assigned to the control group receiving $50 per month. The pilot specifically aims to determine whether unconditional cash payments to families exiting rapid re-housing programs can help them achieve long-term housing stability. Funding for the pilot and study comes from Google, J-PAL North America, U.S. Dept. of Housing and Urban Development, Russell Sage Foundation, and Robert Wood Johnson Foundation.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'It All Adds Up pilot (Bay Area Thriving Families study)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'It All Adds Up pilot (Bay Area Thriving Families study)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    151,
    'San Francisco''s Guaranteed Income Pilot for Artists (GIPA)',
    'Yerba Buena Center for the Arts (YBCA)',
    'San Francisco''s Guaranteed Income Pilot for Artists (GIPA) is a guaranteed basic income initiative in San Francisco, CA, organized by Yerba Buena Center for the Arts (YBCA). Implemented during 5/1/2021 - 11/1/2022. Enrolled 130 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    NULL,
    '130',
    'Artists who living in San Francisco who were disproportionately impacted by the COVID-19 pandemic',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Francisco''s Guaranteed Income Pilot for Artists (GIPA)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Francisco''s Guaranteed Income Pilot for Artists (GIPA)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    152,
    'BEEM: The Black Economic Equity Movement Project',
    'University of California',
    'BEEM: The Black Economic Equity Movement Project is a guaranteed basic income initiative in San Francisco & Oakland, CA, organized by University of California. Implemented during 11/14/2022 - 8/1/2024. Enrolled 300 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['LIHTC qualified Census tracts', 'San Francisco & Oakland'],
    18,
    24,
    NULL,
    NULL,
    '300',
    'Black young adults (18-24 at the time of enrollment), living in a LIHTC qualified census tract or unhoused, not receiving other GI at the time of enrollment.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'BEEM: The Black Economic Equity Movement Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'BEEM: The Black Economic Equity Movement Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    153,
    'Cash Transfers and Rapid Re-Housing',
    'Abode Services',
    'Cash Transfers and Rapid Re-Housing is a guaranteed basic income initiative in San Francisco Bay Area, CA, organized by Abode Services. Implemented during Feb 2023 - Dec 2027. Enrolled 990 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    800,
    'USD',
    '$800 - $2000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco Bay Area'],
    NULL,
    NULL,
    NULL,
    50000,
    '990',
    'Individuals who have transitioned from homelessness to stable housing and are now exiting Rapid Re-Housing (RRH). This pilot is strucutred as a randomized controlled trial (RCT) with evaluation conducted by LEO at the University of Notre Dame.  Participants receive 12 months of cash transfers when they exit the Abode Services RRH program. The treatment group includes 495 families receiving payments of $1650 ($2000 for families) for the first 4 months, and $800 ($1000 for families) for the final 8 months. The control group includes 495 families receiving $50 per month.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Cash Transfers and Rapid Re-Housing' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Cash Transfers and Rapid Re-Housing'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    154,
    'Project Empower',
    'Tahirih',
    'Project Empower is a guaranteed basic income initiative in San Francisco Bay Area, CA, organized by Tahirih. Implemented during 2/1/2023 - 7/1/2023. Enrolled 10 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco Bay Area'],
    NULL,
    NULL,
    NULL,
    NULL,
    '10',
    '10 Tahirih clients, all survivors of domestic violence with a child or children',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Project Empower' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Project Empower'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    155,
    'San Francisco Housing Stability Fund',
    'Tipping Point Community',
    'San Francisco Housing Stability Fund is a guaranteed basic income initiative in San Francisco Bay Area, CA, organized by Tipping Point Community. Implemented during September 2021 - August 2022. Enrolled 30 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco Bay Area'],
    NULL,
    NULL,
    NULL,
    NULL,
    '30',
    'Individuals phasing out of a 2-year rapid rehousing subsidy',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Francisco Housing Stability Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Francisco Housing Stability Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    156,
    'The Trust Youth Initiative San Francisco',
    'Point Source Youth',
    'The Trust Youth Initiative San Francisco is a guaranteed basic income initiative in San Francisco, CA, organized by Point Source Youth. Implemented during 8/1/2023 - 7/31/2025. Enrolled 45 participants. Data documented by the Stanford Basic Income Lab.',
    1500,
    'USD',
    '$1,500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    18,
    24,
    NULL,
    NULL,
    '45',
    'Transition-age youth (TAY) aged 18-24 who are experiencing homelessness.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Trust Youth Initiative San Francisco' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Trust Youth Initiative San Francisco'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    157,
    'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI)',
    'Yerba Buena Center for the Arts (YBCA)',
    'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI) is a guaranteed basic income initiative in San Francisco, CA, organized by Yerba Buena Center for the Arts (YBCA). Implemented during June 2022 - 2024. Enrolled 60 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    NULL,
    '60',
    'Individuals nominated by six partnering organizations, with years of grassroots work in their communities, that YBCA is calling the Creative Communities Coalition for Guaranteed Income.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    158,
    'Foundations for the Future',
    'San Francisco Human Services Agency (SFHSA)',
    'Foundations for the Future is a guaranteed basic income initiative in San Francisco, CA, organized by San Francisco Human Services Agency (SFHSA). Implemented during 11/1/2023 - 5/31/2025. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    1200,
    'USD',
    '1,200 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    50000,
    '150',
    'At least 21 years old and have aged out of San Francisco extended foster care through Family & Children''s Services or Juvenile Probation on or after January 1, 2022. Have an annual household income of $60,000 or less for a single adult (no children) in San Francisco County, an income floor based on the Insight Center''s Family Needs Calculator.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Foundations for the Future' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Foundations for the Future'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    159,
    'Compass Family Service Basic Income Pilot',
    'Compass Family Services and Wells Fargo Foundation',
    'Compass Family Service Basic Income Pilot is a guaranteed basic income initiative in San Francisco, CA, organized by Compass Family Services and Wells Fargo Foundation. Implemented during October 2021 - March 2022. Enrolled 13 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    350,
    'USD',
    '350 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    50000,
    '13',
    'Families with low-income and children enrolled in Compass Children''s Center',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Compass Family Service Basic Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Compass Family Service Basic Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    160,
    'Miracle Money — San Francisco, Oakland, and Los Angeles, CA',
    'Miracle Messages',
    'Miracle Money is a guaranteed basic income initiative in San Francisco, Oakland, and Los Angeles, CA, organized by Miracle Messages. Implemented during May 2022 - July 2024. Enrolled 103 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Francisco'],
    NULL,
    NULL,
    NULL,
    NULL,
    '103',
    'Unhoused individuals who expressed interest in the Miracle Friends program',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Miracle Money — San Francisco, Oakland, and Los Angeles, CA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Miracle Money — San Francisco, Oakland, and Los Angeles, CA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    161,
    'Guaranteed Income Program for Domestic Violence Survivors',
    'San Mateo County',
    'Guaranteed Income Program for Domestic Violence Survivors is a guaranteed basic income initiative in San Mateo County, CA, organized by San Mateo County. Implemented during 7/1/2025 - 6/30/2026. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Mateo County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Survivors of domestic violence with at least one minor child',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income Program for Domestic Violence Survivors' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Guaranteed Income Program for Domestic Violence Survivors'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    162,
    'Immigrant Families Recovery Program: San Mateo County',
    'Mission Asset Fund (MAF)',
    'Immigrant Families Recovery Program: San Mateo County is a guaranteed basic income initiative in San Mateo County, CA, organized by Mission Asset Fund (MAF). Implemented during February 2022 - December2024. Enrolled 500 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Mateo County'],
    NULL,
    NULL,
    NULL,
    50000,
    '500',
    'Households not eligible to receive a second-round stimulus check (Economic Impact Payment) from the Federal government, have a household income less than 80% area median income ($97,440 for an individual), lost income due to the coronavirus (COVID-19) pandemic, and have not yet received a grant from MAF through the CA College Student Support Fund, LA Young Creatives Fund, or Immigrant Families Fund.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Immigrant Families Recovery Program: San Mateo County' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Immigrant Families Recovery Program: San Mateo County'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    163,
    'San Mateo County Guaranteed Income Program for Former Foster Youth',
    'San Mateo County',
    'San Mateo County Guaranteed Income Program for Former Foster Youth is a guaranteed basic income initiative in San Mateo County, CA, organized by San Mateo County. Implemented during 1/1/2024 - 6/30/2025. Enrolled 70 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Mateo County'],
    18,
    24,
    NULL,
    NULL,
    '70',
    'Current and former foster youth ages 18 up to 22',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Mateo County Guaranteed Income Program for Former Foster Youth' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Mateo County Guaranteed Income Program for Former Foster Youth'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    164,
    'San Mateo County Baby Bonus Pilot Program',
    'First 5 San Mateo County',
    'San Mateo County Baby Bonus Pilot Program is a guaranteed basic income initiative in San Mateo County, CA, organized by First 5 San Mateo County. Implemented during March 2025 -. Enrolled 400 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Mateo County'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    50000,
    '400',
    'San Mateo County birthing parents (with newborn babies) receiving Medi-Cal through the Health Plan of San Mateo may be eligible. Pilot is designed as a randomized controlled trial (RCT). Recipint families receive payments from the time they give birth until their child turns three. The program also brings together key community partners to explore the impact of coordinated care support to families in conjunction with cash aid.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Mateo County Baby Bonus Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Mateo County Baby Bonus Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    165,
    'Aging With Dignity',
    'Destination Home',
    'Aging With Dignity is a guaranteed basic income initiative in Santa Clara County, CA, organized by Destination Home. Enrolled 50 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Monthly basic income support',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    60,
    NULL,
    NULL,
    NULL,
    '50',
    'Vulnerable seniors, a population ineligible for many public benefits and at increasing risk of homelessness',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Aging With Dignity' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Aging With Dignity'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    166,
    'GBI for Unhoused High School Students',
    'County of Santa Clara',
    'GBI for Unhoused High School Students is a guaranteed basic income initiative in Santa Clara County, CA, organized by County of Santa Clara. Enrolled 75 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1200,
    'USD',
    '$1,200 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    60,
    NULL,
    NULL,
    NULL,
    '75',
    'Unhoused high school seniors',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'GBI for Unhoused High School Students' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'GBI for Unhoused High School Students'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    167,
    'GBI for Young Parents',
    'County of Santa Clara',
    'GBI for Young Parents is a guaranteed basic income initiative in Santa Clara County, CA, organized by County of Santa Clara. Enrolled 100 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1200,
    'USD',
    '$1,200 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    14,
    26,
    'female'::public.program_gender_requirement,
    NULL,
    '100',
    'Young parents and pregnant people ages 14 to 26',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'GBI for Young Parents' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'GBI for Young Parents'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    168,
    'Re-Entry Guaranteed Income',
    'Destination Home',
    'Re-Entry Guaranteed Income is a guaranteed basic income initiative in Santa Clara County, CA, organized by Destination Home. Enrolled 100 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1200,
    'USD',
    '$1,200 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Justice-involved individuals recently released from jail or prison who had been incarcerated for at least 6 consecutive months',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Re-Entry Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Re-Entry Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    169,
    'Silicon Valley Guaranteed Income Project',
    'Destination: Home',
    'Silicon Valley Guaranteed Income Project is a guaranteed basic income initiative in Santa Clara County, CA, organized by Destination: Home. Implemented during 12/1/2022 - 11/1/2024. Enrolled 150 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    NULL,
    NULL,
    NULL,
    50000,
    '150',
    'Homeless and unstably housed families',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Silicon Valley Guaranteed Income Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Silicon Valley Guaranteed Income Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    170,
    'Santa Clara County UBI Pilot for Former Foster Youth',
    'My Path',
    'Santa Clara County UBI Pilot for Former Foster Youth is a guaranteed basic income initiative in Santa Clara County, CA, organized by My Path. Implemented during October 2020 - July 2025. Enrolled 122 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 - 1200 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Clara County'],
    18,
    24,
    NULL,
    NULL,
    '122',
    'Young adults 22-24 years of age transitioning out of foster care. First cohort of 72 individuals started payments in October 2020, second cohort of 50 individuals started payments in August 2023.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Santa Clara County UBI Pilot for Former Foster Youth' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Santa Clara County UBI Pilot for Former Foster Youth'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    171,
    'Preserving Our Diversity (POD) Pilot #1',
    'City of Santa Monica',
    'Preserving Our Diversity (POD) Pilot #1 is a guaranteed basic income initiative in Santa Monica, CA, organized by City of Santa Monica. Implemented during November 2017 - December 2018. Enrolled 21 participants. Data documented by the Stanford Basic Income Lab.',
    151,
    'USD',
    '151 - 813 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Monica'],
    NULL,
    NULL,
    NULL,
    NULL,
    '21',
    'Individuals aged 62 or older living in rent-controlled apartments since Jan 2000',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Preserving Our Diversity (POD) Pilot #1' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Preserving Our Diversity (POD) Pilot #1'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    172,
    'Preserving Our Diversity (POD) Pilot #2',
    'City of Santa Monica',
    'Preserving Our Diversity (POD) Pilot #2 is a guaranteed basic income initiative in Santa Monica, CA, organized by City of Santa Monica. Implemented during November 2019 - June 2023. Enrolled 248 -  463 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '750 USD for single person household
1300 USD for 2 person household (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Monica'],
    NULL,
    NULL,
    NULL,
    NULL,
    '248 -  463',
    'Individuals aged 65 or older who have occupied rent controlled apartments since Jan 2000 and have an annual household income equal or less than 50% area median income for LA County',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Preserving Our Diversity (POD) Pilot #2' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Preserving Our Diversity (POD) Pilot #2'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    173,
    'Pathway to Income Equity',
    'First 5 Sonoma County',
    'Pathway to Income Equity is a guaranteed basic income initiative in Sonoma County, CA, organized by First 5 Sonoma County. Implemented during 1/18/2023 - 12/18/2024. Enrolled 305 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Sonoma County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    40000,
    '305',
    'Pregnant and/or parent/guardian of a child 0-5 years of age, Income at less than 185% of Federal Poverty Level, Impacted by COVID-19 (loss of income, housing instability), Sonoma County resident',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Pathway to Income Equity' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Pathway to Income Equity'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    174,
    'Mothers Rising for Guaranteed Basic Income',
    'Rising Communities',
    'Mothers Rising for Guaranteed Basic Income is a guaranteed basic income initiative in South Los Angeles, CA, organized by Rising Communities. Implemented during 3/30/2024 - 3/30/2027. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (250 twice per month) (twice monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['South Los Angeles', 'Live in Watts/Willowbrook (90002, 90059); West Athens (90044, 90047); Broadway Manchester (90003, 90061); Compton (90059, 90223, 90220, 90224, 90221, 90222).'],
    0,
    2,
    'female'::public.program_gender_requirement,
    40000,
    '100',
    'To be eligible, applicants must:  Live in Best Start Region 2 of South Los Angeles, including Watts/Willowbrook 90002, 90059 West Athens 90044, 90047 Broadway Manchester 90003, 90061 Compton 90059, 90223, 90220, 90224, 90221, 90222 Self-identify as a mother, including birthing people, biological or adoptive mothers, legal guardian, or have full caretaking responsibilities Be 18 years old at the time of application deadline Be pregnant or have at least one dependent child ages 0-2 at the time of application deadline, that lives more than 50% of the time with applicant mother/guardian/caretaker Cannot be enrolled in any other GBI pilot program Have a household income of up to 200% of the federal poverty line',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Mothers Rising for Guaranteed Basic Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Mothers Rising for Guaranteed Basic Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    175,
    'South San Francisco Guaranteed Income Program',
    'City of South San Francisco',
    'South San Francisco Guaranteed Income Program is a guaranteed basic income initiative in South San Francisco, CA, organized by City of South San Francisco. Implemented during December 2021 - November 2022. Enrolled 160 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['South San Francisco'],
    18,
    24,
    NULL,
    50000,
    '160',
    'Foster youth aging out of care, single heads of households, families with minor aged children and residents of the city''s lowest income census block tracks.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'South San Francisco Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'South San Francisco Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    176,
    'Stockton Economic Empowerment Demonstration (SEED)',
    'Reinvent Stockton Foundation',
    'Stockton Economic Empowerment Demonstration (SEED) is a guaranteed basic income initiative in Stockton , CA, organized by Reinvent Stockton Foundation. Implemented during February 2019 - February 2021. Enrolled 125 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Stockton'],
    NULL,
    NULL,
    NULL,
    NULL,
    '125',
    'Households in ZIP codes with area-level income under the median of $46,033',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Stockton Economic Empowerment Demonstration (SEED)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Stockton Economic Empowerment Demonstration (SEED)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    177,
    'Ventura County Thrive',
    'Ventura County Health and Human Services Agency',
    'Ventura County Thrive is a guaranteed basic income initiative in Ventura County, CA, organized by Ventura County Health and Human Services Agency. Implemented during 10/10/2023 - 9/30/2025. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1,000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Ventura County'],
    21,
    26,
    NULL,
    NULL,
    '150',
    'Must have exited extended foster care at age 21.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ventura County Thrive' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ventura County Thrive'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    178,
    'West Hollywood Pilot for Guaranteed Income',
    'City of West Hollywood and National Council of Jewish Women-LA',
    'West Hollywood Pilot for Guaranteed Income is a guaranteed basic income initiative in West Hollywood, CA, organized by City of West Hollywood and National Council of Jewish Women-LA. Implemented during August 2022 - January 2024. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['West Hollywood'],
    50,
    NULL,
    NULL,
    40000,
    '25',
    'Individuals 50 years and older, living housed or unhoused in West Hollywood, with an income equal to or less than $41,400 (the ''very low income'' category that is 50% of AMI for Los Angeles County in 2021 as determined by U.S. Department of Housing and Urban Development)',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'West Hollywood Pilot for Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'West Hollywood Pilot for Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    179,
    'Yolo County Basic Income (YOBI)',
    'Yolo County Health and Human Services Agency (HHSA)',
    'Yolo County Basic Income (YOBI) is a guaranteed basic income initiative in Yolo County, CA, organized by Yolo County Health and Human Services Agency (HHSA). Implemented during 4/1/2022 - 3/31/2024. Enrolled 76 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    'Dynamic amount based on family size and other income. The monthly cash transfer amount was calculated by subtracting family income from the California Poverty Measure threshold for that family size (and adding one dollar to the difference), with a floor of $600, maximum of $2449, average of $1289. (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Yolo County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    50000,
    '76',
    'Only CalWORKs households with either a pregnant parent or child under the age of five were eligible to enroll to receive the YOBI payment. Two groups of families were enrolled, those receiving the cash benefit and Housing Support Program (YOBI+ HSP) and those receiving the cash benefit only (YOBI only). 76 families participated, which included about 200 individuals.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Yolo County Basic Income (YOBI)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Yolo County Basic Income (YOBI)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    180,
    'Miracle Money  - Dignity Fund expansion',
    'Miracle Messages',
    'Miracle Money  - Dignity Fund expansion is a guaranteed basic income initiative in California, organized by Miracle Messages. Implemented during December 2024 -. Enrolled 110 participants. Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '110',
    'Dignity Fund is an expansion of Miracle Message''s Miracle Money program. It provides direct cash support for unhoused individuals engaged in long-term support through the Miracle Friends phone buddy program.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Miracle Money  - Dignity Fund expansion' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Miracle Money  - Dignity Fund expansion'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    181,
    'Smooth Transitions',
    'iFoster',
    'Smooth Transitions is a guaranteed basic income initiative in State of California, organized by iFoster. Implemented during 11/14/2023 - 3/1/2026. Enrolled 300 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '750 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['State of California'],
    18,
    24,
    NULL,
    NULL,
    '300',
    'Youth exiting extended foster care at age 21',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Smooth Transitions' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Smooth Transitions'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    182,
    'Respond, Recover and Rebuild',
    'Cherokee Nation',
    'Respond, Recover and Rebuild is a guaranteed basic income initiative in Cherokee Nation, organized by Cherokee Nation. Implemented during June 2021. Enrolled 392,832 participants. Data documented by the Stanford Basic Income Lab.',
    2000,
    'USD',
    '2000 USD (one time)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Cherokee Nation'],
    NULL,
    NULL,
    NULL,
    NULL,
    '392,832',
    'Every Cherokee Nation citizen, and those with a citizenship application with all supporting documentation completed by June 1, 2022',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Respond, Recover and Rebuild' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Respond, Recover and Rebuild'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    183,
    'Thriving Providers Project (CO)',
    'Home Grown',
    'Thriving Providers Project (CO) is a guaranteed basic income initiative in Alamosa, Conejos, Costilla, Denver, Eagle, Garfield, Gunnison, Mineral, Pitkin, Rio Grande, Saguache, organized by Home Grown. Enrolled 100 cash recipients; 55 consented to be part of study participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alamosa'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100 cash recipients; 55 consented to be part of study',
    'Home-based child care providers',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Thriving Providers Project (CO)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Thriving Providers Project (CO)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    184,
    'Elevate Boulder',
    'City of Boulder Housing & Human Services Department',
    'Elevate Boulder is a guaranteed basic income initiative in Boulder, CO, organized by City of Boulder Housing & Human Services Department. Implemented during 1/15/2024 - 1/31/2026. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boulder'],
    NULL,
    NULL,
    NULL,
    NULL,
    '200',
    'Rsidents of the City of Boulder, 18+ years of age, have income between 30 - 60% area median income for Boulder County; and were impacted by COVID-19.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Elevate Boulder' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Elevate Boulder'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    185,
    'Thriving Providers Project (CO) — Boulder, CO',
    'City of Boulder',
    'Thriving Providers Project (CO) is a guaranteed basic income initiative in Boulder, CO, organized by City of Boulder. Implemented during 1/1/2024 - 8/31/2025. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    501,
    'USD',
    '501 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boulder'],
    18,
    NULL,
    NULL,
    64000,
    '20',
    'Low-income (below 80% AMI) x 18 years of age or older at the time of application x City of Boulder resident x Currently providing childcare to at least one child under the age of 5 who is not their own child x Providing at least 20 hours of childcare per week x Unlicensed at the time of application, operating as a license-exempt provider under Colorado regulations (i.e., are caring for no more than four children, or two children under two, at any given time or only a single family).',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Thriving Providers Project (CO) — Boulder, CO' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Thriving Providers Project (CO) — Boulder, CO'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    186,
    'Harrison 2 - Colorado Springs',
    'UpTogether',
    'Harrison 2 - Colorado Springs is a guaranteed basic income initiative in Colorado Springs, CO, organized by UpTogether. Implemented during November 2020 - March 2023. Enrolled 95 participants. Data documented by the Stanford Basic Income Lab.',
    168,
    'USD',
    '168 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Colorado Springs', 'Harrison School District 2'],
    NULL,
    NULL,
    NULL,
    50000,
    '95',
    'Families with children in the Harrison School District Two in Colorado Springs, CO',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Harrison 2 - Colorado Springs' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Harrison 2 - Colorado Springs'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    187,
    'Build With Families',
    'Gary Community Ventures',
    'Build With Families is a guaranteed basic income initiative in Greater Denver area (Jefferson, Adams, Arapaho, Denver Counties), organized by Gary Community Ventures. Implemented during 6/11/2022 - 3/1/2023. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    199,
    'USD',
    '$199 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Greater Denver area (Jefferson'],
    NULL,
    NULL,
    NULL,
    50000,
    '110',
    'To be eligible to enroll, families were required to be living at or below the MIT Self-Sufficiency Standard (https://livingwage.mit.edu/) and live in Gary Community Venture’s four-county metro Denver focus area (Jefferson, Adams, Arapaho, Denver Counties). Participants were required to to complete the Gary Community Ventures application form, participate in one orientation explaining what the sponsor was hoping to accomplish with BWF, and review program terms and sign a Terms of Service (TOS) agreement.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Build With Families' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Build With Families'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    188,
    'Denver Basic Income Project',
    'Denver Basic Income Project',
    'Denver Basic Income Project is a guaranteed basic income initiative in Denver, CO, organized by Denver Basic Income Project. Implemented during July 2021 - December 2023. Enrolled 11 (August 2021 soft launch), 28 (July 2022 2.0) and 820 (full launch by November 2022) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    542,
    'USD',
    'One third of participants will receive a one-time cash transfer of $6,500 at the beginning of the study with an additional $500 for 11 months, one third will receive 12 monthly cash transfers of $1,000, and one third will not receive a cash transfer and will serve as the control group, receiving a stipend of $50 a month. (one-time and monthly, or monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Denver'],
    NULL,
    NULL,
    NULL,
    NULL,
    '11 (August 2021 soft launch), 28 (July 2022 2.0) and 820 (full launch by November 2022)',
    'Individuals 18-years and older who are unhoused or underhoused, do not have severe and unaddressed mental health or substance use needs and are connected to a partner service provider',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Denver Basic Income Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Denver Basic Income Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    189,
    'The Bridge Network',
    'The Bridge Network',
    'The Bridge Network is a guaranteed basic income initiative in Denver, CO, organized by The Bridge Network. Implemented during July 2021 - June 2023. Enrolled 20 in 12 month pilot, 15 in 24 month pilot participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Denver'],
    NULL,
    NULL,
    NULL,
    50000,
    '20 in 12 month pilot, 15 in 24 month pilot',
    'Families connected with Cross Purpose',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Bridge Network' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Bridge Network'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    190,
    'Seattle-Denver Income Maintenance Experiment (SIME/DIME)',
    'Stanford Research Institute',
    'Seattle-Denver Income Maintenance Experiment (SIME/DIME) is a guaranteed basic income initiative in Denver, CO, organized by Stanford Research Institute. Implemented during 1971  - 1982. Enrolled 4800 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    316,
    'USD',
    '316, 400 or 466 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Denver'],
    NULL,
    NULL,
    NULL,
    50000,
    '4800',
    'Families with income less than $9000 USD if one head of household was employed and less than $11,000 USD if both employed, with even number of white, black and Mexican-American households selected (last group only in Denver, CO)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    191,
    'Healthy Beginnings Project',
    'Impact Charitable',
    'Healthy Beginnings Project is a guaranteed basic income initiative in Denver, Delores and Montezuma Counties, CO, organized by Impact Charitable. Implemented during 11/30/2023 - 2/14/2025. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    814,
    'USD',
    '375 USD (bi-weekly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Denver', '80203,  80204,  80205,  80206, 80207,  80208, 80209,  80210  80211  80212  80216  80217, 80218, 80219,  80220,  80223,  80224,  80225, 80230,  80236,  80237 80238  80239  80243  80244  80248  80249 80250  80251  80252  80256  80257  80259  80261,  80262, 80263,  80264,  80265, 80266,  80271  80273  80274 80279,  80280, 80281, 80290,  80291,  80293, 80294 80295 80299 81320,  81324, 81332,  81324, 81321, 81323, 81327, 81328, 81330, 81331, 81334, 81335'],
    18,
    45,
    'female'::public.program_gender_requirement,
    64000,
    '20',
    'Pregnant individuals, at least 18 years of age, people below 80% AMI, resident of Denver, Delores or Montezuma Counties.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Healthy Beginnings Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Healthy Beginnings Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    192,
    'San Luis Valley, Colorado',
    'UpTogether',
    'San Luis Valley, Colorado is a guaranteed basic income initiative in San Luis Valley, CO, organized by UpTogether. Implemented during December 2021 - September 2022. Enrolled 75 participants. Data documented by the Stanford Basic Income Lab.',
    200,
    'USD',
    '200 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Luis Valley'],
    NULL,
    NULL,
    NULL,
    NULL,
    '75',
    'Individuals who earn a low-income, as identified by two local nonprofits',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Luis Valley, Colorado' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Luis Valley, Colorado'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    193,
    'Elm City Reentry Pilot',
    '4-CT',
    'Elm City Reentry Pilot is a guaranteed basic income initiative in New Haven. CT, organized by 4-CT. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['New Haven. CT'],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Participants (ages 18+) are individuals returning from prison to a New Haven City or County address and were selected by Project M.O.R.E. Reentry Welcome Center and are currently receiving services related to their transition back to the community. Participation in the pilot is not contingent upon continued services through Project M.O.R.E.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Elm City Reentry Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Elm City Reentry Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    194,
    'Let''s Go DMV!',
    'if',
    'Let''s Go DMV! is a guaranteed basic income initiative in Washington, DC region (including suburban Maryland and Northern Virginia), organized by if. Implemented during March 2022- December 2026. Enrolled 75 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '75',
    'DC-area hospitality workers who lost employment because of COVID. Most participants were already engaged with ROC-DC. Participants are decided on by workers.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Let''s Go DMV!' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Let''s Go DMV!'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    195,
    'Strong Families, Strong Future DC',
    'Martha’s Table',
    'Strong Families, Strong Future DC is a guaranteed basic income initiative in Washington D.C., organized by Martha’s Table. Implemented during March 2022 - February 2023. Enrolled 132 participants. Data documented by the Stanford Basic Income Lab.',
    900,
    'USD',
    '900 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Washington D.C.', 'Wards 5, 7, and 8'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    40000,
    '132',
    'Individuals  in target wards with a household income no more than 250% of the federal poverty level for the family/household size, and expecting/new mothers.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Strong Families, Strong Future DC' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Strong Families, Strong Future DC'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    196,
    'Family Goal Fund — Washington DC',
    'LIFT',
    'Family Goal Fund is a guaranteed basic income initiative in Washington DC, organized by LIFT. Implemented during January 2018 -. Enrolled 800+ participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '150 USD (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Washington DC'],
    NULL,
    NULL,
    NULL,
    NULL,
    '800+',
    'Households in the LIFT program with low-income and children 0-8 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Goal Fund — Washington DC' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Goal Fund — Washington DC'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    197,
    'Mother Up Pilot',
    'Mother''s Outreach Network',
    'Mother Up Pilot is a guaranteed basic income initiative in Washington DC, organized by Mother''s Outreach Network. Implemented during 5/1/2023 - 4/1/2026. Enrolled 50 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Washington DC'],
    NULL,
    NULL,
    NULL,
    NULL,
    '50',
    '',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Mother Up Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Mother Up Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    198,
    'My Sister''s Place Cash Transfer Program',
    'My Sister''s Place',
    'My Sister''s Place Cash Transfer Program is a guaranteed basic income initiative in Washington DC, organized by My Sister''s Place. Implemented during 1/1/2023 - 12/1/2024. Enrolled 45 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Washington DC'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    50000,
    '45',
    'Black mothers with children aged 14 or younger who have current or recent involvement with the D.C. Child & Family Services Agency (CFSA)',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'My Sister''s Place Cash Transfer Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'My Sister''s Place Cash Transfer Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    199,
    'Thrive East of the River',
    'Martha''s Table',
    'Thrive East of the River is a guaranteed basic income initiative in Washington DC, organized by Martha''s Table. Implemented during 7/1/2020 – 1/31/2022. Enrolled 500 participants. Data documented by the Stanford Basic Income Lab.',
    1100,
    'USD',
    '$1,100 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['East of the River', 'Washington DC'],
    NULL,
    NULL,
    NULL,
    50000,
    '500',
    'Martha''s Table''s Education programs or non-MT families who earn an income of $35,000 and below annually',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Thrive East of the River' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Thrive East of the River'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    200,
    'The Delaware Healthy Mother & Infant Consortium (DHMIC)',
    'Delaware Healthy Mother & Infant Consortium',
    'The Delaware Healthy Mother & Infant Consortium (DHMIC) is a guaranteed basic income initiative in Wilmington and New Castle County, DE, organized by Delaware Healthy Mother & Infant Consortium. Implemented during 4/1/2022 - 3/1/2024. Enrolled 40 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Wilmington and New Castle County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '40',
    'Domestic violence survivors',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Delaware Healthy Mother & Infant Consortium (DHMIC)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Delaware Healthy Mother & Infant Consortium (DHMIC)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    201,
    'Eastern Band of Cherokee Indians Casino Revenue Fund',
    'Eastern Band of Cherokee Indians',
    'Eastern Band of Cherokee Indians Casino Revenue Fund is a guaranteed basic income initiative in Eastern Band of Cherokee Indians, organized by Eastern Band of Cherokee Indians. Implemented during 1996 -. Enrolled 15,414 participants. Data documented by the Stanford Basic Income Lab.',
    292,
    'USD',
    '3500-6000 USD (bi-annual)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '15,414',
    'Individuals over 18, however band members start accumulating the transfer when born, which is dispersed in three tranches less taxes at 18, 21 and 25 years in addition to the bi-yearly payment.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Eastern Band of Cherokee Indians Casino Revenue Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Eastern Band of Cherokee Indians Casino Revenue Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    202,
    'EBCI GenWell Program',
    'Eastern Band of Cherokee Indians (EBCI)',
    'EBCI GenWell Program is a guaranteed basic income initiative in Eastern Band of Cherokee Indians, organized by Eastern Band of Cherokee Indians (EBCI). Implemented during 3/1/2025 -. Enrolled n/a participants. Data documented by the Stanford Basic Income Lab.',
    800,
    'USD',
    'Up to $800 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    18,
    NULL,
    NULL,
    NULL,
    'n/a',
    'Members of the Eastern Band of Cherokee Indians who are 18 years of age or older, recognized by the Tribe as duly enrolled, and who do not fall within the specific exemptions from eligibility, are eligible to participate in the EBCI GenWell Program.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'EBCI GenWell Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'EBCI GenWell Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    203,
    'Just Income',
    'Community Spring',
    'Just Income is a guaranteed basic income initiative in Gainesville, FL, organized by Community Spring. Implemented during January 2022 - February 2023. Enrolled 115 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD first month, then 600 per month USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Gainesville'],
    NULL,
    NULL,
    NULL,
    NULL,
    '115',
    'Alachua County residents within six months of their release from federal/Florida state prison, release from jail with a felony, or beginning felony probation.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Just Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Just Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    204,
    'GI 305 Community Fund',
    'GI 305',
    'GI 305 Community Fund is a guaranteed basic income initiative in Miami, Florida, organized by GI 305. Implemented during 4/1/2024 - 3/31/2025. Enrolled 5 participants. Data documented by the Stanford Basic Income Lab.',
    650,
    'USD',
    '$650 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Miami', 'Zip codes 33125, 33127, 33128, 33135, 33136, 33142, 33147, 33150'],
    NULL,
    NULL,
    NULL,
    50000,
    '5',
    'The 8 eligible zipcodes are areas of Miami, Florida experiencing high rates of climate gentrification and displacement. Participants also need to be over the age of 16.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'GI 305 Community Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'GI 305 Community Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    205,
    'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation)',
    'City of Atlanta and Urban League of Greater Atlanta',
    'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation) is a guaranteed basic income initiative in Atlanta, GA, organized by City of Atlanta and Urban League of Greater Atlanta. Implemented during January 2022 - May 2023. Enrolled 300 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Atlanta'],
    NULL,
    NULL,
    NULL,
    40000,
    '300',
    'Individuals 18 and over who earn up to 200% of the Federal Poverty Line for household size ($25,760 for single person)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    206,
    'In Her Hands - Atlanta''s Old Fourth Ward',
    'GRO Fund',
    'In Her Hands - Atlanta''s Old Fourth Ward is a guaranteed basic income initiative in In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods., organized by GRO Fund. Implemented during May 2022 - May 2024. Enrolled 214 participants. Data documented by the Stanford Basic Income Lab.',
    850,
    'USD',
    '$850 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Old Fourth Ward', 'In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '214',
    'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'In Her Hands - Atlanta''s Old Fourth Ward' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'In Her Hands - Atlanta''s Old Fourth Ward'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    207,
    'In Her Hands - Atlanta''s Westside Neighborhoods',
    'GRO Fund',
    'In Her Hands - Atlanta''s Westside Neighborhoods is a guaranteed basic income initiative in In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods., organized by GRO Fund. Implemented during August 2024 - August 2027. Enrolled 275 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward', 'English Ave., Vine City, Bankhead, Washington Park'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '275',
    'Low-income women (average income approximately $15,000). Split payment groups (a) receives $1,000 per month for 36 months (b) receives $8,000 lump sum (flexible timing), $800 remaining 35 months.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'In Her Hands - Atlanta''s Westside Neighborhoods' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'In Her Hands - Atlanta''s Westside Neighborhoods'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    208,
    'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties)',
    'GRO Fund',
    'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties) is a guaranteed basic income initiative in In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods., organized by GRO Fund. Implemented during August 2022 - August 2024. Enrolled 236 participants. Data documented by the Stanford Basic Income Lab.',
    850,
    'USD',
    '$850 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '236',
    'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    209,
    'In Her Hands - City of College Park',
    'GRO Fund',
    'In Her Hands - City of College Park is a guaranteed basic income initiative in In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods., organized by GRO Fund. Implemented during October 2022 - October 2024. Enrolled 204 participants. Data documented by the Stanford Basic Income Lab.',
    850,
    'USD',
    '$850 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '204',
    'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'In Her Hands - City of College Park' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'In Her Hands - City of College Park'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    210,
    'Rural Income Maintenance Experiment',
    'Institute for Research on Poverty',
    'Rural Income Maintenance Experiment is a guaranteed basic income initiative in Calhound and Pocahontas Counties, IA, organized by Institute for Research on Poverty. Implemented during 1970 - 1972. Enrolled 810 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Calhound and Pocahontas Counties'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '810',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rural Income Maintenance Experiment' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rural Income Maintenance Experiment'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    211,
    'UpLift - The Central Iowa Basic Income Pilot',
    'Project Coordination Team at The Harkin Institute',
    'UpLift - The Central Iowa Basic Income Pilot is a guaranteed basic income initiative in Polk, Dallas, and Warren Counties, IA, organized by Project Coordination Team at The Harkin Institute. Implemented during 5/15/23 - 4/15/25. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Polk'],
    NULL,
    NULL,
    NULL,
    50000,
    '110',
    'Age 18+, live in tri-county area, have a dependent up to the age of 25, and have an AMI of 60% or less.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'UpLift - The Central Iowa Basic Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'UpLift - The Central Iowa Basic Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    212,
    'Champaign County Guaranteed Income Project',
    'University of Illinois',
    'Champaign County Guaranteed Income Project is a guaranteed basic income initiative in Champaign County, IL, organized by University of Illinois. Implemented during 3/1/2023 - 9/30/2026. Enrolled 10 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Champaign County'],
    NULL,
    NULL,
    NULL,
    50000,
    '10',
    'Children and families identified by the McKinney-Vento Act that meet the definition of asset-limited, income-constrained, and employed (ALICE) with a particular focus on Black, Latinx, Asian, and Mixed Race families.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Champaign County Guaranteed Income Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Champaign County Guaranteed Income Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    213,
    'Affording Survival',
    'The Network',
    'Affording Survival is a guaranteed basic income initiative in Chicago, IL, organized by The Network. Implemented during 7/27/2024 - July 2025. Enrolled 60 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chicago'],
    NULL,
    NULL,
    NULL,
    50000,
    '60',
    'Survivors of domestic violence, over 18, parent/caregiver of a minor child, resides in rapid rehousing program at WINGS or Family Rescue during recruitment phase, lives in the Chicago metropolitan area',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Affording Survival' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Affording Survival'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    214,
    'Chicago Resilient Communities Pilot',
    'City of Chicago',
    'Chicago Resilient Communities Pilot is a guaranteed basic income initiative in Chicago, IL, organized by City of Chicago. Implemented during June 2022  - May 2023. Enrolled 5000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chicago'],
    18,
    NULL,
    NULL,
    40000,
    '5000',
    'Individuals 18 years and older with income at or below 250% of the Federal Poverty Level (up to $32,200 for single household) who have experienced economic hardship related to COVID-19',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Chicago Resilient Communities Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Chicago Resilient Communities Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    215,
    'Dream Keeper Fellowship',
    'Direct Giving Lab',
    'Dream Keeper Fellowship is a guaranteed basic income initiative in Chicago, IL, organized by Direct Giving Lab. Implemented during 1/1/2024 - 1/1/2026. Enrolled 70 low-income families. Proposed expansion to 200 participants. Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '$100 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chicago'],
    NULL,
    NULL,
    NULL,
    50000,
    '70 low-income families. Proposed expansion to 200',
    'Low-income families',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Dream Keeper Fellowship' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Dream Keeper Fellowship'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    216,
    'Evanston Equitable Recovery Fund',
    'Family Independence Initiative',
    'Evanston Equitable Recovery Fund is a guaranteed basic income initiative in Chicago, IL, organized by Family Independence Initiative. Implemented during 4/26/2021 - 2/26/2022. Enrolled 24 participants. Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chicago'],
    NULL,
    NULL,
    NULL,
    NULL,
    '24',
    'Black residents who lived in Evanston between 1919 and 1969 or have a direct ancestor who lived in the city during that time',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Evanston Equitable Recovery Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Evanston Equitable Recovery Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    217,
    'Family Goal Fund — Chicago, IL',
    'LIFT',
    'Family Goal Fund is a guaranteed basic income initiative in Chicago, IL, organized by LIFT. Implemented during January 2018 -. Enrolled 800+ participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '150 USD (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chicago'],
    NULL,
    NULL,
    NULL,
    NULL,
    '800+',
    'Households in the LIFT program with low-income and children 0-8 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Goal Fund — Chicago, IL' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Goal Fund — Chicago, IL'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    218,
    'Cook County Promise Guaranteed Income',
    'Cook County Government',
    'Cook County Promise Guaranteed Income is a guaranteed basic income initiative in Cook County, IL, organized by Cook County Government. Implemented during October 2022 - 2025. Enrolled 3,250 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Cook County'],
    NULL,
    NULL,
    NULL,
    40000,
    '3,250',
    'Individuals  18 or older with a household income at or below 250% of the federal poverty level or less, and  
no one else in your household is participating in another guaranteed income pilot.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Cook County Promise Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Cook County Promise Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    219,
    'Every Dollar Counts',
    'Heartland Alliance',
    'Every Dollar Counts is a guaranteed basic income initiative in Cook, Iroquois, Kane, LaSalle, Lee, Ogle, Will, Winnebago, organized by Heartland Alliance. Implemented during January 2020 - December 2023. Enrolled Not available participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '50 or 1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Cook'],
    NULL,
    NULL,
    NULL,
    40000,
    'Not available',
    'Individuals between ages of 21-40 with total household income up to 300% of the Federal Poverty Level (up to $38,640 for a single person)',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Every Dollar Counts' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Every Dollar Counts'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    220,
    'Guaranteed Income Pilot Program',
    'City of Evanston and Northwestern University',
    'Guaranteed Income Pilot Program is a guaranteed basic income initiative in Evanston, IL, organized by City of Evanston and Northwestern University. Implemented during April 2021 - January 2022. Enrolled 165 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Evanston'],
    60,
    NULL,
    NULL,
    NULL,
    '165',
    'Individuals aged 18-24, senior and undocumented residents with low-income',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    221,
    'Direct Giving Lab',
    'Direct Giving Lab',
    'Direct Giving Lab is a guaranteed basic income initiative in Illinois, organized by Direct Giving Lab. Implemented during 5/1/2017 - May 2018. Enrolled 70 low-income families. Proposed expansion to 200 participants. Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '$100 or $150 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '70 low-income families. Proposed expansion to 200',
    'Selected using the free and reduced meal (FARM) program at Highland Park High School',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Direct Giving Lab' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Direct Giving Lab'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    222,
    'Empower Parenting with Resources (EmPwR)',
    'University of Illinois Urbana-Champaign',
    'Empower Parenting with Resources (EmPwR) is a guaranteed basic income initiative in Illinois, organized by University of Illinois Urbana-Champaign. Enrolled 800 participants. Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '$100 - $500, adjusted for local cost of living and family size (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    50000,
    '800',
    'Families who were referred by the Illinois Department of Children and Family Services to receive services for allegations of child maltreatment',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Empower Parenting with Resources (EmPwR)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Empower Parenting with Resources (EmPwR)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    223,
    'Chicago Future Fund',
    'EAT Chicago',
    'Chicago Future Fund is a guaranteed basic income initiative in Chicago, IL, organized by EAT Chicago. Implemented during October 2021 - April 2023. Enrolled 30 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['West Garfield Park', 'Chicago'],
    NULL,
    NULL,
    NULL,
    NULL,
    '30',
    'Individuals 18-35 who live in targeted neighbourhood, formerly convicted or incarcerated and make less than $12,000/year',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Chicago Future Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Chicago Future Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    224,
    'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)',
    'OpenResearch',
    'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) is a guaranteed basic income initiative in Illinois and Texas, organized by OpenResearch. Implemented during 11/1/2020 - 10/31/2023. Enrolled 3,000 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Illinois and Texas'],
    NULL,
    NULL,
    NULL,
    40000,
    '3,000',
    'Individuals living in one of 19 study counties in Texas and Illinois who were aged 21 to 40, with total household income less than 300% of the federal poverty line (average annual household income of $29,900), not receiving SSI or living in public housing (to avoid risk of losing these key public benefits). Pilot was structured as a randomized controlled trial (RCT), with 1,000 individuals randomly assigned to the treatment group to receive $1,000 per month, and 2,000 individuals randomly assigned to the control group to receive $50 per month. Extensive data were collected with study results available at https://www.openresearchlab.org/projects/unconditional-cash-study.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    225,
    'Gary Income Maintenance Experiment',
    'State of Indiana Department of Public Welfare',
    'Gary Income Maintenance Experiment is a guaranteed basic income initiative in Gary, IN, organized by State of Indiana Department of Public Welfare. Implemented during 1971 - 1974. Enrolled 1782 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    275,
    'USD',
    '275 or 358 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Gary'],
    NULL,
    NULL,
    NULL,
    NULL,
    '1782',
    'Individual/household means-testing and demographic',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Gary Income Maintenance Experiment' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Gary Income Maintenance Experiment'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    226,
    'Guaranteed Income Validation Effort (GIVE Gary)',
    'City of Gary',
    'Guaranteed Income Validation Effort (GIVE Gary) is a guaranteed basic income initiative in Gary, IN, organized by City of Gary. Implemented during May 2021 - May 2022. Enrolled 100 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Gary'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Individuals at least 18 years old with an income of $35,000 or less',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income Validation Effort (GIVE Gary)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Guaranteed Income Validation Effort (GIVE Gary)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    227,
    'The Rooted School: The 50 Dollar Study',
    'Rooted School Foundation',
    'The Rooted School: The 50 Dollar Study is a guaranteed basic income initiative in Indianapolis, IN, organized by Rooted School Foundation. Implemented during 10/1/2022 - 9/30/2024. Enrolled 470 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    216,
    'USD',
    '50 USD (weekly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    60,
    NULL,
    NULL,
    NULL,
    '470',
    'High school senior enrolled at Rooted School New Orleans',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Rooted School: The 50 Dollar Study' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Rooted School: The 50 Dollar Study'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    228,
    'YALift! (Young Adult Louisville Income For Transformation)',
    'Louisville Metro Government',
    'YALift! (Young Adult Louisville Income For Transformation) is a guaranteed basic income initiative in Louisville, KY, organized by Louisville Metro Government. Implemented during April 2022 - March 2023. Enrolled 151 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['California, Russell, Smoketown', 'Louisville'],
    NULL,
    NULL,
    NULL,
    NULL,
    '151',
    'Individuals 18-24 who live in the California, Russell, and Smoketown neighbourhoods.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'YALift! (Young Adult Louisville Income For Transformation)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'YALift! (Young Adult Louisville Income For Transformation)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    229,
    'Baby''s First Years - Louisiana',
    'Teacher''s College',
    'Baby''s First Years - Louisiana is a guaranteed basic income initiative in Greater New Orleans metropolitan area, LA, organized by Teacher''s College. Implemented during 5/1/2018 -. Enrolled 1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    20,
    'USD',
    '$20 or $333 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Greater New Orleans metropolitan area'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)',
    'Low-income mothers with newborns',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Baby''s First Years - Louisiana' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Baby''s First Years - Louisiana'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    230,
    'Shreveport Guaranteed Income',
    'City of Shreveport',
    'Shreveport Guaranteed Income is a guaranteed basic income initiative in Shreveport, LA, organized by City of Shreveport. Implemented during March 2022 - March 2023. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Shreveport'],
    NULL,
    NULL,
    NULL,
    40000,
    '110',
    'Single caregivers with school-aged children with income up to 120% of the Federal Poverty rate',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Shreveport Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Shreveport Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    231,
    'The Truth & Reconciliation Project''s Guaranteed Monthly Income',
    'ACLU of Louisiana and the Fund for Guaranteed Income',
    'The Truth & Reconciliation Project''s Guaranteed Monthly Income is a guaranteed basic income initiative in Louisiana, organized by ACLU of Louisiana and the Fund for Guaranteed Income. Implemented during 12/1/2023 - 12/1/2024. Enrolled 12 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '12',
    'Individuals in Lousiana who were victims of police violence and didn''t receive legal resistution',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Truth & Reconciliation Project''s Guaranteed Monthly Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Truth & Reconciliation Project''s Guaranteed Monthly Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    232,
    'New Orleans Guaranteed Income Program',
    'City of New Orleans',
    'New Orleans Guaranteed Income Program is a guaranteed basic income initiative in New Orleans, LA, organized by City of New Orleans. Implemented during April 2022 - March 2023. Enrolled 125 participants. Data documented by the Stanford Basic Income Lab.',
    350,
    'USD',
    '350 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['New Orleans'],
    18,
    24,
    NULL,
    NULL,
    '125',
    'Young adults aged 16-24 who are neither in school nor working',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Orleans Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Orleans Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    233,
    'The Rooted School: The 50 Dollar Study — New Orleans, LA',
    'Rooted School Foundation',
    'The Rooted School: The 50 Dollar Study is a guaranteed basic income initiative in New Orleans, LA, organized by Rooted School Foundation. Implemented during 10/1/2022 - 9/30/2024. Enrolled 470 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    216,
    'USD',
    '50 USD (weekly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['New Orleans'],
    60,
    NULL,
    NULL,
    NULL,
    '470',
    'High school senior enrolled at Rooted School New Orleans',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Rooted School: The 50 Dollar Study — New Orleans, LA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Rooted School: The 50 Dollar Study — New Orleans, LA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    234,
    'Camp Harbor View Guaranteed Income Pilot',
    'Camp Harbor View & UpTogether',
    'Camp Harbor View Guaranteed Income Pilot is a guaranteed basic income initiative in Boston, MA, organized by Camp Harbor View & UpTogether. Implemented during August 2021 - August 2023. Enrolled 50 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    583,
    'USD',
    '583 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boston'],
    18,
    24,
    NULL,
    NULL,
    '50',
    'Child in one of CHVs youth serving programs and  self-certify as low-income but not receiving most benefits',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Camp Harbor View Guaranteed Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Camp Harbor View Guaranteed Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    235,
    'Community Love Fund',
    'The National Council',
    'Community Love Fund is a guaranteed basic income initiative in Boston, MA, organized by The National Council. Implemented during February 2022 - January 2023. Enrolled 21 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boston'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '21',
    'Women who are incarcerated or formerly incarcerated',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Community Love Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Community Love Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    236,
    'Pediatric RISE',
    'Dana-Farber Cancer Institute Department of Pediatric Oncology',
    'Pediatric RISE is a guaranteed basic income initiative in Boston, MA, organized by Dana-Farber Cancer Institute Department of Pediatric Oncology. Implemented during 10/1/2024 - 12/31/2024. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 - $500 (bi-monthly (twice per month))',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boston'],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Low-income children with cancer',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Pediatric RISE' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Pediatric RISE'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    237,
    'Striving Towards Economic Prosperity (STEP)',
    'Unitd South End Settlements',
    'Striving Towards Economic Prosperity (STEP) is a guaranteed basic income initiative in Boston, MA, organized by Unitd South End Settlements. Implemented during 10/1/2021. Enrolled 32 participants. Data documented by the Stanford Basic Income Lab.',
    800,
    'USD',
    '$800-$850 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['South End, Roxbury, other Boston neighborhoods', 'Boston'],
    NULL,
    NULL,
    NULL,
    50000,
    '32',
    'Families with children, with 16 families each in cohort 1 and cohort 2',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Striving Towards Economic Prosperity (STEP)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Striving Towards Economic Prosperity (STEP)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    238,
    'Trust and Invest Collaborative',
    'UpTogether',
    'Trust and Invest Collaborative is a guaranteed basic income initiative in Boston and Cambridge, MA, organized by UpTogether. Implemented during June 2021 - December 2022. Enrolled 1482 participants. Data documented by the Stanford Basic Income Lab.',
    760,
    'USD',
    'Minimum of $760 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Boston and Cambridge'],
    NULL,
    20,
    NULL,
    40000,
    '1482',
    'Individuals 18 and older with at least one dependent child with a household income level under 200% of the federal poverty level.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Trust and Invest Collaborative' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Trust and Invest Collaborative'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    239,
    'Cambridge RISE (Recurring Income for Success and Empowerment)',
    'City of Cambridge',
    'Cambridge RISE (Recurring Income for Success and Empowerment) is a guaranteed basic income initiative in Cambridge, MA, organized by City of Cambridge. Implemented during September 2021 - February 2023. Enrolled 130 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Cambridge'],
    NULL,
    18,
    NULL,
    NULL,
    '130',
    'Individuals with an income up to  80% of the area median income caring for children under 18',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Cambridge RISE (Recurring Income for Success and Empowerment)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Cambridge RISE (Recurring Income for Success and Empowerment)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    240,
    'Chelsea Eats',
    'City of Chelsea',
    'Chelsea Eats is a guaranteed basic income initiative in Chelsea, MA, organized by City of Chelsea. Implemented during November 2020 - May 2021. Enrolled 2000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    200,
    'USD',
    '200 - 400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Chelsea'],
    NULL,
    NULL,
    NULL,
    NULL,
    '2000',
    'No direct targeting but 80% of cash assistance card applications were submitted by residents attending city or partner agency food pantries',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Chelsea Eats' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Chelsea Eats'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    241,
    'Healthy Families MA (HFM) Family Financial Pilot',
    'Children''s Trust of MA',
    'Healthy Families MA (HFM) Family Financial Pilot is a guaranteed basic income initiative in Cities and towns in the HFM Springfield catchment area: Agawam, Blandford, East Longmeadow, Granville, Hampden, Longmeadow, Montgomery, Russell, Southwick, Springfield, Tolland, West Springfield, Wilbraham, organized by Children''s Trust of MA. Implemented during 6/15/2023 - 6/30/2025. Enrolled 123 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD after child''s birth, 300 USD additional for twins, 100 USD for prenatal participants until baby''s birth, final 3 payments 550 USD, 650 USD, and 750 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Cities and towns in the HFM Springfield catchment area: Agawam'],
    NULL,
    NULL,
    NULL,
    NULL,
    '123',
    'Eloigible if enrolled in HFM, although level of engagement does not matter, e.g., could be absent from home visits yet still receive cash payments.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Healthy Families MA (HFM) Family Financial Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Healthy Families MA (HFM) Family Financial Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    242,
    'Bridge to Prosperity Cliffs Pilot Program',
    'Springfield WORKS',
    'Bridge to Prosperity Cliffs Pilot Program is a guaranteed basic income initiative in Greater Boston, Worcester, and Springfield, MA, organized by Springfield WORKS. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '$300 - $700, plus a $10,000 bonus upon program completion (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Greater Boston'],
    NULL,
    NULL,
    NULL,
    50000,
    '100',
    'Low-income working families receiving public assistance',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Bridge to Prosperity Cliffs Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Bridge to Prosperity Cliffs Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    243,
    'Family Health Project',
    'Health Metrics',
    'Family Health Project is a guaranteed basic income initiative in Lynn, MA, organized by Health Metrics. Implemented during January 2018 -. Enrolled 30 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Lynn'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '30',
    'Mothers with low-income',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Health Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Health Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    244,
    'Economic Stability/Mobility Initiative',
    'The City of Newton and Economic Mobility Pathways (EMPath)',
    'Economic Stability/Mobility Initiative is a guaranteed basic income initiative in Newton, MA, organized by The City of Newton and Economic Mobility Pathways (EMPath). Implemented during 9/1/2023 - September 2025. Enrolled 50 families participants. Data documented by the Stanford Basic Income Lab.',
    250,
    'USD',
    '$250 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Newton'],
    NULL,
    18,
    'female'::public.program_gender_requirement,
    50000,
    '50 families',
    'Low-income Newton families who are at or below 50 percent of the Area Median Income, have children under 18 years old (or are pregnant), and who are interested in working and increasing their income',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Economic Stability/Mobility Initiative' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Economic Stability/Mobility Initiative'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    245,
    'Prince George Guaranteed Income Pilot Program',
    'Thrive Prince George''s',
    'Prince George Guaranteed Income Pilot Program is a guaranteed basic income initiative in Prince George''s County, MD, organized by Thrive Prince George''s. Implemented during 4/1/2024 - 3/1/2026. Enrolled 175 participants. Data documented by the Stanford Basic Income Lab.',
    800,
    'USD',
    '$800 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Prince George''s County'],
    18,
    24,
    NULL,
    NULL,
    '175',
    '50 youth (age 18-24) who have aged out of foster care and 125+ seniors (age 60+) within Prince George''s County.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Prince George Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Prince George Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    246,
    'Montgomery County Guaranteed Income Program',
    'Uptogether',
    'Montgomery County Guaranteed Income Program is a guaranteed basic income initiative in Mongomery, MD, organized by Uptogether. Implemented during August 2022 - July 2024. Enrolled 300 participants. Data documented by the Stanford Basic Income Lab.',
    8000,
    'USD',
    '8000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Mongomery'],
    NULL,
    NULL,
    NULL,
    NULL,
    '300',
    '100 households recently served by the Montgomery County Homeless Continuum of Care and 200 participants with at least one child/dependent who had previously sought assistance from the County during the COVID 19 pandemic were invited to apply, and selected through a randomized application process.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Montgomery County Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Montgomery County Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    247,
    'Baltimore Young Families Success Fund',
    'City of Baltimore',
    'Baltimore Young Families Success Fund is a guaranteed basic income initiative in Baltimore, MD, organized by City of Baltimore. Implemented during 8/1/2022 - 07/01/2024. Enrolled 200 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Baltimore'],
    NULL,
    NULL,
    NULL,
    40000,
    '200',
    'Individuals between the ages of 18-24 with children, and have an annual income at or below 300% of the federal poverty level based on household size',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Baltimore Young Families Success Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Baltimore Young Families Success Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    248,
    'Project Home Trust',
    'Quality Housing Coalition',
    'Project Home Trust is a guaranteed basic income initiative in Maine, organized by Quality Housing Coalition. Implemented during 6/1/2023 - 5/31/2024. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '20',
    'Low-income, single mothers who had previously experienced homelessness.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Project Home Trust' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Project Home Trust'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    249,
    'Guaranteed Income to Grow Ann Arbor',
    'City of Ann Arbor',
    'Guaranteed Income to Grow Ann Arbor is a guaranteed basic income initiative in Ann Arbor, MI, organized by City of Ann Arbor. Implemented during 1/1/2024 - January 2026. Enrolled 100 families/individuals participants. Data documented by the Stanford Basic Income Lab.',
    528,
    'USD',
    '$528 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Ann Arbor'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100 families/individuals',
    'Low- and moderate-income households with individuals engaged in some form of entrepreneurship, including home-based businesses',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income to Grow Ann Arbor' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Guaranteed Income to Grow Ann Arbor'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    250,
    'Thriving Families',
    'Ann Arbor Area Community Foundation',
    'Thriving Families is a guaranteed basic income initiative in Washtenaw County, MI, organized by Ann Arbor Area Community Foundation. Implemented during April 2022 - April 2024. Enrolled 45 participants. Data documented by the Stanford Basic Income Lab.',
    417,
    'USD',
    '1250 USD (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Washtenaw County'],
    NULL,
    NULL,
    NULL,
    50000,
    '45',
    'Families involved with Washtenaw County social service providers',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Thriving Families' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Thriving Families'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    251,
    'Project Solid Ground',
    'Avivo',
    'Project Solid Ground is a guaranteed basic income initiative in Minneapolis–St. Paul (Twin Cities), MN, organized by Avivo. Implemented during 10/1/2020 - 9/30/2021. Enrolled 15 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Minneapolis–St. Paul (Twin Cities)'],
    NULL,
    NULL,
    NULL,
    NULL,
    '15',
    'Randomly selected individuals who were participants in Avivo''s treatment, training, or career advancement services',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Project Solid Ground' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Project Solid Ground'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    252,
    'Minneapolis Guaranteed Basic Income Pilot',
    'City of Minneapolis',
    'Minneapolis Guaranteed Basic Income Pilot is a guaranteed basic income initiative in Minneapolis, MN, organized by City of Minneapolis. Implemented during June 2022 - May 2024. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Minneapolis'],
    NULL,
    NULL,
    NULL,
    50000,
    '200',
    'Individuals with household income 50% or less of the city''s median area income, with priority given to housing insecure families, those in job training or educational programs who have dropped out due to financial hardship, and young people headed households',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Minneapolis Guaranteed Basic Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Minneapolis Guaranteed Basic Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    253,
    'CollegeBound Boost',
    'St. Paul’s Office of Financial Empowerment',
    'CollegeBound Boost is a guaranteed basic income initiative in St. Paul, MN, organized by St. Paul’s Office of Financial Empowerment. Implemented during Fall 2022 -. Enrolled 333 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['St. Paul'],
    NULL,
    NULL,
    NULL,
    50000,
    '333',
    'Low-income families enrolled in the CollegeBound Saint Paul program',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'CollegeBound Boost' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'CollegeBound Boost'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    254,
    'International Institute of Minnesota''s Guaranteed Income Program for Refugees',
    'International Institute of Minnesota',
    'International Institute of Minnesota''s Guaranteed Income Program for Refugees is a guaranteed basic income initiative in St. Paul, MN, organized by International Institute of Minnesota. Implemented during August 2022 - July 2023. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '750 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['St. Paul'],
    NULL,
    NULL,
    NULL,
    50000,
    '25',
    'Single-parent households with children under the age of 15,or families with four or more children, one working parent, and one parent with obstacles to employment, orsingle adults with physical or mental illness limiting their ability to work or obtain employment, or families or single adults unable to work due to delays in paperwork processing or other barriers beyond their control.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'International Institute of Minnesota''s Guaranteed Income Program for Refugees' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'International Institute of Minnesota''s Guaranteed Income Program for Refugees'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    255,
    'People''s Prosperity Pilot',
    'City of St. Paul',
    'People''s Prosperity Pilot is a guaranteed basic income initiative in St. Paul, MN, organized by City of St. Paul. Implemented during October 2020 - March 2022. Enrolled 150 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['St. Paul'],
    NULL,
    NULL,
    NULL,
    NULL,
    '150',
    'Households financially impacted by COVID-19, and enrolled in college saving program',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'People''s Prosperity Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'People''s Prosperity Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    256,
    'Baby''s First Years - Minnesota',
    'Teacher''s College',
    'Baby''s First Years - Minnesota is a guaranteed basic income initiative in Twin Cities (Minneapolis and St. Paul), MN, organized by Teacher''s College. Implemented during 5/1/2018 -. Enrolled 1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    20,
    'USD',
    '$20 or $333 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Twin Cities (Minneapolis and St. Paul)'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)',
    'Low-income mothers with newborns',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Baby''s First Years - Minnesota' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Baby''s First Years - Minnesota'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    257,
    'Rai$e Program',
    'Wilder Foundation',
    'Rai$e Program is a guaranteed basic income initiative in Minnesota, organized by Wilder Foundation. Implemented during 1/31/2023 - 8/25/2024. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '150',
    'Pilot spans two 12-month cohorts: Jan.-Dec. 2023; and Sept. 2023-Aug. 2024. Participants live in Minnesota, but participants are primarily in the Twin Cities metropolitan area.

Program participation — identification through program or service. However, ongoing eligibility is not contingent on ongoing participation in program. Guaranteed Income payments were made to an indiviudal from each selected household of two cohorts of 75. In each cohort of 75, 45 were drawn from Wilder programs; 15 from Build Wealth MN; and 15 from Prepare + Prosper. To be eligibile, an individual from a household must be at least 18 years old; manage their own finances; and be participating in program to strengthen their financial stability. Participants were referred by program staff and entered into lotteries for selection. One person per household was selected.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rai$e Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rai$e Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    258,
    'Magnolia Mother''s Trust Cohort 4',
    'Springboard to Opportunities',
    'Magnolia Mother''s Trust Cohort 4 is a guaranteed basic income initiative in Jackson, MS, organized by Springboard to Opportunities. Implemented during 5/1/2022 - 4/1/2023. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Jackson'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '100',
    'Black mothers living in federally subsidized housing.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Magnolia Mother''s Trust Cohort 4' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Magnolia Mother''s Trust Cohort 4'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    259,
    'Magnolia Mother''s Trust',
    'Springboard to Opportunities',
    'Magnolia Mother''s Trust is a guaranteed basic income initiative in Jackson, MS, organized by Springboard to Opportunities. Implemented during 2018 -. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Jackson'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '100',
    'Black mothers living in federally subsidized housing',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Magnolia Mother''s Trust' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Magnolia Mother''s Trust'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    260,
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi',
    'Rural GMI Initiative',
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi is a guaranteed basic income initiative in Warren County, MS, organized by Rural GMI Initiative. Implemented during 12/1/2025 -. Enrolled About 530 participants. Data documented by the Stanford Basic Income Lab.',
    1500,
    'USD',
    '$1,500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Warren County'],
    NULL,
    NULL,
    NULL,
    40000,
    'About 530',
    'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    261,
    'LIFT',
    'Mountain Home',
    'LIFT is a guaranteed basic income initiative in Missoula. MT, organized by Mountain Home. Implemented during 8/23/2022 - 8/24/2023. Enrolled 10 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Missoula. MT', '59804'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '10',
    'All residential clients (mothers with their children) in Mountain Home''s residential program.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'LIFT' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'LIFT'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    262,
    'The Returning Citizen Stimulus (RCS) Program',
    'Center for Employment Opportunities (CEO)',
    'The Returning Citizen Stimulus (RCS) Program is a guaranteed basic income initiative in 28 cities in the United States, organized by Center for Employment Opportunities (CEO). Implemented during 4/1/2020 - 2021. Enrolled 10,400 participants. Data documented by the Stanford Basic Income Lab.',
    2250,
    'USD',
    'Variable: $2,250-$2,750 (3 payments)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['28 cities in the United States'],
    NULL,
    NULL,
    NULL,
    NULL,
    '10,400',
    'Formerly incarcerated individuals',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Returning Citizen Stimulus (RCS) Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Returning Citizen Stimulus (RCS) Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    263,
    'Project 100+',
    'GiveDirectly',
    'Project 100+ is a guaranteed basic income initiative in Multiple, organized by GiveDirectly. Implemented during April 2020 - October 2021. Enrolled 200,000 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (one time)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Multiple'],
    NULL,
    NULL,
    NULL,
    NULL,
    '200,000',
    'Individuals who are Providers (Electronic Benefit Transfer) app users and receive Supplemental Nutrition Assistance Program funds',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Project 100+' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Project 100+'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    264,
    'Bootstraps',
    'Pale Blue Dot Media',
    'Bootstraps is a guaranteed basic income initiative in United States, organized by Pale Blue Dot Media. Implemented during 2018 -. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$12,000 (yearly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Twenty Americans randomly selected by filmmakers',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Bootstraps' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Bootstraps'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    265,
    'Growing Strong',
    'Women in Need Homeless Shelter System',
    'Growing Strong is a guaranteed basic income initiative in United States, organized by Women in Need Homeless Shelter System. Implemented during January 2020 -. Enrolled 200 participants. Data documented by the Stanford Basic Income Lab.',
    1500,
    'USD',
    '$1,500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    2,
    'female'::public.program_gender_requirement,
    NULL,
    '200',
    'Mothers with children under 2 experiencing homelessness living at specific WIN shelters',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Growing Strong' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Growing Strong'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    266,
    'The Resilience Fund',
    'Polaris',
    'The Resilience Fund is a guaranteed basic income initiative in United States, organized by Polaris. Implemented during 12/1/2023 - 7/1/2025. Enrolled 24 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '24',
    'Eligible participants are survivors of human trafficking, encompassing both sex and labor trafficking, residing in the United States',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'The Resilience Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'The Resilience Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    267,
    'Immigrant Families Recovery Program - National',
    'Mission Asset Fund (MAF)',
    'Immigrant Families Recovery Program - National is a guaranteed basic income initiative in United States, organized by Mission Asset Fund (MAF). Implemented during 2021 - 2023. Enrolled 3000 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Monthly basic income support',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    50000,
    '3000',
    'Families who previously received an Immigrant Families Grant from MAF. Families are immigrant families with young children who have been excluded from federal relief.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Immigrant Families Recovery Program - National' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Immigrant Families Recovery Program - National'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    268,
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina',
    'Rural GMI Initiative',
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina is a guaranteed basic income initiative in Beaufort County, NC, organized by Rural GMI Initiative. Implemented during 11/3/2025 -. Enrolled About 530 participants. Data documented by the Stanford Basic Income Lab.',
    1500,
    'USD',
    '$1,500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Beaufort County'],
    NULL,
    NULL,
    NULL,
    40000,
    'About 530',
    'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    269,
    'Rural Income Maintenance Experiment — Duplic County, NC',
    'Institute for Research on Poverty',
    'Rural Income Maintenance Experiment is a guaranteed basic income initiative in Duplic County, NC, organized by Institute for Research on Poverty. Implemented during 1970 - 1972. Enrolled 810 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Duplic County'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '810',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rural Income Maintenance Experiment — Duplic County, NC' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rural Income Maintenance Experiment — Duplic County, NC'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    270,
    'Excel',
    'StepUp Durham',
    'Excel is a guaranteed basic income initiative in Durham, NC, organized by StepUp Durham. Implemented during March 2022 - February 2023. Enrolled 109 participants. Data documented by the Stanford Basic Income Lab.',
    600,
    'USD',
    '600 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Durham'],
    NULL,
    NULL,
    NULL,
    50000,
    '109',
    'Individuals who have been released from prison (NC State prison, a prison in another state, or federal prison) within the last 5 years prior to application, returning to a Durham address (City or County), and with an income below 60% Durham-Chapel Hill AMI.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Excel' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Excel'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    271,
    'Baby''s First Years - Nebraska',
    'Teacher''s College',
    'Baby''s First Years - Nebraska is a guaranteed basic income initiative in Greater Omaha metropolitan area, NE, organized by Teacher''s College. Implemented during 5/1/2018 -. Enrolled 1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    20,
    'USD',
    '$20 or $333 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Greater Omaha metropolitan area'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)',
    'Low-income mothers with newborns',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Baby''s First Years - Nebraska' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Baby''s First Years - Nebraska'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    272,
    'New Jersey Income Maintenance Experiment',
    'Institute for Research on Poverty',
    'New Jersey Income Maintenance Experiment is a guaranteed basic income initiative in Jersey City, NJ, organized by Institute for Research on Poverty. Implemented during 1968-1972. Enrolled 1357 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Jersey City'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '1357',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Jersey Income Maintenance Experiment' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Jersey Income Maintenance Experiment'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    273,
    'Newark Movement for Economic Equity',
    'City of Newark',
    'Newark Movement for Economic Equity is a guaranteed basic income initiative in Newark, NJ, organized by City of Newark. Implemented during October 2021 - September 2023. Enrolled 200 receiving bi-weekly payment, 200 receiving bi-annual payment participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    21,
    'USD',
    '250  (bi-weekly) or 3000 (semi-annually) USD (bi-weekly and semi-annually)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Newark'],
    NULL,
    NULL,
    NULL,
    40000,
    '200 receiving bi-weekly payment, 200 receiving bi-annual payment',
    'Individuals 18 and over with an income 200% below the federal poverty income line and who are housing insecure',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Newark Movement for Economic Equity' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Newark Movement for Economic Equity'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    274,
    'New Jersey Income Maintenance Experiment — Paterson, NJ',
    'Institute for Research on Poverty',
    'New Jersey Income Maintenance Experiment is a guaranteed basic income initiative in Paterson, NJ, organized by Institute for Research on Poverty. Implemented during 1968-1973. Enrolled 1357 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Paterson'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '1357',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Jersey Income Maintenance Experiment — Paterson, NJ' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Jersey Income Maintenance Experiment — Paterson, NJ'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    275,
    'Paterson Guaranteed Income Pilot Program',
    'City of Paterson',
    'Paterson Guaranteed Income Pilot Program is a guaranteed basic income initiative in Paterson, NJ, organized by City of Paterson. Implemented during July 2021 - June 2022. Enrolled 110 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Paterson'],
    NULL,
    NULL,
    NULL,
    NULL,
    '110',
    'Individuals 18 and over with an annual income $30,000 or less for individuals and $88,000 or less for households',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Paterson Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Paterson Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    276,
    'New Jersey Income Maintenance Experiment — Prassaic, NJ',
    'Institute for Research on Poverty',
    'New Jersey Income Maintenance Experiment is a guaranteed basic income initiative in Prassaic, NJ, organized by Institute for Research on Poverty. Implemented during 1968-1974. Enrolled 1357 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Prassaic'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '1357',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Jersey Income Maintenance Experiment — Prassaic, NJ' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Jersey Income Maintenance Experiment — Prassaic, NJ'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    277,
    'New Jersey Income Maintenance Experiment — Scranton, NJ',
    'Institute for Research on Poverty',
    'New Jersey Income Maintenance Experiment is a guaranteed basic income initiative in Scranton, NJ, organized by Institute for Research on Poverty. Implemented during 1968-1976. Enrolled 1357 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Scranton'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '1357',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Jersey Income Maintenance Experiment — Scranton, NJ' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Jersey Income Maintenance Experiment — Scranton, NJ'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    278,
    'New Jersey Income Maintenance Experiment — Trenton, NJ',
    'Institute for Research on Poverty',
    'New Jersey Income Maintenance Experiment is a guaranteed basic income initiative in Trenton, NJ, organized by Institute for Research on Poverty. Implemented during 1968-1975. Enrolled 1357 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Varied (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Trenton'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    40000,
    '1357',
    'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Jersey Income Maintenance Experiment — Trenton, NJ' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Jersey Income Maintenance Experiment — Trenton, NJ'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    279,
    'Students Experiencing Homelessness Basic Needs Stipend Pilot',
    'New Mexico Appleseed',
    'Students Experiencing Homelessness Basic Needs Stipend Pilot is a guaranteed basic income initiative in Albuquerque and La Cruces, NM, organized by New Mexico Appleseed. Implemented during 2020- 2021. Enrolled 53 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Albuquerque and La Cruces'],
    NULL,
    NULL,
    NULL,
    NULL,
    '53',
    'High school students who qualify as unhoused or underhoused',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Students Experiencing Homelessness Basic Needs Stipend Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Students Experiencing Homelessness Basic Needs Stipend Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    280,
    'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot',
    'New Mexico Appleseed',
    'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot is a guaranteed basic income initiative in Alburquerque, NM, organized by New Mexico Appleseed. Implemented during January 2020 - December 2021. Enrolled 65 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Monthly',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alburquerque'],
    NULL,
    NULL,
    NULL,
    NULL,
    '65',
    '9th graders and other high-school students who live in housing conditions eligible for services under the federal law',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    281,
    'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families',
    'UpTogether',
    'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families is a guaranteed basic income initiative in Bernalillo County, Santa Fe County, Rio Arriba County, McKinley County, Curry County, Roosevelt County, San Juan County, Chaves County, Lea County, Doña Ana County, Luna County, Grant County, and Hidalgo County., organized by UpTogether. Implemented during January 2022 - December 2023. Enrolled 330 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Bernalillo County'],
    NULL,
    NULL,
    NULL,
    50000,
    '330',
    'Individuals in a undocumented or mixed-status family who are the parent or legal guardian of at least one minor child or an adult with a disability',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    282,
    'Family Prosperity',
    'Community Action Agency',
    'Family Prosperity is a guaranteed basic income initiative in La Cruces, NM, organized by Community Action Agency. Implemented during 7/19/2023 - 7/19/2025. Enrolled 300 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['La Cruces'],
    NULL,
    NULL,
    NULL,
    NULL,
    '300',
    'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Single Caregiver Households',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Prosperity' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Prosperity'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    283,
    'Santa Fe Learn, Earn, Achieve Program (SF LEAP)',
    'City of Santa Fe',
    'Santa Fe Learn, Earn, Achieve Program (SF LEAP) is a guaranteed basic income initiative in Santa Fe, NM, organized by City of Santa Fe. Implemented during October 2021 - September 2022. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    400,
    'USD',
    '400 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Santa Fe'],
    NULL,
    NULL,
    NULL,
    40000,
    '100',
    'Individuals between 18-30 with an income 200% below the federal poverty line enrolled in a certificate or degree program at Santa Fe Community College',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Santa Fe Learn, Earn, Achieve Program (SF LEAP)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Santa Fe Learn, Earn, Achieve Program (SF LEAP)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    284,
    'Jubilant Birth',
    'United Way of the Greater Capital Region',
    'Jubilant Birth is a guaranteed basic income initiative in Albany, NY, organized by United Way of the Greater Capital Region. Implemented during 5/6/2025 - 5/6/2026. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Albany'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '25',
    'Low-income, pregnant women in Albany, New York',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Jubilant Birth' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Jubilant Birth'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    285,
    'Artist Grants Program',
    'The Local Sounds Collaborative',
    'Artist Grants Program is a guaranteed basic income initiative in Rochester, NY, organized by The Local Sounds Collaborative. Enrolled 6 participants. Data documented by the Stanford Basic Income Lab.',
    200,
    'USD',
    '200 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Rochester'],
    NULL,
    NULL,
    NULL,
    NULL,
    '6',
    'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), and Identification as a member, worker, and/or participant within the local music community (live musician, studio musician, production engineer, sound technician, etc) and demonstrate financial need',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Artist Grants Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Artist Grants Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    286,
    'HudsonUP',
    'City of Hudson',
    'HudsonUP is a guaranteed basic income initiative in Hudson, NY, organized by City of Hudson. Implemented during November 2020 - September 2026. Enrolled 75 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Hudson'],
    NULL,
    NULL,
    NULL,
    NULL,
    '75',
    'Individuals 18 and over who earn less than City of Hudson median annual income of $35,153',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'HudsonUP' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'HudsonUP'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    287,
    'Ithaca Guaranteed Income',
    'Human Services Coalition of Tompkins County',
    'Ithaca Guaranteed Income is a guaranteed basic income initiative in Ithaca, NY, organized by Human Services Coalition of Tompkins County. Implemented during June 2022 - May 2023. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    450,
    'USD',
    '450 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Ithaca'],
    NULL,
    NULL,
    NULL,
    NULL,
    '110',
    'Primary unpaid caregivers to children and aging or disabled adults with an income at or below 80% area median income',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ithaca Guaranteed Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ithaca Guaranteed Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    288,
    'Level Up Guaranteed Income Pilot',
    'City of Mount Vernon',
    'Level Up Guaranteed Income Pilot is a guaranteed basic income initiative in Mount Vernon, NY, organized by City of Mount Vernon. Implemented during November 2022 - October 2024. Enrolled 200 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Mount Vernon'],
    NULL,
    NULL,
    NULL,
    NULL,
    '200',
    '‍Individuals at least 18 years of age, have a minimum income requirement of $15,000, but no more than at or below 80% percent of the CDBG Annual Income Limit.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Level Up Guaranteed Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Level Up Guaranteed Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    289,
    'Family Goal Fund — New York, NY',
    'LIFT',
    'Family Goal Fund is a guaranteed basic income initiative in New York, NY, organized by LIFT. Implemented during January 2018 -. Enrolled 800+ participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '150 USD (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '800+',
    'Households in the LIFT program with low-income and children 0-8 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Family Goal Fund — New York, NY' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Family Goal Fund — New York, NY'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    290,
    'Baby''s First Years - New York',
    'Teacher''s College',
    'Baby''s First Years - New York is a guaranteed basic income initiative in New York City, NY, organized by Teacher''s College. Implemented during 5/1/2018 -. Enrolled 1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    20,
    'USD',
    '$20 or $333 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['New York City'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)',
    'Low-income mothers with newborns',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Baby''s First Years - New York' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Baby''s First Years - New York'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    291,
    'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness',
    'Point Source Youth',
    'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness is a guaranteed basic income initiative in New York, NY, organized by Point Source Youth. Implemented during March 2022 - May 2024. Enrolled 30 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1250,
    'USD',
    '1250 USD (bi-monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    18,
    24,
    NULL,
    NULL,
    '30',
    'LGBTQIA Youth 18-24 who are unhoused or underhoused',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    292,
    'City of Rochester Guaranteed Basic Income (GBI) Pilot Program',
    'City of Rochester',
    'City of Rochester Guaranteed Basic Income (GBI) Pilot Program is a guaranteed basic income initiative in Rochester, NY, organized by City of Rochester. Implemented during 10/15/2023 - 11/1/2024. Enrolled 351 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Rochester', 'Qualified Census tracts'],
    NULL,
    NULL,
    NULL,
    NULL,
    '351',
    'Residents meeting the income criteria',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'City of Rochester Guaranteed Basic Income (GBI) Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'City of Rochester Guaranteed Basic Income (GBI) Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    293,
    'Artist Grants',
    'The Local Sound',
    'Artist Grants is a guaranteed basic income initiative in Rochester, NY, organized by The Local Sound. Implemented during June 2022 - May 2023. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    200,
    'USD',
    '200 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Rochester'],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Individuals 18 and older, who identify s a member, worker, and/or participant within the local music community (live musician, studio musician, production engineer, sound technician, etc), with spots reserved for artists of color. Year 1 supported 5 artists, Year 2 supported 7 artists, Year 3 supported 8 artists.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Artist Grants' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Artist Grants'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    294,
    'Project Resilience',
    'Ulster County',
    'Project Resilience is a guaranteed basic income initiative in Ulster County, NY, organized by Ulster County. Implemented during May 2021 - April 2022. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Ulster County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Individuals making less than 80% area median income of $46,900',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Project Resilience' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Project Resilience'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    295,
    'CRNY Guaranteed Income for Artists',
    'Creatives Rebuild New York',
    'CRNY Guaranteed Income for Artists is a guaranteed basic income initiative in New York State, organized by Creatives Rebuild New York. Implemented during 6/1/2022 - 3/31/2024. Enrolled 2400 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['New York State'],
    18,
    NULL,
    NULL,
    NULL,
    '2400',
    'Individuals 18 years or older as of January 1, 2022, with financial need, and who identify as an artist, culture bearer, or culture maker.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'CRNY Guaranteed Income for Artists' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'CRNY Guaranteed Income for Artists'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    296,
    'Ohio Mothers Trust',
    'Motherful',
    'Ohio Mothers Trust is a guaranteed basic income initiative in Columbus, OH, organized by Motherful. Implemented during 12/1/2024 - 11/1/2025. Enrolled 32 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Columbus'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '32',
    'Single mothers with incomes at or below 80% of the area median',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ohio Mothers Trust' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ohio Mothers Trust'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    297,
    'YSEQUITY',
    'Yellow Springs Community Foundation',
    'YSEQUITY is a guaranteed basic income initiative in Yellow Springs, Ohio, organized by Yellow Springs Community Foundation. Implemented during January 2023 - December 2025. Enrolled 90 participants. Data documented by the Stanford Basic Income Lab.',
    300,
    'USD',
    '300 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Yellow Springs'],
    NULL,
    NULL,
    NULL,
    50000,
    '90',
    'Residents of Yellow Springs and Miami Township, Ohio. 18 or older. Meets a certain income threshold. Weighted lottery favors single parents and those in the lowest income bracket.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'YSEQUITY' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'YSEQUITY'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    298,
    'UpTogether Tusla',
    'UpTogether',
    'UpTogether Tusla is a guaranteed basic income initiative in Tusla, OK, organized by UpTogether. Implemented during July 2021 - October 2023. Enrolled 304 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Tusla'],
    NULL,
    NULL,
    NULL,
    40000,
    '304',
    'Individuals with at least one minor dependent child under the age of 9 in the household with a household income at lr below 150% the Federal Poverty Line',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'UpTogether Tusla' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'UpTogether Tusla'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    299,
    'Southern Oregon Success',
    'UpTogether',
    'Southern Oregon Success is a guaranteed basic income initiative in Jackson and Josephine Counties, OR, organized by UpTogether. Implemented during March 2022 - July 2023. Enrolled 70 participants. Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '100 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Jackson and Josephine Counties'],
    NULL,
    NULL,
    NULL,
    NULL,
    '70',
    'Priority given to individuals who were forced to move because of the Alameda Fires in 2021',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Southern Oregon Success' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Southern Oregon Success'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    300,
    'Oregon Direct Cash Transfers Plus',
    'Point Source Youth',
    'Oregon Direct Cash Transfers Plus is a guaranteed basic income initiative in Multnomah, Clackamas, and Deschutes County, OR, organized by Point Source Youth. Implemented during 2/1/2023 - 2/1/2025. Enrolled 120 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Multnomah'],
    NULL,
    NULL,
    NULL,
    NULL,
    '120',
    'Individuals between 18 and 24 actively experiencing homelessness',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Oregon Direct Cash Transfers Plus' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Oregon Direct Cash Transfers Plus'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    301,
    'Black Resilience Fund',
    'Brown Hope',
    'Black Resilience Fund is a guaranteed basic income initiative in Portland, OR, organized by Brown Hope. Implemented during 6/1/2020 -12/31/2025. Enrolled 50 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 for adults, $1,500 for adults with 1 or 2 children, $2,000 for adults with 3 or more children (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Portland'],
    NULL,
    NULL,
    NULL,
    NULL,
    '50',
    'Individuals at least 18 years of age, identify as Black, African American or African and a Multonomah County resident, below an income threshold. 30-40% of program participants were members of priority communities including: formerly incarcerated, single parents, minimum-wage or low-wage workers (within $2 of Portland''s minimum wage), or foster care alumni',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Black Resilience Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Black Resilience Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    302,
    'Path Home Basic Income Guarantee Pilot Project',
    'Path Home',
    'Path Home Basic Income Guarantee Pilot Project is a guaranteed basic income initiative in Portland, Oregon, organized by Path Home. Implemented during 2/1/2022 - 1/1/2024. Enrolled 6 participants. Data documented by the Stanford Basic Income Lab.',
    575,
    'USD',
    '$575 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Portland'],
    NULL,
    NULL,
    NULL,
    50000,
    '6',
    'Families with children who have experienced homelessness or housing instability',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Path Home Basic Income Guarantee Pilot Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Path Home Basic Income Guarantee Pilot Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    303,
    'Path Home Cash Transfer Pilot Program',
    'Path Home',
    'Path Home Cash Transfer Pilot Program is a guaranteed basic income initiative in Portland Oregon and surrounding area, organized by Path Home. Implemented during 4/15/2024 - 3/15/2026. Enrolled 15 participants. Data documented by the Stanford Basic Income Lab.',
    575,
    'USD',
    '$575 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Portland Oregon and surrounding area'],
    NULL,
    NULL,
    NULL,
    40000,
    '15',
    'Households with children in the Portland area that have stable income of at least $30,660 per year (or $2,555 per month) and no greater than 200% of the Federal Poverty Guideline. Payments are disbursed through direct deposit, with an option to open a new account with a local credit union through a partnership with Path Home for unbanked participants or any participants interested in utilizing a credit union. Data tracking conducted quarterly to track participants'' sense of mental/physical wellbeing and financial and housing stability. Participants agree to participate in a quarterly survey and assessments throughout the duration of the program and follow-ups for several years following.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Path Home Cash Transfer Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Path Home Cash Transfer Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    304,
    'Multnomah Mothers'' Trust',
    'Multonomah Ideas Lab',
    'Multnomah Mothers'' Trust is a guaranteed basic income initiative in Multonomah County, OR, organized by Multonomah Ideas Lab. Implemented during January 2022 - June 2022. Enrolled 75 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Multonomah County'],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '75',
    'Black women with children',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Multnomah Mothers'' Trust' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Multnomah Mothers'' Trust'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    305,
    'Osage ARP Cash Assistance',
    'Osage Nation',
    'Osage ARP Cash Assistance is a guaranteed basic income initiative in Osage Nation, organized by Osage Nation. Implemented during August 2021. Enrolled 11,721 participants. Data documented by the Stanford Basic Income Lab.',
    2000,
    'USD',
    'Up to 2000 USD (one time)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Osage Nation'],
    NULL,
    NULL,
    NULL,
    NULL,
    '11,721',
    'Enrolled members of Osage Nation who attest to negative economic impact from COVID-19',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Osage ARP Cash Assistance' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Osage ARP Cash Assistance'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    306,
    'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families',
    'Children''s Hospital of Philadelphia',
    'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families is a guaranteed basic income initiative in Philadelphia, PA, organized by Children''s Hospital of Philadelphia. Implemented during 7/26/2023 - 11/14/2023. Enrolled 24 participants. Data documented by the Stanford Basic Income Lab.',
    325,
    'USD',
    '$325 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Philadelphia'],
    18,
    45,
    NULL,
    NULL,
    '24',
    'Low-income parent-infant dyads',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    307,
    'Guaranteed Resources Optimize Wellbeing (GROW)',
    'Office of Community Empowerment and Opportunity',
    'Guaranteed Resources Optimize Wellbeing (GROW) is a guaranteed basic income initiative in Philadelphia, PA, organized by Office of Community Empowerment and Opportunity. Implemented during 6/1/2023 - June 2024. Enrolled 51 experiment, 239 control participants. Data documented by the Stanford Basic Income Lab.',
    50,
    'USD',
    '$50 or $500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Philadelphia'],
    NULL,
    NULL,
    NULL,
    NULL,
    '51 experiment, 239 control',
    'E-TANF beneficiaries are parents who have received TANF benefits for at least 60 months and experience circumstances that prevent them from securing and maintaining full-time employment. All E-TANF beneficiaries in Philadelphia participate in the Work Ready workforce development program administered by JEVS Human Services.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Resources Optimize Wellbeing (GROW)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Guaranteed Resources Optimize Wellbeing (GROW)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    308,
    'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)',
    'Thomas Jefferson University Hospital Sidney Kimmel Cancer Center',
    'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT) is a guaranteed basic income initiative in Philadelphia, PA, organized by Thomas Jefferson University Hospital Sidney Kimmel Cancer Center. Implemented during 4/1/2023 - 4/1/2024. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Philadelphia'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Low-income, advanced stage cancer patients over the age of 18, receiving chemotherapy or immunotherapy who are Pennsylvania Medicaid beneficiaries',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    309,
    'Philadelphia Guaranteed Income Program',
    'WorkReady',
    'Philadelphia Guaranteed Income Program is a guaranteed basic income initiative in Philadelphia, PA, organized by WorkReady. Implemented during March 2022 - March 2023. Enrolled Up to 60 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Philadelphia'],
    NULL,
    NULL,
    NULL,
    50000,
    'Up to 60',
    'Recipients of Temporary Assistance for Needy Families (TANF)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Philadelphia Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Philadelphia Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    310,
    'Providence Guaranteed Income Program',
    'City of Providence',
    'Providence Guaranteed Income Program is a guaranteed basic income initiative in Rhode Island, organized by City of Providence. Implemented during November 2021 - April 2023. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    40000,
    '110',
    'Individuals making incomes below 200% of the Federal Poverty Line ($25,760 and below for single person)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Providence Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Providence Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    311,
    'CLIMB (Columbia Life Improvement Monetary Boost)',
    'City of Columbia',
    'CLIMB (Columbia Life Improvement Monetary Boost) is a guaranteed basic income initiative in Columbia, SC, organized by City of Columbia. Implemented during September 2021 - August 2022. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Columbia'],
    NULL,
    NULL,
    'male'::public.program_gender_requirement,
    NULL,
    '100',
    'Father who are currently or recently enrolled in a program with the Midland Fathers Coalition',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'CLIMB (Columbia Life Improvement Monetary Boost)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'CLIMB (Columbia Life Improvement Monetary Boost)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    312,
    '37208 Demonstration',
    'Moving Nashville Forward (MOVE)',
    '37208 Demonstration is a guaranteed basic income initiative in Nashville, TN, organized by Moving Nashville Forward (MOVE). Implemented during November 2021 - October 2022. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['37208 Zip Code', 'Nashville'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Individuals in target zip code making less than $40,000/year',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = '37208 Demonstration' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = '37208 Demonstration'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    313,
    'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program',
    'Black Music Action Coalition (BMAC) and the Academy of Country Music (ACM)',
    'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program is a guaranteed basic income initiative in Nashville, TN, organized by Black Music Action Coalition (BMAC) and the Academy of Country Music (ACM). Implemented during 6/1/2023 -. Enrolled 20 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Nashville'],
    NULL,
    NULL,
    NULL,
    NULL,
    '20',
    'Black members of the music community',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    314,
    'Austin''s Guaranteed Income Pilot Program',
    'City of Austin (including Austin Public Health',
    'Austin''s Guaranteed Income Pilot Program is a guaranteed basic income initiative in Austin, TX, organized by City of Austin (including Austin Public Health. Implemented during September 2022 - September 2023. Enrolled 135 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '1000 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Austin', 'City of Austin and Travis County'],
    NULL,
    NULL,
    NULL,
    50000,
    '135',
    'Households with a  household income that is at or below 60% of the Area Median Family Income ($66,180 for a household of 4) and who meet at least one of the four other criteria: moving from homelessness toward permanent housing; have a filed eviction; household has been behind on rent for 2 or more months over the past year; and/or household has received a verbal or written notice of intent to evict OR a threat to vacate by landlord or property manager at any time within the past 3 months due to nonpayment of rent',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Austin''s Guaranteed Income Pilot Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Austin''s Guaranteed Income Pilot Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    315,
    'Central Texas 12-Month Pilot',
    'UpTogether',
    'Central Texas 12-Month Pilot is a guaranteed basic income initiative in Austin and Georgetown, TX, organized by UpTogether. Implemented during March 2021 - March 2022. Enrolled 173 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Austin and Georgetown', 'City of Austin zip codes: 78752, 78721, 78724, 78732, 78753 and City of Georgetown'],
    NULL,
    NULL,
    NULL,
    40000,
    '173',
    'Households that earn an income at or below 200% of the Federal Poverty Level at the time of enrollment and live in a targeted zip code in the City of Austin. Outreach was focussed on those who had experienced hardship due to COVID-19.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Central Texas 12-Month Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Central Texas 12-Month Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    316,
    'Dallas Targeted Eviction Prevention Program Fund',
    'UpTogether',
    'Dallas Targeted Eviction Prevention Program Fund is a guaranteed basic income initiative in Dallas, TX, organized by UpTogether. Implemented during December 2021 - November 2024. Enrolled 500 participants. Data documented by the Stanford Basic Income Lab.',
    3000,
    'USD',
    '3000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['South Dallas', 'Dallas'],
    NULL,
    NULL,
    NULL,
    NULL,
    '500',
    'Households who have at least one child enrolled in a target school in South Dallas, Texas.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Dallas Targeted Eviction Prevention Program Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Dallas Targeted Eviction Prevention Program Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    317,
    'UpTogether Morningside',
    'UpTogether',
    'UpTogether Morningside is a guaranteed basic income initiative in Fort Worth, TX, organized by UpTogether. Implemented during January 2022 - January 2023. Enrolled 30 participants. Data documented by the Stanford Basic Income Lab.',
    265,
    'USD',
    '265 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Fort Worth'],
    NULL,
    NULL,
    NULL,
    50000,
    '30',
    'Families identified by a community organization that have at least one child enrolled in Morningside Elementary School in Fort Worth, Texas and are eligible for free/reduced price school lunch.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'UpTogether Morningside' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'UpTogether Morningside'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    318,
    'Houston Equity Fund',
    'The Houston Fund',
    'Houston Equity Fund is a guaranteed basic income initiative in Houston, TX, organized by The Houston Fund. Implemented during September 2022 - August 2023. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    375,
    'USD',
    '375 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Houston'],
    NULL,
    NULL,
    NULL,
    40000,
    '110',
    'Individuals at least 18 years old at the time of application, and have an income at or below the federal poverty level.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Houston Equity Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Houston Equity Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    319,
    'Rising UpTogether San Antonio',
    'UpTogether',
    'Rising UpTogether San Antonio is a guaranteed basic income initiative in San Antonio, TX, organized by UpTogether. Implemented during 4/1/2021 - 1/1/2023. Enrolled 1,000 participants. Data documented by the Stanford Basic Income Lab.',
    133,
    'USD',
    '$400 (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Antonio'],
    NULL,
    NULL,
    NULL,
    40000,
    '1,000',
    'Individuals and families with household incomes below 150% of the federal poverty line',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rising UpTogether San Antonio' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rising UpTogether San Antonio'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    320,
    'San Antonio Basic Income Pilot',
    'UpTogether',
    'San Antonio Basic Income Pilot is a guaranteed basic income initiative in San Antonio, TX, organized by UpTogether. Implemented during December 2020 - January 2023. Enrolled 1000 participants. Data documented by the Stanford Basic Income Lab.',
    636,
    'USD',
    'Lump sum of 1,908 USD and 400 USD quarterly (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['San Antonio', '78207 or 78227 zip codes'],
    NULL,
    NULL,
    NULL,
    40000,
    '1000',
    'Households with an income at or below 150% of the poverty level who live in the City of San Antonio in zip code 78207 or 78227, in a household of 4 - 8 people. The first 180 eligible households received the transfer.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'San Antonio Basic Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'San Antonio Basic Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    321,
    'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) — Texas and Illinois',
    'OpenResearch',
    'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) is a guaranteed basic income initiative in Texas and Illinois, organized by OpenResearch. Implemented during 11/1/2020 - 10/31/2023. Enrolled 3,000 participants. Data documented by the Stanford Basic Income Lab.',
    1000,
    'USD',
    '$1,000 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Texas and Illinois'],
    NULL,
    NULL,
    NULL,
    40000,
    '3,000',
    'Individuals living in one of 19 study counties in Texas and Illinois who were aged 21 to 40, with total household income less than 300% of the federal poverty line (average annual household income of $29,900), not receiving SSI or living in public housing (to avoid risk of losing these key public benefits). Pilot was structured as a randomized controlled trial (RCT), with 1,000 individuals randomly assigned to the treatment group to receive $1,000 per month, and 2,000 individuals randomly assigned to the control group to receive $50 per month. Extensive data were collected with study results available at https://www.openresearchlab.org/projects/unconditional-cash-study.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) — Texas and Illinois' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) — Texas and Illinois'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    322,
    'Alexandria Recurring Income for Success and Equity (ARISE)',
    'City of Alexandria',
    'Alexandria Recurring Income for Success and Equity (ARISE) is a guaranteed basic income initiative in Alexandria, VA, organized by City of Alexandria. Implemented during Feb 2023 - June 2025. Enrolled 170 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Alexandria', 'Four zip codes (22312, 22311, 22304, 22305) within US Department of Housing and Urban Development ''qualified census tracts'''],
    NULL,
    NULL,
    NULL,
    NULL,
    '170',
    'Individuals making at or below 50% of the City''s Area Median Income',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Alexandria Recurring Income for Success and Equity (ARISE)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Alexandria Recurring Income for Success and Equity (ARISE)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    323,
    'Arlington''s Guarantee',
    'Arlington Community Foundation',
    'Arlington''s Guarantee is a guaranteed basic income initiative in Arlington, VA, organized by Arlington Community Foundation. Implemented during September 2021 - December 2022. Enrolled 200 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Arlington'],
    NULL,
    NULL,
    NULL,
    NULL,
    '200',
    '2nd generation households below 30% area median income and enrolled in local housing program',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Arlington''s Guarantee' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Arlington''s Guarantee'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    324,
    'Fairfax County Economic Mobility Pilot (FCEMP)',
    'Fairfax Neighborhood and Community Services',
    'Fairfax County Economic Mobility Pilot (FCEMP) is a guaranteed basic income initiative in Fairfax, VA, organized by Fairfax Neighborhood and Community Services. Implemented during 10/1/2023 - January 2026. Enrolled 180 participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '$750 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Fairfax'],
    NULL,
    NULL,
    NULL,
    40000,
    '180',
    'Asset-limited, income-constrained, employed population, that earn more than the Federal Poverty Level, but less than the basic cost of living for county/state in which they live',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Fairfax County Economic Mobility Pilot (FCEMP)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Fairfax County Economic Mobility Pilot (FCEMP)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    325,
    'Richmond Resilience Initiative (RRI)',
    'City of Richmond Office of Community Wealth Building',
    'Richmond Resilience Initiative (RRI) is a guaranteed basic income initiative in Richmond, VA, organized by City of Richmond Office of Community Wealth Building. Implemented during October 2020 - May 2024. Enrolled Two cohorts totaling 64 individuals participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Richmond'],
    NULL,
    NULL,
    NULL,
    NULL,
    'Two cohorts totaling 64 individuals',
    'Currently reside in the city of Richmond, Virginia; employed and earning over $12.71 per hour (the full-time wage federal benefits threshold); have children under the age of 18 living in the household; and not receiving federal benefits, including housing vouchers or assistance.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Richmond Resilience Initiative (RRI)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Richmond Resilience Initiative (RRI)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    326,
    'Spectrum Pilots Direct Cash Transfer Program',
    'Spectrum Youth & Family Services',
    'Spectrum Pilots Direct Cash Transfer Program is a guaranteed basic income initiative in Burlingame, VT, organized by Spectrum Youth & Family Services. Implemented during 8/1/2023 - 1/1/2025. Enrolled 10 participants. Data documented by the Stanford Basic Income Lab.',
    1628,
    'USD',
    '$750 (bi-weekly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Burlingame'],
    18,
    24,
    NULL,
    NULL,
    '10',
    'Youth facing homelessness or at immediate risk of homelessness',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Spectrum Pilots Direct Cash Transfer Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Spectrum Pilots Direct Cash Transfer Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    327,
    'King County GBI Pilot',
    'Workforce Development Council of Seattle-King County',
    'King County GBI Pilot is a guaranteed basic income initiative in King County, WA, organized by Workforce Development Council of Seattle-King County. Implemented during 12/1/2022 - 12/1/2024. Enrolled 102 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['King County'],
    NULL,
    NULL,
    NULL,
    NULL,
    '102',
    'Ranging from people with low-income to students and justice-involved adults',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'King County GBI Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'King County GBI Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    328,
    'South King County Pilot',
    'Rainier Beach Action Coalition and Urban Family',
    'South King County Pilot is a guaranteed basic income initiative in King County, WA, organized by Rainier Beach Action Coalition and Urban Family. Implemented during 11/1/2022 - 8/1/2023. Enrolled 10 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['King County', 'South King County'],
    NULL,
    NULL,
    NULL,
    50000,
    '10',
    'Extremely low-income families residing in King County District 2',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'South King County Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'South King County Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    329,
    'Hummingbird Nest',
    'Hummingbird Indigenous Family Services',
    'Hummingbird Nest is a guaranteed basic income initiative in King County, Pierce County, and Tulalip Reservation, WA, organized by Hummingbird Indigenous Family Services. Implemented during 8/1/2023 -. Enrolled 150 participants. Data documented by the Stanford Basic Income Lab.',
    1250,
    'USD',
    '$1,250 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['King County'],
    18,
    45,
    'female'::public.program_gender_requirement,
    NULL,
    '150',
    'At least 12 weeks pregnant and planning to parent, Indigenous to North America/Pacific Islander Living in: King County, Pierce County, or the Tulalip Reservation. King County Income under: $70k for a 2 person household* $85k for a 3 person household* $100k for a 4+ person household*, Pierce County Income under: $55k for a 2 person household* $70k for a 3 person household* $85k for a 4+ person household*',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Hummingbird Nest' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Hummingbird Nest'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    330,
    'Olympic Community Action Programs GBI Pilot',
    'Olympic Community Actions Programs',
    'Olympic Community Action Programs GBI Pilot is a guaranteed basic income initiative in North Olympic Peninsula, WA, organized by Olympic Community Actions Programs. Implemented during 1/1/2022 - 6/1/2023. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '$500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['North Olympic Peninsula'],
    NULL,
    NULL,
    NULL,
    50000,
    '25',
    'Families enrolled in the sponsor organization''s early childhood services programs',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Olympic Community Action Programs GBI Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Olympic Community Action Programs GBI Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    331,
    'Seattle-Denver Income Maintenance Experiment (SIME/DIME) — Seattle, WA',
    'Stanford Research Institute',
    'Seattle-Denver Income Maintenance Experiment (SIME/DIME) is a guaranteed basic income initiative in Seattle, WA, organized by Stanford Research Institute. Implemented during 1971  - 1982. Enrolled 4800 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    316,
    'USD',
    '316, 400 or 466 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Seattle'],
    NULL,
    NULL,
    NULL,
    50000,
    '4800',
    'Families with income less than $9000 USD if one head of household was employed and less than $11,000 USD if both employed, with even number of white, black and Mexican-American households selected (last group only in Denver, CO)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME) — Seattle, WA' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME) — Seattle, WA'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    332,
    'Growing Resilience in Tacoma (GRIT)',
    'City of Tacoma',
    'Growing Resilience in Tacoma (GRIT) is a guaranteed basic income initiative in Tacoma, WA, organized by City of Tacoma. Implemented during December 2021 - November 2022. Enrolled 110 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Eastside (98404), Hilltop (98405), South Tacoma (98409), South End (98408)', 'Tacoma'],
    NULL,
    NULL,
    NULL,
    NULL,
    '110',
    'Single parent or guardian households with children in eligible zip codes, asset limited and income constrained',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Growing Resilience in Tacoma (GRIT)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Growing Resilience in Tacoma (GRIT)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    333,
    'Madison Guaranteed Income Pilot Program (Madison Forward Fund)',
    'TASC Madison',
    'Madison Guaranteed Income Pilot Program (Madison Forward Fund) is a guaranteed basic income initiative in Madison, WI, organized by TASC Madison. Implemented during Sept 2022 - Aug 2023. Enrolled 155 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    '500 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Madison'],
    NULL,
    18,
    NULL,
    40000,
    '155',
    'Individuals 18 and older with a household income less than 200% of the Federal Poverty Line, and with a child under 18 years old living at home.',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Madison Guaranteed Income Pilot Program (Madison Forward Fund)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Madison Guaranteed Income Pilot Program (Madison Forward Fund)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    334,
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia',
    'Rural GMI Initiative',
    'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia is a guaranteed basic income initiative in Mercer County, WV, organized by Rural GMI Initiative. Implemented during 10/14/2025 -. Enrolled About 530 participants. Data documented by the Stanford Basic Income Lab.',
    1500,
    'USD',
    '$1,500 (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Mercer County'],
    NULL,
    NULL,
    NULL,
    40000,
    'About 530',
    'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    335,
    'Basic Income for Care Leavers',
    'Welsh Government',
    'Basic Income for Care Leavers is a guaranteed basic income initiative in Wales, UK, organized by Welsh Government. Implemented during 07/01/22 - 6/30/2025. Enrolled Expected 500 young people are eligible participants. Data documented by the Stanford Basic Income Lab.',
    1600,
    'USD',
    '1600 GPB (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United Kingdom'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    'Expected 500 young people are eligible',
    'Individuals leaving government care turning 18 between a timeframe of 12 months (1 July 2022 and 30 June 2023)',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income for Care Leavers' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income for Care Leavers'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    336,
    'Eight Fort Portal Project',
    'Ghent University',
    'Eight Fort Portal Project is a guaranteed basic income initiative in Busibi, Uganda, organized by Ghent University. Implemented during 2017 - 2019. Enrolled 123 adults and  217 children participants. Data documented by the Stanford Basic Income Lab.',
    18,
    'USD',
    '18.25 USD for adults and 9.13 USD for children (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Uganda'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '123 adults and  217 children',
    'Participants randomly selected',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Eight Fort Portal Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Eight Fort Portal Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    337,
    'Novissi',
    'Government of Togo',
    'Novissi is a guaranteed basic income initiative in Togo, organized by Government of Togo. Implemented during August 2020 -. Enrolled 819,972 participants. Data documented by the Stanford Basic Income Lab.',
    65,
    'USD',
    '64.70 USD for women and 19.41 USD for men (bi-monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Togo'],
    NULL,
    NULL,
    NULL,
    NULL,
    '819,972',
    'Individuals who hold a voter ID card and are informal workers whose livelihoods were impacted by COVID-19.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Novissi' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Novissi'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    338,
    'B-MINCOME',
    'City of Barcelona',
    'B-MINCOME is a guaranteed basic income initiative in Barcelona, Spain, organized by City of Barcelona. Implemented during October 2017 - December 2019. Enrolled 1000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '100 - 1675 EU (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Spain'],
    ARRAY[]::TEXT[],
    ARRAY['Nou Barris, Sant Andreu and Sant Martí'],
    NULL,
    NULL,
    NULL,
    NULL,
    '1000',
    'Individuals randomly selected from three of the cities poorest districts',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'B-MINCOME' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'B-MINCOME'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    339,
    'Basic Income for Farmers',
    'Gyeonggi Provincial Government',
    'Basic Income for Farmers is a guaranteed basic income initiative in Gyeonggi Province, Republic of Korea (South Korea), organized by Gyeonggi Provincial Government. Implemented during October 2021 -. Enrolled 430,000 participants. Data documented by the Stanford Basic Income Lab.',
    62,
    'KRW',
    '250,000 Won (~212 USD) (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['South Korea'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '430,000',
    'Farmers who have had an address in the targeted cities for 3 consecutive years or 10 non-consecutive years, and has farmland or has been engaged in agricultural production',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income for Farmers' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income for Farmers'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    340,
    'Youth Basic Income Program',
    'Gyeonggi Provincial Government',
    'Youth Basic Income Program is a guaranteed basic income initiative in Gyeonggi Province, Republic of Korea (South Korea), organized by Gyeonggi Provincial Government. Implemented during 2018 -. Enrolled 125,000 participants. Data documented by the Stanford Basic Income Lab.',
    62,
    'KRW',
    '250,000 Won (~212 USD) (quarterly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['South Korea'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '125,000',
    'Individuals receive the transfer at 24 years of age',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Youth Basic Income Program' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Youth Basic Income Program'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    341,
    'Seoul Stepping Stone Income Project (SSIP)',
    'Seoul Metropolitan Government',
    'Seoul Stepping Stone Income Project (SSIP) is a guaranteed basic income initiative in Seoul, Republic of Korea (South Korea), organized by Seoul Metropolitan Government. Implemented during - Phase 1: July 2022 – June 2025 / 3 years

- Phase 2: July 2023 – June 2025 / 2 years. Enrolled Phase 1: 500 households (control group: 1,000 households) ; 

Phase 2: 1,100 households (control group: 2,200 households) participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    10,
    'KRW',
    'Phase 1: randomly select 500 households with income at or below 50% of the standard median income receive half of the difference between the threshold and the household’s income as a monthly payment;

Phase 2: randomly select 1,100 households with income at or below 85% of the standard median income receive half of the difference between the threshold and the household’s income as a monthly payment  

Monthly payment = (85% of standard median income – current household income) x 0.5 – allowance for livelihood and housing cash benefits / 85% of the standard median income household size (2023) : 1-person household (1,766,208 KRW / 1,374 USD) / 4-person household : 4,590,819 KRW / 3,573 USD) (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['South Korea'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    'Phase 1: 500 households (control group: 1,000 households) ; 

Phase 2: 1,100 households (control group: 2,200 households)',
    '- Phase 1: households earning at or below 50% of the standard median income and with KRW 326 million ($272,803 USD) or less in assets;

Phase 2: households earning at or below 85% of the standard median income and holding - KRW 326 million ($272,803 USD) or less in assets',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Seoul Stepping Stone Income Project (SSIP)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Seoul Stepping Stone Income Project (SSIP)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    342,
    'Social Income Sierra Leone',
    'Social Income',
    'Social Income Sierra Leone is a guaranteed basic income initiative in Sierra Leone, organized by Social Income. Enrolled 146 participants. Data documented by the Stanford Basic Income Lab.',
    30,
    'USD',
    '30 USD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Sierra Leone'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '146',
    'N/A',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Social Income Sierra Leone' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Social Income Sierra Leone'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    343,
    'Weten wat werkt',
    'City of Utrecht',
    'Weten wat werkt is a guaranteed basic income initiative in Utrecht, Netherlands, organized by City of Utrecht. Implemented during 06/01/18 - 10/01/19. Enrolled 752 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    218,
    'EUR',
    'Up to 202 EUR (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Netherlands'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '752',
    'All participants had to be eligible for social assistance in the city of Utrecht',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Weten wat werkt' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Weten wat werkt'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    344,
    'Basic Income Grant (BIG) Pilot',
    'Namibian Big Coalition (Council of Churches',
    'Basic Income Grant (BIG) Pilot is a guaranteed basic income initiative in Otjivero-Omitara, Namibia, organized by Namibian Big Coalition (Council of Churches. Implemented during January 2008 - January 2009. Enrolled 930 participants. Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '100 NAD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Namibia'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    60,
    NULL,
    NULL,
    '930',
    'All individuals in village under 60',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income Grant (BIG) Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income Grant (BIG) Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    345,
    'Human Development Fund',
    'Government of Mongolia',
    'Human Development Fund is a guaranteed basic income initiative in Mongolia, organized by Government of Mongolia. Implemented during 2010 - 2012. Enrolled ~2.7 million participants. Data documented by the Stanford Basic Income Lab.',
    10,
    'USD',
    '86 USD (February 2010). Between August to December 2010 7.42 USD/month, and of 16.57 USD/month between January 2011 to June 2012. (mix of monthly and lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Mongolia'],
    NULL,
    NULL,
    NULL,
    NULL,
    '~2.7 million',
    'No criteria',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Human Development Fund' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Human Development Fund'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    346,
    'Liberia Basic Income',
    'GiveDirectly',
    'Liberia Basic Income is a guaranteed basic income initiative in Maryland County, Liberia, organized by GiveDirectly. Implemented during July 2022 - February 2026. Enrolled 10,987 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    34,
    'USD',
    '408 USD (annualy)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Liberia'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '10,987',
    'All individuals in target villages receive payment',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Liberia Basic Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Liberia Basic Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    347,
    'Basic Income Kenya Study',
    'Give Directly',
    'Basic Income Kenya Study is a guaranteed basic income initiative in Western and Rift Valley, Kenya, organized by Give Directly. Implemented during 01/2017 - 12/2030. Enrolled 20,847 participants. Data documented by the Stanford Basic Income Lab.',
    10,
    'USD',
    '1. $0.75 US per day (44 villages for 12 years)
2. $0.75 US per day (80 villages for 2 years)
3. 8548 US total lump sum at start equal in net present value as group 2 (71 villages) (monthly or lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['Kenya'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '20,847',
    'All individuals in targeted villages',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income Kenya Study' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income Kenya Study'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    348,
    'Give Directly',
    'Give Directly',
    'Give Directly is a guaranteed basic income initiative in Rarieda District, Kenya, organized by Give Directly. Implemented during 2011 - 2013. Enrolled 503 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    10,
    'ZAR',
    '258 households received monthly transfers (45 USD/month for 9 months); 245 received lump-sum transfer (initial 19 USD followed by 384 USD). In addition, 137 randomly chosen households (either previously receiving monthly or lump sum payment) received 260 USD/month for 7 months. (monthly or lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Kenya'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '503',
    'Households in target villages that had a thatched roof (means-tested)',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Give Directly' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Give Directly'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    349,
    'Maezawa Method Basic Income Social Experiment',
    'Yusaku Maezawa',
    'Maezawa Method Basic Income Social Experiment is a guaranteed basic income initiative in Japan, organized by Yusaku Maezawa. Enrolled 500  Lump sum recepients, 500 monthly payment recepients participants. Data documented by the Stanford Basic Income Lab.',
    750,
    'USD',
    '~750 USD (1,000,000 Yen for the entire year) (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Japan'],
    NULL,
    NULL,
    NULL,
    NULL,
    '500  Lump sum recepients, 500 monthly payment recepients',
    'Individuals were selected amongst the Twitter Followers of Japanese billionaire Yusaku Maezawa',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Maezawa Method Basic Income Social Experiment' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Maezawa Method Basic Income Social Experiment'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    350,
    'Reddito di Cittadinanza',
    'City of Livorno',
    'Reddito di Cittadinanza is a guaranteed basic income initiative in Livorno, Italy, organized by City of Livorno. Implemented during 06/01/16 - 12/31/2016. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    540,
    'EUR',
    '500 EUR (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Italy'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    50000,
    '100',
    'Income was distributed amongst 100 of the poorest families of Livorno',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Reddito di Cittadinanza' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Reddito di Cittadinanza'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    351,
    'Basic Income for the Arts',
    'Irish Government',
    'Basic Income for the Arts is a guaranteed basic income initiative in Ireland, organized by Irish Government. Implemented during 10/01/22 - 10/01/25. Enrolled 2000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1520,
    'EUR',
    '€325 (weekly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Ireland'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '2000',
    '2000 individuals were selected from a pool of 8200 applicants to the program',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income for the Arts' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income for the Arts'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    352,
    'Targeted Subsidies Reform Act',
    'Islamic Republic of Iran',
    'Targeted Subsidies Reform Act is a guaranteed basic income initiative in Iran, organized by Islamic Republic of Iran. Implemented during 2010 -. Enrolled ~ 75 million participants. Data documented by the Stanford Basic Income Lab.',
    10,
    'USD',
    '4 USD (transfers amount to 29% median household income) (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['Iran'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '~ 75 million',
    'Individual/household means-testing',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Targeted Subsidies Reform Act' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Targeted Subsidies Reform Act'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    353,
    'Jamesta Istimewa',
    'Yanu Endar Prasetyo (IndoBIG Network & Research Center for Population BRIN)',
    'Jamesta Istimewa is a guaranteed basic income initiative in Yogyakarta, Indonesia, organized by Yanu Endar Prasetyo (IndoBIG Network & Research Center for Population BRIN). Implemented during 11/01/21 - 04/01/22. Enrolled 25 participants. Data documented by the Stanford Basic Income Lab.',
    500000,
    'USD',
    '500000 IDR (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Yogyakarta'],
    NULL,
    NULL,
    NULL,
    NULL,
    '25',
    'N/A',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Jamesta Istimewa' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Jamesta Istimewa'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    354,
    'Madhya Pradesh Unconditional Cash Transfers Project',
    'UNICEF and the Self Employed Women’s Association (SEWA)',
    'Madhya Pradesh Unconditional Cash Transfers Project is a guaranteed basic income initiative in Madhya Pradesh, India, organized by UNICEF and the Self Employed Women’s Association (SEWA). Implemented during June 2011 - November 2012. Enrolled 5,547 in general village pilot of 20 villages and 756 in tribal village pilot participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    100,
    'USD',
    '100 RS for children and 200 RS for adults (Y1), and 150 RS for children and 300 RS for adults (Y2). (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '5,547 in general village pilot of 20 villages and 756 in tribal village pilot',
    'All residents in pilot villages eligible',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Madhya Pradesh Unconditional Cash Transfers Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Madhya Pradesh Unconditional Cash Transfers Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    355,
    'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra',
    'Project DEEP',
    'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra is a guaranteed basic income initiative in Domti, Navadkya and Burkhet in Shelkui Village, Dhadgaon District of Nandurbar, Maharashtra State, India, organized by Project DEEP. Implemented during 5/1/2024 - 5/1/2025. Enrolled 102 participants. Data documented by the Stanford Basic Income Lab.',
    65,
    'INR',
    'INR 65,000 or USD 775 (lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    NULL,
    '102',
    'The program was implemented in 3 hamlets in Shelkui Village (Domti, Navadkya and Burkhet) which are inhabited by the Pawara, an Adivasi community, designated as a Scheduled Tribe. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups.  These hamlets were chosen based on a few parameters of stressors and opportunities. In Shelkui, while most of the population engages in farming, they grow consumption crops. The main source of income is through migration for men, and in some cases women as well. Migration is largely for unskilled farm labour, and in some cases for other labour like construction. Only 2% of the population have their own enterprise, and 5% have a stable permanent income. Funds were disbursed through the bank accounts of women, targeting 102 households that included 508 people.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    356,
    'Building Up Lives | Lumpsum Transfers',
    'Project DEEP',
    'Building Up Lives | Lumpsum Transfers is a guaranteed basic income initiative in Krishnapur Village, in Wardha District, Arvi Taluka, Maharashtra State, India, organized by Project DEEP. Implemented during 5/1/2023 - 4/30/2024. Enrolled 50 participants. Data documented by the Stanford Basic Income Lab.',
    65,
    'INR',
    'INR 65,000 or USD 775 (lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    50000,
    '50',
    'This is a universal program, with all households in the selected hamlet receiving the lump sum amount. Krishnapur is a village inhabited by the Kolams, an Adivasi community, designated as a Scheduled Tribe and categorized as particularly vulnerable. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups. This village was chosen based on a few parameters of stressors and opportunities. There is an acute paucity of money in households, given their dependence on uncertain income cycles. The people of Krishnapur are skilled in their own trades of agriculture, farm labour and livestock rearing, and are ambitious about the next generation''s prospects. Most people work multiple jobs, farming on their own land and on another’s to earn a daily wage. Some people pursue courses in nearby villages, tend to the livestock in the community and look for opportunities to set up enterprises. Despite this, their earning capacity is constrained due to the inability to invest in their latent potential and available opportunities. There is additional uncertainty due to the weather linked income cycles. At the time of the baseline, the average net income was INR 76,952 (~USD 900) for a family of 4. This is barely enough to cover the costs and spend on their routine needs. Over time, this has resulted in unhealthy and compounded debt cycles, which people are now trapped in. This inhibits their ability to conduct regular activities at full potential, making risk taking and income diversification endeavours non-existent. These factors cause an acute paucity of funds at a family and local economy level. Annual assessment report available at https://drive.google.com/file/d/1_Ds-cCD_q8bymCxjPdRX_6hPIIzVQtiU/view.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Building Up Lives | Lumpsum Transfers' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Building Up Lives | Lumpsum Transfers'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    357,
    'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan',
    'Project DEEP',
    'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan is a guaranteed basic income initiative in Amali Phala, Mana Mangari and Kadiya Mangari, Sada Village, Dungarpur District, Rajasthan State, India, organized by Project DEEP. Implemented during 12/1/2023 - 12/1/2024. Enrolled 112 participants. Data documented by the Stanford Basic Income Lab.',
    65,
    'INR',
    'INR 65,000 or USD 775 (lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    50000,
    '112',
    'Sada is a village inhabited by the Meena community, designated as a Scheduled Tribe and categorized as particularly vulnerable. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups. This village was chosen based on a few parameters of stressors and opportunities. Everyone grows consumption crops, like wheat, maize and rice. 73% of the families are dependent on circular migration for their income with one or more members working in nearby cities for a few months. The common occupations are helpers or cooks at a tea or snacks stall, working in a kirana or clothes store, domestic help or daily wage at construction sites and other odd jobs. The net average annual income for a family of fifive is INR 75,336 (~USD 900). This is barely enough to cover the costs and spend on their routine needs. The program was implemented in 3 hamlets in Sada Village (Amali Phala, Mana Mangari & Kadiya Mangari). Funds were disbursed through the bank accounts of women, targeting 112 households that included 505 people. Assessment report is available at https://drive.google.com/file/d/1pV9aLEaZ2eJaEtsNr3vGlO2dbb3vfpZ3/view.',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    358,
    'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme)',
    'Tamil Nadu State Government',
    'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme) is a guaranteed basic income initiative in Tamil Nadu, India, organized by Tamil Nadu State Government. Enrolled Expected up to 10,000,000 women participants. Data documented by the Stanford Basic Income Lab.',
    12,
    'INR',
    '1000 INR (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    'female'::public.program_gender_requirement,
    50000,
    'Expected up to 10,000,000 women',
    'Not disclosed yet, but government has suggested financial targetting towards the poorest women in Tamil Nadu',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    359,
    'Basic Income & Care for Transgender Persons',
    'Anveshi',
    'Basic Income & Care for Transgender Persons is a guaranteed basic income initiative in Hyderabad, India, organized by Anveshi. Enrolled N/A participants. Data documented by the Stanford Basic Income Lab.',
    500,
    'USD',
    'Monthly basic income support',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    'N/A',
    'N/A',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income & Care for Transgender Persons' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Income & Care for Transgender Persons'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    360,
    'UBI+',
    'WorkFree',
    'UBI+ is a guaranteed basic income initiative in Hyderabad, India, organized by WorkFree. Enrolled 1250 participants. Data documented by the Stanford Basic Income Lab.',
    12,
    'INR',
    '1000 INR for adults, 500 INR for children (paid to a parent) (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['India'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '1250',
    'Not a condition, but ''almost all [participants] make their living from waste picking or domestic service''',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'UBI+' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'UBI+'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    361,
    'My Basic Income',
    'Mein Grundeinkommen e.V.',
    'My Basic Income is a guaranteed basic income initiative in Germany, organized by Mein Grundeinkommen e.V.. Enrolled 1464 participants. Data documented by the Stanford Basic Income Lab.',
    1296,
    'EUR',
    '1200 euros (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['Germany'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '1464',
    'N/A',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'My Basic Income' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'My Basic Income'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    362,
    'Pilotprojekt Grundeinkommen',
    'German Institute for Economic Research (DIW Berlin)',
    'Pilotprojekt Grundeinkommen is a guaranteed basic income initiative in Germany, organized by German Institute for Economic Research (DIW Berlin). Implemented during June 2021 - May 2024. Enrolled 122 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1200,
    'USD',
    '1200 EU (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Germany'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '122',
    'Participants randomly selected',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Pilotprojekt Grundeinkommen' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Pilotprojekt Grundeinkommen'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    363,
    'Finland Basic Income Experiment',
    'Kela and Ministry of Health and Social Affairs',
    'Finland Basic Income Experiment is a guaranteed basic income initiative in Finland, organized by Kela and Ministry of Health and Social Affairs. Implemented during January 2017 - December 2018. Enrolled 2000 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    560,
    'USD',
    '560 EU (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Finland'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '2000',
    'Random selection from all individuals between ages of 25 and 58 for whom Kela paid a labour market subsidy or basic unemployment allowance in November 2016 for some other reason than a temporary layoff',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Finland Basic Income Experiment' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Finland Basic Income Experiment'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    364,
    'Wealth Partaking Scheme',
    'Government of Macau',
    'Wealth Partaking Scheme is a guaranteed basic income initiative in Macau Special Administrative Region, China, organized by Government of Macau. Implemented during 2008 -. Enrolled 638,300 permanent residents and 62,000 non-permanent residents participants. Data documented by the Stanford Basic Income Lab.',
    96,
    'USD',
    '1,150 USD (permanent residents); 750 USD non-permanent residents (yearly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['United States'],
    ARRAY[]::TEXT[],
    ARRAY['Macau Special Administrative Region'],
    NULL,
    NULL,
    NULL,
    NULL,
    '638,300 permanent residents and 62,000 non-permanent residents',
    'No criteria',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Wealth Partaking Scheme' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Wealth Partaking Scheme'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    365,
    'Scheme $6,000',
    'Government of Hong Kong',
    'Scheme $6,000 is a guaranteed basic income initiative in Hong Kong, China, organized by Government of Hong Kong. Implemented during 2011. Enrolled ~4 million participants. Data documented by the Stanford Basic Income Lab.',
    65,
    'HKD',
    '6000 HK (lump sum)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Hong Kong'],
    ARRAY[]::TEXT[],
    ARRAY[],
    18,
    NULL,
    NULL,
    NULL,
    '~4 million',
    'Individuals 18 years and older with Hong Kong permanent identity cards',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Scheme $6,000' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Scheme $6,000'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    366,
    'New Leaf Project',
    'Foundations for Social Change',
    'New Leaf Project is a guaranteed basic income initiative in Vancouver, BC, Canada, organized by Foundations for Social Change. Implemented during 2018 - 2019. Enrolled 50 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    7500,
    'USD',
    '7500 USD (one time)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '50',
    'Individuals 19 and older who had recently been homeless',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'New Leaf Project' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Leaf Project'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    367,
    'Agreements with Young Adults',
    'Government of BC',
    'Agreements with Young Adults is a guaranteed basic income initiative in British Columbia, Canada, organized by Government of BC. Implemented during March 2022 -. Enrolled Any individual transitioning out of care participants. Data documented by the Stanford Basic Income Lab.',
    925,
    'CAD',
    '1250 CAD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    'Any individual transitioning out of care',
    'Individuals 19-26 in care on their 19th birthday',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Agreements with Young Adults' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Agreements with Young Adults'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    368,
    'Manitoba Basic Annual Income Experiment (MINCOME)',
    'Province of Manitoba',
    'Manitoba Basic Annual Income Experiment (MINCOME) is a guaranteed basic income initiative in Dauphin, MB, Canada, organized by Province of Manitoba. Implemented during 1976 - 1978. Enrolled 2263 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    234,
    'CAD',
    '316 - 483 CAD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    57,
    NULL,
    NULL,
    '2263',
    'Households with head of household under 57 years of age with an average yearly income less than $13,000 in Winnipeg and 9,000 in Dauphin. Households with a disabled adult, one more more heads in armed forces, mentally incompetent and who were unable to complete surveys due to language barriers ineligible to participate',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    369,
    'Manitoba Basic Annual Income Experiment (MINCOME) — Winnipeg, MB, Canada',
    'Province of Manitoba',
    'Manitoba Basic Annual Income Experiment (MINCOME) is a guaranteed basic income initiative in Winnipeg, MB, Canada, organized by Province of Manitoba. Implemented during 1975 - 1978. Enrolled 2263 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    234,
    'CAD',
    '316 - 483 CAD (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    57,
    NULL,
    NULL,
    '2263',
    'Households with head of household under 57 years of age with an average yearly income less than $13,000 in Winnipeg and 9,000 in Dauphin. Households with a disabled adult, one more more heads in armed forces, mentally incompetent and who were unable to complete surveys due to language barriers ineligible to participate',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME) — Winnipeg, MB, Canada' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME) — Winnipeg, MB, Canada'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    370,
    'Ontario Basic Income Pilot',
    'Government of Ontario Ministry of Children',
    'Ontario Basic Income Pilot is a guaranteed basic income initiative in Hamilton, Brantford, Brant County, ON, Canada, organized by Government of Ontario Ministry of Children. Implemented during 2017 - 2018. Enrolled 2748 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1048,
    'CAD',
    '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD (annual)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '2748',
    'Individuals between 18-64',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ontario Basic Income Pilot' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ontario Basic Income Pilot'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    371,
    'Ontario Basic Income Pilot — Lindsay, ON, Canada',
    'Government of Ontario Ministry of Children',
    'Ontario Basic Income Pilot is a guaranteed basic income initiative in Lindsay, ON, Canada, organized by Government of Ontario Ministry of Children. Implemented during 2019 - 2018. Enrolled 1844 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1048,
    'CAD',
    '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD (annual)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '1844',
    'Individuals between 18-65',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ontario Basic Income Pilot — Lindsay, ON, Canada' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ontario Basic Income Pilot — Lindsay, ON, Canada'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    372,
    'Ontario Basic Income Pilot — Thunder Bay, ON, Canada',
    'Government of Ontario Ministry of Children',
    'Ontario Basic Income Pilot is a guaranteed basic income initiative in Thunder Bay, ON, Canada, organized by Government of Ontario Ministry of Children. Implemented during 2018 - 2018. Enrolled 1908 participants. Evaluated as a randomized controlled trial (RCT). Data documented by the Stanford Basic Income Lab.',
    1048,
    'CAD',
    '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD (annual)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Canada'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '1908',
    'Individuals between 18-65',
    TRUE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Ontario Basic Income Pilot — Thunder Bay, ON, Canada' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Ontario Basic Income Pilot — Thunder Bay, ON, Canada'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    373,
    'Renda Basica de Cidadania (Citizens'' Basic Income Program)',
    'Municipal Government of Maricá',
    'Renda Basica de Cidadania (Citizens'' Basic Income Program) is a guaranteed basic income initiative in Maricá, Brazil, organized by Municipal Government of Maricá. Implemented during December 2019 -. Enrolled 42,000 participants. Data documented by the Stanford Basic Income Lab.',
    130,
    'USD',
    '130 Mumbuca, a currency spendable only within the Municipality of Marica (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'municipal_government',
    'external_self_apply',
    'active_open'::public.program_status,
    'Ongoing',
    'Ongoing monthly distributions',
    ARRAY['Brazil'],
    ARRAY[]::TEXT[],
    ARRAY[],
    NULL,
    NULL,
    NULL,
    NULL,
    '42,000',
    'Individuals who are part of Brazil''s Cadastro Único, a unified registry for social benefits',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Renda Basica de Cidadania (Citizens'' Basic Income Program)' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Renda Basica de Cidadania (Citizens'' Basic Income Program)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, stanford_experiment_id, website, verified
)
SELECT
    374,
    'Quatinga Velho',
    'Instituto ReCivitas',
    'Quatinga Velho is a guaranteed basic income initiative in Mogi das Cruzes, Brazil, organized by Instituto ReCivitas. Implemented during 2008 - 2014. Enrolled 100 participants. Data documented by the Stanford Basic Income Lab.',
    10,
    'BRL',
    '30 Reais (monthly)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'philanthropic_grant',
    'external_self_apply',
    'closed'::public.program_status,
    'Pilot completed',
    'Pilot completed (Research evaluation phase)',
    ARRAY['Brazil'],
    ARRAY[]::TEXT[],
    ARRAY['Quatinga Velho'],
    NULL,
    NULL,
    NULL,
    NULL,
    '100',
    'Individual/household means-testing',
    FALSE,
    'stanford_basic_income_lab',
    (SELECT id FROM public.stanford_experiments WHERE name = 'Quatinga Velho' LIMIT 1),
    NULL,
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Quatinga Velho'
);
