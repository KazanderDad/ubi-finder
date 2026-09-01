-- Migration 00017: Create Stanford Experiments Table, Cross-Reference and Source Filter Support


-- 1. Create Stanford Experiments Table
CREATE TABLE IF NOT EXISTS public.stanford_experiments (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT,
    neighborhood TEXT,
    managing_orgs TEXT,
    other_affiliations TEXT,
    implementation_dates TEXT,
    implementation_status TEXT,
    total_participants TEXT,
    type_of_funding TEXT,
    participants_receiving TEXT,
    type_of_targeting TEXT,
    targeting_details TEXT,
    transfer_amount TEXT,
    frequency_of_payment TEXT,
    duration_of_payment TEXT,
    other_intervention_components TEXT,
    is_rct BOOLEAN DEFAULT false,
    latitude NUMERIC,
    longitude NUMERIC,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS and public read access
ALTER TABLE public.stanford_experiments ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow public read access to stanford_experiments" ON public.stanford_experiments;
CREATE POLICY "Allow public read access to stanford_experiments"
    ON public.stanford_experiments
    FOR SELECT
    USING (true);

-- 2. Add Source Tracking and RCT columns to programs
ALTER TABLE public.programs 
    ADD COLUMN IF NOT EXISTS data_source TEXT DEFAULT 'community_submission',
    ADD COLUMN IF NOT EXISTS stanford_experiment_id INTEGER REFERENCES public.stanford_experiments(id) ON DELETE SET NULL,
    ADD COLUMN IF NOT EXISTS is_rct BOOLEAN DEFAULT false,
    ADD COLUMN IF NOT EXISTS total_participants TEXT,
    ADD COLUMN IF NOT EXISTS targeting_details TEXT;

-- 3. Seed Stanford Experiments
INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    1, 'Alaska Permanent Dividend Fund', NULL, NULL, 'Alaska Dept of Revenue', NULL,
    'January 1982 -', 'active', '667,047', 'Public',
    'Individuals', 'None', NULL, '1114 USD (2021)',
    'Yearly', 'Annual', NULL, false,
    64.2008, -149.4937
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    2, 'Embrace Mothers', 'Birmingham, AL', NULL, 'City of Birmingham', 'MGI, The Penny Foundation',
    'March 2022 - February 2023', 'concluded', '110', 'Public',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', '18 years or older, female identifying as single head of a family with children in the household under 18 years of age', '$375',
    'Monthly', '12 Months', NULL, false,
    33.5186, -86.8104
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    3, 'Financial Assistance for Phoenix Families Program', 'Phoenix, AZ', NULL, 'Phoenix City Council', 'American Rescue Plan Act (ARPA), Partnership for Economic Innovation',
    'January 2022 - January 2023', 'concluded', '1,000', 'Public',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income families with children making 80 percent of the Area Median Income or less', '$1,000',
    'Monthly', '12 Months', NULL, false,
    33.4484, -112.074
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    4, 'Returning Home Career Grant', 'Alameda and Contra Costa Counties, CA', NULL, 'Rubicon Programs', 'Alameda County Probation Dept., Alameda County Workforce Development Board, Growth Sector, Third Sector',
    'May 2021 - May 2022', 'concluded', '25', 'Private',
    'Individuals', NULL, 'Primarily black and brown individuals returning home after incarceration', '500 USD',
    'Monthly', 'At least 12 months', NULL, false,
    37.7652, -122.2416
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    5, 'Community-Based Roads to Prosperity', 'Alameda County, CA', NULL, 'United Way Bay Area', 'SparkPoint Oakland, SparkPoint Fremont, SparkPoint at Chabot College',
    '8/1/2024 - 1/1/2025', 'concluded', '100', 'Private',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'Individuals over the age of 18 who received services from SparkPoint Oakland, SparkPoint Fremont, and/or SparkPoint at Chabot College prior to July 31, 2024, regardless of citizenship or immigration status', '$1,000',
    'Monthly', '18 months', NULL, false,
    37.6017, -121.7195
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    6, 'NET Growth Movement', 'Alameda County, CA', NULL, 'Bay Area Community Services', 'Alameda County Social Services Agency, Hellman Foundation, Walter & Elise Haas Foundation, Wells Fargo Foundation, Citibank',
    '1/1/2023 - 12/31/2025', 'concluded', '67', 'Public/Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Former non-minor dependents who exited the foster youth system in 2022 or who would''ve exited in 2022', '$1,000',
    'Monthly', '24 months', NULL, false,
    37.6017, -121.7195
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    7, 'Coco Go BIG', 'Antioch, CA', '94509, 94531', 'Comment Studio', 'RCF Connects',
    '1/15/2024 - 6/15/2024', 'concluded', '30', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation), Foster youth.', 'The Sycamore corridor in Antioch.', '400 USD for adults, 200 USD for foster youth',
    'Monthly', '6 months', 'Benefits counseling, diversion services for foster youth, life coaching.', false,
    38.0049, -121.8058
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    8, 'Rise Up Alameda', 'Alameda, CA', '94501 and 94502 zip codes', 'City of Alameda', 'Operation Dignity, Abt Associates, and Usio',
    '12/15/2023 - 12/15/2025', 'concluded', '150', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Must be living in the City of Alameda; must be 18 years of age or older; and have a yearly household income at or below 50% of average median income of Alameda County', '1000 USD',
    'Monthly', '24 months', NULL, true,
    37.7652, -122.2416
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    9, 'ELEVATE Concord: Family Economic Equity Pilot', 'Concord, CA', NULL, 'Monument Impact', 'The City of Concord',
    '11/6/2023 - 10/31/2024', 'concluded', '120', 'Public/Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Single parent, has at least one child under 12 years old, makes less than 55k', '500 USD + one time stabilization gift of 2,500 USD at start of pilot',
    'Monthly', '11 months', 'Wraparound services - techonology classes, emerging business program, mental health programs', false,
    37.978, -122.0311
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    10, 'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program', 'Coachella, CA', NULL, 'Mission Asset Fund (MAF)', NULL,
    'October 2022 - 2024', 'concluded', '140', 'Public/Private',
    'Households', 'Geographic and individual/household means-testing and demographic', '18 years of age or older, who have a current, non-expired, government-issued photo ID, at least one child under the age of 12 who was living in the household in 2021, earned less than $75,000 in 2021 or have a total household income below $150,000 in 2021, and have filed a 2019 or 2020 tax return or gave the IRS information as a non-filer in 2020 or 2021', '400 USD',
    'Monthly', '24 months', 'One on one financial coaching, financial education workshops', false,
    33.6803, -116.1739
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    11, 'Compton Pledge', 'Compton, CA', NULL, 'City of Compton, The Fund for Guaranteed Income', 'GICP, MGI, Jain Family Inst., One Fair Wage, Essie Justice Group, Black Lives Matter, Brotherhood Crusade, A New Way of Life, Fund for Guaranteed Income',
    'December 2020 - November 2022', 'concluded', '800', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals who are low-income, including people who are undocumented and who are formerly incarcerated', '300, 400 and 600 USD',
    'Bi-weekly or quarterly', '24 months', 'Access to other city programs and services', true,
    33.8958, -118.2201
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    12, 'Family Income for Empowerment Program', 'County of San Diego, CA', NULL, 'Jewish Family Service of San Diego', 'County of San Diego Department of Child and Family Well-Being (CFWB) ; County of San Diego Office of Evaluation, Performance, and Analytics (OEPA) ; Casey Family Programs (CFP)',
    '7/1/2023 - 12/31/2026', 'active', '485', 'Public/Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation).', '1. Referred by  County of San Diego Department of Child and Family Well-Being (Inconclusive or substantiated allegations of general neglect, physical abuse, or emotional abuse with no new opened child welfare case);

2. Resident of San Diego County (priority for unhoused families and those residing in the 39 Health Equity ZIP codes);

3. At least one child in the household under 18 ;

4. Annual household income at or below 200% of the Federal Poverty Level (FPL);

5. Able to provide identity and income documentation for eligibility verification.', '500 USD',
    'Monthly', '24 months', 'All applicants are offered access to a comprehensive list of community support resources and an online benefits screening tool to help make an informed decision about applying to the program.  All participants have the option to receive additional support understanding their County administered benefits, have their payment card mailed to them or pick it up in-person, attend an informational session, and learn more about future opportunities to participate in narrative change activities. All of the above are entirely optional and voluntary and have no impact on an individual’s application or participation in the program.', true,
    32.7157, -117.1611
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    13, 'City of El Monte Guaranteed Income Program', 'El Monte, CA', NULL, 'City of El Monte', 'RAND Corporation',
    NULL, 'concluded', '125', 'Public',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Program is applicable to female heads of households living within El motne City Limits and making below the poverty line and were financially impacted by the COVID-19 pandemic.', '500 USD',
    'Monthly', '12 months', NULL, false,
    34.0686, -118.0276
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    14, 'Advancing Fresno County Guaranteed Income', 'Fresno, CA', 'Zipcodes 93706 and 93234', 'Fresno EOC', 'Center for Community Voices at Fresno State',
    '7/1/2024 - July 2025', 'concluded', '150', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Residents in the 93706 (Southwest Fresno) or 93234 (Huron) zipcodes, who are adults over 18, and pregnant or have a child under five, are eligible if they have an income that is 80 percent or less of the Area Median Income. For Huron residents that would be $35,103 or less, and $30,615 or less for those residing in Southwest Fresno.', '$500',
    'Monthly', '12 Months', NULL, false,
    36.7468, -119.7726
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    15, 'HIP (Humboldt Income Program)', 'Humboldt County, CA', NULL, 'McKinleyville Family Resource Center (McKinleyville Community Collaborative)', 'Urban Institute, AidKit, California Department of Social Services (CDSS)',
    '1/25/2024 - 11/25/2025', 'concluded', '150', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Pregnant people in 1 st or 2nd trimester of pregnancy (under  28 weeks pregnant) during the enrollment period (December  2023-May 2024),18 years old or over and living in Humboldt County. At 200% or below of the federal poverty level not including  unborn child.

Referrals to the program will be through local medical providers to relieve administrative burdens on clients and require less documentation.', '920 USD',
    'Monthly', '22 months', 'Clients will be offered optional benefits counseling so that they are aware of how GI might impact their benefits. They will also have access to case management where they can be given information about other resources in the area that they are able to utilize.', true,
    40.745, -123.8695
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    16, 'Breathe: LA County''s Guaranteed Income Program', 'LA County, CA', NULL, 'Strength Based Community Change', 'LA County, Conrad N. Hilton Foundation, First 5 LA, The California Endowment, The California Wellness Foundation, The James Irvine Foundation, The Kresge Foundation, Weingart Foundation',
    'June 2022 - July 2025', 'concluded', '1000', 'Public/Private',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals 18 and older who reside in a neighborhood identified as being at or below LA County’s Area Median Income (AMI), in a single person household that falls at or below AMI or a household with two or more persons that falls at or below 120% AMI, and have been financially negatively affected by the COVID-19 pandemic.', '1000 USD',
    'Monthly', '36 months', NULL, true,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    17, 'LA County Breathe - Former Foster Youth Expansion 1', 'LA County, CA', NULL, 'Strength Based Community Change', 'LA County, Center for Guaranteed Income Research (CGIR) at University of Pennsylvania',
    '2023-8/31/2025', 'concluded', '200', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Former foster youth ages 21 to 24.', '$1,000',
    'Monthly', '24 months', NULL, true,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    18, 'LA County Breathe - Former Foster Youth Expansion 2', 'LA County, CA', NULL, 'Strength Based Community Change', 'LA County, Center for Guaranteed Income Research (CGIR) at University of Pennsylvania',
    '2024-4/30/2026', 'concluded', '2000', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Former foster youth ages 18 to 21. Payments provided as $500 monthly or $1,500 quarterly.', '$500',
    'Monthly', '18 months', NULL, false,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    19, 'TAYportunity Guaranteed Income Program', 'LA County, CA', NULL, 'LA County DPSS', 'Jain Family Institute, the University of Virginia, and New York University',
    '8/1/2022 - 8/1/2025', 'concluded', '300', 'Public',
    'Individuals', 'Individual/household means-testing and demographic', 'Youth between the ages of 18 and 24 who are currently receiving County employment services through the General Relief Opportunities for Work (GROW) Program.', '$1,000',
    'Monthly', '36 months', 'Recipients also offered benefits counseling services, financial literacy, and money management support.', true,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    20, 'Long Beach Guaranteed Income Pilot Program', 'Long Beach, CA', '90802, 90804, 90805,90806, and 90810 zipcodes', 'City of Long Beach', 'Fund for Guaranteed Income (F4GI), California State University, Long Beach Research Foundation',
    '3/1/2024 - 2/1/2025', 'concluded', '200', 'Public',
    'Households', 'Geographic means-testing (e.g. all residents in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Households with dependent children and gross household income (before taxes) of 100% or less of the federal poverty level. This number depends on how many individuals are in your household/family unit. Long Beach residents in the 90802, 90804, 908095,90806, and 90810 zipcode.', '$500',
    'Monthly', '12 months', NULL, false,
    33.7701, -118.1937
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    21, 'Long Beach Pledge (Cohort 1)', 'Long Beach, CA', '90813 Zip code', 'City of Long Beach', 'Office of Economic Research at California State University, Long Beach, Fund for A Guaranteed Income',
    'November 2022 - October 2023', 'concluded', '250', 'Private',
    'Long Beach Recovery Act dollars', 'Neighbourhood-level means testing and individual/household means testing', 'Single headed families (families with dependents and a single income earner), with incomes at or below the federal poverty level in the 90813 zip-code, with a gross household income (before taxes) of 100% or less of the federal poverty level, based on household size.', '500 USD',
    'Monthly', '12 months', NULL, false,
    33.7701, -118.1937
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    22, 'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot)', 'Los Angeles, CA', NULL, 'City of Los Angeles', 'MGI, CGIR',
    'January 2022 - March 2023', 'concluded', '3204', 'Public',
    'Individuals', 'Demographic and means-testing', 'Individuals at or below the Federal Poverty Line based on household size facing economic and/or medical hardship from COVID-19, and with at least one dependent child (younger than 18 or a student younger than 24) or are pregnant', '1000 USD',
    'Monthly', '14 months', NULL, true,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    23, 'Family Goal Fund', 'Los Angeles, CA', NULL, 'LIFT, Inc', 'GICP',
    'January 2018 -', 'active', '800+', 'Private',
    'Households', 'Identification through program/service', 'Households in the LIFT program with low-income and children 0-8 years of age', '150 USD',
    'Quarterly', 'Up to 24 months', NULL, false,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    24, 'BOOST: Building Outstanding Opportunities for Students to Thrive', 'Students of East LA College, LA Southwest College, LA City College, and/or LA Trade-Tech College', NULL, 'Foundation for the Los Angeles Community Colleges', 'Los Angeles Community College District',
    '11/25/2024 - 10/15/2025', 'concluded', '251', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation)', 'BOOST aims to help bridge the gap between financial aid, wages, and the cost of living for students attending the Los Angeles Community College District (LACCD) and pursuing careers in clinical, allied, and behavioral healthcare. This program enrolled a cohort of 251 students to receive a guaranteed payment of $1000 per month over a one-year period. BOOST includes a mixed-methods evaluation with a randomized controlled trial (RCT) conducted by the Center for Guaranteed Income Research (CGIR) at the University of Pennsylvania. Students who met all of the eligibility criteria were invited to apply to participate in BOOST. Eligible students who completed the online application were randomly assigned to one of three groups: treatment, control, or non-participants. The evaluation included 251 individuals in the treatment group receiving the payments and 370 individuals in the control group. All costs associated with the project are funded by private donors.', '$1,000',
    'Monthly', '12 Months', NULL, true,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    25, 'Pregnancy Assistance Income with Dignity (P.A.I.D.)', 'Los Angeles County', NULL, 'National Council of Jewish Women | Los Angeles (NCJW|LA)', 'California Department of Social Services (CDSS), The Urban Institute, AidKit',
    '4/8/2024 - 3/1/2026', 'concluded', '180', 'Public/private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Pregnant People over age 18 who are in their 1st or 2nd trimester of pregnancy and live in Los Angeles County and are not participating in another GI program, with income within HUD 2023 Adjusted Low-Income levels. The RCT evaluation includes 180 individuals in the treatment group and 180 in the control group.', '$1,000',
    'Monthly', '24 Months', 'Optional benefits counseling.', true,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    26, 'NCJWLA Guaranteed Income Project', 'Los Angeles, CA', NULL, 'National Council of Jewish Women-LA', 'GICP, CGIR',
    'July 2021 - July 2022', 'concluded', '12', 'Private',
    'Individual', 'Individual/household means-testing and demographic', 'Individuals who identify as women earning between 50-80% of area-level median income in caregiving/healthcare professions', '1000 USD',
    'Monthly', '12 months', NULL, false,
    34.0522, -118.2437
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    27, 'Miracle Money', 'Los Angeles, San Francisco, and Oakland, CA', NULL, 'Miracle Messages', 'University of Southern California',
    'May 2022 - July 2024', 'concluded', '103', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Unhoused individuals who expressed interest in the Miracle Friends program', '$750',
    'Monthly', '12 months', 'Social support through the Miracle Friends phone buddy program', false,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    28, 'MOMentum', 'Marin County, CA', NULL, 'Marin Community Foundation', 'GICP, UpTogether',
    'June 2021 - May 2023', 'concluded', '125', NULL,
    'Individuals', 'Demographic', 'Women of color with low income and children under 18', '1000 USD',
    'Monthly', '24 months', NULL, false,
    38.0834, -122.7633
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    29, 'Alas', 'Monterey Bay Area, CA', NULL, 'Ventures, UC Santa Cruz', NULL,
    '2022 -', 'active', '60+', 'Private',
    'Families', 'Demographic targeting (individuals who belong to a demographic group)', 'Designed to help working class Latino families build community, self-determination, and financial stability. Structured as a cohort model. Participants also receive monthly workshops and financial coaching.', '$500',
    'Monthly', '6 months', NULL, false,
    36.8007, -121.9473
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    30, 'Elevate MV', 'Mountain View, CA', NULL, 'City of Mountain View', 'MGI, Center for Guaranteed Income Research (CGIR) at the University of Pennsylvania',
    'November 2022 - October 2023', 'concluded', '166', 'Households',
    'American Rescue Plan Act funding', 'Individual/household means-testing and demographic', 'Households with an income below 30% Area Median Income (AMI), and parents/custodial caregiver for at least one child under the age of 18 at the time of application.', '500 USD',
    'Monthly', '12 months', NULL, false,
    37.3861, -122.0839
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    31, 'Miracle Money  - Thriving Community Fund (TCF) expansion', 'Multiple communities in CA', NULL, 'Miracle Messages', NULL,
    '2025 -', 'active', '110', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'The TCF is an expansion of Miracle Message''s Miracle Money program. It is a statewide pilot designed to test the impact of combining direct, unconditional cash assistance for unhoused individuals with established, trust-based relationships delivered through community-based organizations.  TCF was implemented through partnerships with community-based organizations that have deep roots, cultural competence, and longstanding relationships with populations experiencing housing instability. Rather than imposing a single service model, TCF intentionally leaned into each organization’s leadership, allowing partners to adapt the cash intervention to their population and local and organizational context.', '$750',
    'Monthly', '12 months', 'Support services from community-based organizations', false,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    32, 'Abundant Birth Project', 'San Francisco, CA', NULL, 'Expecting Justice', 'GICP',
    '6/1/2021- 1/30/2024', 'concluded', '150', 'Public/Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Black or Pacific Islander pregnant people in their 1st or 2nd trimester and making less than $100,000', '1000 USD',
    'Monthly', '15 months', NULL, false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    33, 'California Abundant Birth Project', 'Alameda County, CA', NULL, 'Expecting Justice', 'Alameda County Department of Public Health, Richmond Rapid Response Fund, Los Angeles Department of Public Health, Riverside Community Health Foundation, San Francisco Department of Public Health, UC Berkeley, UC Davis, Oregon Health & Science University-Portland State University',
    '1/29/2024 - 4/30/2026', 'concluded', '950', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.', '600-1,000 USD depending on county',
    'Monthly', '27 months', 'Abundance Coaching is offered to participants, which is optional case managemant, pregnancy and postpartum support, and linkage to local services.', true,
    37.6017, -121.7195
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    34, 'California Abundant Birth Project', 'Contra Costa County, CA', NULL, 'Expecting Justice', 'Alameda County Department of Public Health, Richmond Rapid Response Fund, Los Angeles Department of Public Health, Riverside Community Health Foundation, San Francisco Department of Public Health, UC Berkeley, UC Davis, Oregon Health & Science University-Portland State University',
    '1/29/2024 - 4/30/2026', 'concluded', '950', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.', '600-1,000 USD depending on county',
    'Monthly', '27 months', 'Abundance Coaching is offered to participants, which is optional case managemant, pregnancy and postpartum support, and linkage to local services.', true,
    37.8534, -121.9018
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    35, 'California Abundant Birth Project', 'Los Angeles County, CA', NULL, 'Expecting Justice', 'Alameda County Department of Public Health, Richmond Rapid Response Fund, Los Angeles Department of Public Health, Riverside Community Health Foundation, San Francisco Department of Public Health, UC Berkeley, UC Davis, Oregon Health & Science University-Portland State University',
    '1/29/2024 - 4/30/2026', 'concluded', '950', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.', '600-1,000 USD depending on county',
    'Monthly', '27 months', 'Abundance Coaching is offered to participants, which is optional case managemant, pregnancy and postpartum support, and linkage to local services.', true,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    36, 'California Abundant Birth Project', 'Riverside County', NULL, 'Expecting Justice', 'Alameda County Department of Public Health, Richmond Rapid Response Fund, Los Angeles Department of Public Health, Riverside Community Health Foundation, San Francisco Department of Public Health, UC Berkeley, UC Davis, Oregon Health & Science University-Portland State University',
    '1/29/2024 - 4/30/2026', 'concluded', '950', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Live in Alameda, Contra Costa, Los Angeles, Riverside, or San Francisco counties Be 8-27 weeks pregnant  Have household income under the following for your county:  Alameda: $128,017 Contra Costa: $132,360 Los Angeles: $106,911 Riverside: $81,581 San Francisco: $156,995 And identify with one or more of the following risk factors for preterm birth:  Are Black or African American Have had a previous preterm birth (live birth before 37 weeks) Have preexisting hypertension (includes preeclampsia, before this pregnancy) Have preexisting diabetes (before this pregnancy) Have sickle cell anemia (SCA) Not be currently participating in another guaranteed income program.', '600-1,000 USD depending on county',
    'Monthly', '27 months', 'Abundance Coaching is offered to participants, which is optional case managemant, pregnancy and postpartum support, and linkage to local services.', true,
    33.7431, -115.9936
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    37, 'Restorative Reentry Fund', 'Oakland, CA', NULL, 'UpTogether', NULL,
    '2/1/2023 - 9/1/2024', 'concluded', '38', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Justice-affected individuals', '$1,000 a month for 12 months, followed by $500 a month for six months',
    'Monthly (variable amounts)', '18 months', NULL, false,
    37.8044, -122.2712
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    38, 'Oakland Resilient Families', 'Oakland, CA', 'East Oakland', 'UpTogether, City of Oakland', 'GICP, MGI, Oakland Thrives',
    'June 2021 - June 2024', 'concluded', '600 (2 cohorts)', 'Private',
    'Households', 'Neighbourhood level means testing and demographic', 'Cohort 1: Individuals in a one square mile area of East Oakland with an income under 50% of area level median and at least one child under 18.
Cohort 2: Households with an income of no more than 138% of the Federal Poverty Line based on household size, and at least one child under 18', '500 USD',
    'Monthly', '18 months', NULL, false,
    37.8044, -122.2712
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    39, 'Miracle Money', 'Oakland, San Francisco, and Los Angeles, CA', NULL, 'Miracle Messages', 'University of Southern California',
    'May 2022 - July 2024', 'concluded', '103', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Unhoused individuals who expressed interest in the Miracle Friends program', '$750',
    'Monthly', '12 months', 'Social support through the Miracle Friends phone buddy program', false,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    40, 'Palm Springs'' Universal Basic Income pilot', 'Palm Springs, CA', NULL, 'DAP Health', 'City of Palm Springs, HARC, Inc.',
    '2022 to May 2025', 'concluded', '14', 'Public',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals who lived, worked, or spent most of their time in the City of Palm Springs and had income of less than $17,000 per year.  Program management was transferred to DAP Health in 2024 after mismanagement by a previous nonprofit partner.', '$800',
    'Monthly', '18 months', NULL, false,
    33.8303, -116.5453
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    41, 'City of Pomona Household Universal Grants Pilot Program (Pomona HUG)', 'Pomona, CA', NULL, 'City of Pomona, UCLA', NULL,
    'Aug 2024 - Dec 2025', 'concluded', '600', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Resident of Pomona, 18 years or older, parent or legal guardian of a child under 4 years old, meet ARPA requirement. Treament group included 250 participants receiving $500 per month, control group included 350 participants receiving $20 per month.', '$500',
    'Monthly', '18 months', '300 participants (150 from treatment group and 150 from control group) randomly selected to receive resource navigation services', false,
    34.0551, -117.7499
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    42, 'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program', 'Riverside County, San Bernardino County, CA', NULL, 'Inland Southern California United Way', 'California Department of Social Services (CDSS); Urban Institute; Social Finance, Inc.; Claremont McKenna College',
    '1/25/2024 - 3/25/2027', 'active', '620', 'Public/private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Pregnant individuals; former foster youth', 'Pregnant People in Riverside County; those aging out of extended foster care at 21 in Riverside or San Bernardino Counties', '$600 Pregnant; $750 FFY',
    'Monthly', '18 Months', NULL, true,
    33.9533, -117.3962
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    43, 'Creative Growth Fellowship', 'Sacramento, CA', NULL, 'City of Sacramento', 'AidKit',
    '9/1/2025 - 8/31/2026', 'active', '200', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Artists living in the City of Sacramento', '$850',
    'Monthly', '12 months', NULL, false,
    38.5816, -121.4944
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    44, 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1', 'Sacramento, CA', NULL, 'United Way California Capital Region', 'California State University, Sacramento',
    '6/1/2021 - 5/31/2023', 'concluded', '100', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', NULL, '$300',
    'Monthly', '24 months', NULL, true,
    38.5816, -121.4944
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    45, 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2', 'Sacramento, CA', NULL, 'United Way California Capital Region', 'California State University, Sacramento',
    '7/1/2023 - 6/30/2024', 'concluded', '80', 'Public',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', NULL, '$500',
    'Monthly', '12 months', NULL, true,
    38.5816, -121.4944
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    46, 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3', 'Sacramento, CA', NULL, 'United Way California Capital Region', 'California State University, Sacramento',
    '1/1/2024 - 12/31/2024', 'concluded', '130', 'Public/Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', NULL, '$500',
    'Monthly', '12 months', NULL, true,
    38.5816, -121.4944
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    47, 'Collegiate Guaranteed Income Program', 'Sacramento and Davis, CA', NULL, 'United Way California Capital Region (UWCCR)', NULL,
    'May 2024 - June 2026', 'concluded', '20', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Former foster youth attending college and part of the Guardian Scholars programs at Sacramento State University and University of California, Davis', '$500',
    'Monthly', '12 -24 months', 'Connection to other resources such as food, career development, and more', false,
    38.5449, -121.7405
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    48, 'Family First Economic Support Pilot', 'Sacramento County, CA', 'Zip codes 95815, 95821, 95823, 95825, 95828​​​ and 95838', 'Sacramento County Division of Child, Family, and Adult Services - Child Protective Services (DCFAS-CPS), United Way California Capital Region (UWCCR), MEF Associates', NULL,
    '2023 -', 'active', '200', 'Public',
    'Families', 'Demographic targeting (individuals who belong to a demographic group)', 'Residents of targeted zip codes who are parents or legal guardians of a child aged 0 to 5 with annual household income of less than 200% of the federal poverty line', '$725',
    'Monthly', '12 months', NULL, false,
    38.4747, -121.3542
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    49, 'Black Women''s Resilience Project', 'San Diego, CA', NULL, 'Café X, San Diego for Every Child and Jewish Family Service', NULL,
    '3/1/2022 - 3/1/2025', 'concluded', '150', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Families selected have at least one child in the family 12 years old or younger, with a maximum income of $53,000 for a family of four.', '$500',
    'Monthly', '24 Months', NULL, false,
    32.7157, -117.1611
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    50, 'San Diego for Every Child', 'San Diego, CA', 'Encanto, Paradise Hills, National City, San Ysidro', 'San Diego for Every Child', 'MGI, Jewish Family Service of San DIego',
    'March 2022 - March 2024', 'concluded', '150', 'Private',
    'Households', 'Neighbourhood-level means testing and demographic', 'Individuals 18 years and older in eligible zip codes with at least one child under 12 years of age living in the home', '500 USD',
    'Monthly', '12 months', NULL, true,
    32.7157, -117.1611
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    51, 'It All Adds Up pilot (Bay Area Thriving Families study)', 'San Francisco, CA', NULL, 'Compass Family Services, Hamilton Families, Housing Solutions Lab at NYU Furman Center, UC Berkeley Terner Center for Housing Innovation', 'Google, J-PAL North America',
    '11/1/2023 -', 'active', '450', 'Public/Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Targeted to families that recently experienced homelessness who are preparing to exit a rapid re-housing program through Compass Family Services or Hamilton Families. It All Adds Up is a five-year pilot. It includes a randomized controlled trial (RCT) evaluation study -- called Bay Area Thriving Families -- led by the NYU Furman Center Housing Solutions Lab, in collaboration with UC Berkeley Terner Center for Housing Innovation. A total of 450 families will be enrolled in the study, with 225 randomly assigned to the treatment group receiving $1,000 per month and 225 randomly assigned to the control group receiving $50 per month. The pilot specifically aims to determine whether unconditional cash payments to families exiting rapid re-housing programs can help them achieve long-term housing stability. Funding for the pilot and study comes from Google, J-PAL North America, U.S. Dept. of Housing and Urban Development, Russell Sage Foundation, and Robert Wood Johnson Foundation.', '$1,000',
    'Monthly', '12 Months', NULL, true,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    52, 'San Francisco''s Guaranteed Income Pilot for Artists (GIPA)', 'San Francisco, CA', NULL, 'Yerba Buena Center for the Arts (YBCA)', 'The City of San Francisco',
    '5/1/2021 - 11/1/2022', 'concluded', '130', 'Public/Private',
    'Individuals', 'Program participation (e.g. participation in other programs or services, however eligibility not contingent on ongoing participation)', 'Artists who living in San Francisco who were disproportionately impacted by the COVID-19 pandemic', '$1,000',
    'Monthly', '18 months', NULL, false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    53, 'BEEM: The Black Economic Equity Movement Project', 'San Francisco & Oakland, CA', 'LIHTC qualified Census tracts', 'University of California, San Francisco, Oregon Health & Science University and University of California, Berkeley, MyPath, Community Working Group, National Institute of Health, Community Financial Resources, Sage Financial Solutions, Financial Capabilities Investment, and Reese Financial Services, Bay Area Legal Aid', NULL,
    '11/14/2022 - 8/1/2024', 'concluded', '300', 'Public',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Identification with a demographic group (e.g. age, gender identity, race)', 'Black young adults (18-24 at the time of enrollment), living in a LIHTC qualified census tract or unhoused, not receiving other GI at the time of enrollment.', '$500',
    'Monthly', '12 Months', 'Optional financial mentoring and financial education.  Evaluation used waitlist control design, where half of participants received payment in year 1, half received payments in year 2.', true,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    54, 'Cash Transfers and Rapid Re-Housing', 'San Francisco Bay Area, CA', NULL, 'Abode Services, LEO at University of Notre Dame, J-PAL', NULL,
    'Feb 2023 - Dec 2027', 'active', '990', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Individuals who have transitioned from homelessness to stable housing and are now exiting Rapid Re-Housing (RRH). This pilot is strucutred as a randomized controlled trial (RCT) with evaluation conducted by LEO at the University of Notre Dame.  Participants receive 12 months of cash transfers when they exit the Abode Services RRH program. The treatment group includes 495 families receiving payments of $1650 ($2000 for families) for the first 4 months, and $800 ($1000 for families) for the final 8 months. The control group includes 495 families receiving $50 per month.', '$800 - $2000',
    'Monthly', '12 months', NULL, true,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    55, 'Project Empower', 'San Francisco Bay Area, CA', NULL, 'Tahirih', 'My New Red Shoes',
    '2/1/2023 - 7/1/2023', 'concluded', '10', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', '10 Tahirih clients, all survivors of domestic violence with a child or children', '$1,000',
    'Monthly', '6 months', NULL, false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    56, 'San Francisco Housing Stability Fund', 'San Francisco Bay Area, CA', NULL, 'Tipping Point Community', 'UpTogether, Urban Institute',
    'September 2021 - August 2022', 'concluded', '30', 'Private',
    'Individuals', 'Identification through program/service', 'Individuals phasing out of a 2-year rapid rehousing subsidy', '1000 USD',
    'Monthly', '6 months', 'Legal assistance and financial coaching', false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    57, 'The Trust Youth Initiative San Francisco', 'San Francisco, CA', NULL, 'Point Source Youth', 'Chapin Hall at University of Chicago, Larkin Street Youth Services, UpTogether, City of San Francisco Dept. of Homelessness and Supportive Housing, Google',
    '8/1/2023 - 7/31/2025', 'concluded', '45', 'Public/Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Transition-age youth (TAY) aged 18-24 who are experiencing homelessness.', '$1,500',
    'Monthly', '24 months', NULL, false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    58, 'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI)', 'San Francisco, CA', NULL, 'Yerba Buena Center for the Arts (YBCA)', 'Black Freighter Press, Chinese Culture Center of San Francisco (CCCSF), The Transgender District, Dance Mission Theater, Galeria de la Raza, and the San Francisco Bay Area
Theatre Company (SFBATCO)',
    'June 2022 - 2024', 'concluded', '60', 'Private',
    'Individuals', 'Identification through program/service', 'Individuals nominated by six partnering organizations, with years of grassroots work in their communities, that YBCA is calling the Creative Communities Coalition for Guaranteed Income.', '1000 USD',
    'Monthly', '18 months', NULL, false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    59, 'Foundations for the Future', 'San Francisco, CA', NULL, 'San Francisco Human Services Agency (SFHSA)', 'California Department of Social Services (CDSS), the City and County of San Francisco, the San Francisco Juvenile Probation Department (SFJPD), Tipping Point Community, Urban Institute, Chapin Hall',
    '11/1/2023 - 5/31/2025', 'concluded', '150', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'At least 21 years old and have aged out of San Francisco extended foster care through Family & Children''s Services or Juvenile Probation on or after January 1, 2022. Have an annual household income of $60,000 or less for a single adult (no children) in San Francisco County, an income floor based on the Insight Center''s Family Needs Calculator.', '1,200 USD',
    'Monthly', '18 months', 'Benefits counseling through Bay Area Legal Aid (BALA), financial literacy counseling through First Place for Youth (FPFY)', false,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    60, 'Compass Family Service Basic Income Pilot', 'San Francisco, CA', NULL, 'Compass Family Services and Wells Fargo Foundation', NULL,
    'October 2021 - March 2022', 'concluded', '13', NULL,
    'Households', 'Identification through program/service and individual/household means testing', 'Families with low-income and children enrolled in Compass Children''s Center', '350 USD',
    'Monthly', '6 months', NULL, true,
    37.7749, -122.4194
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    61, 'Miracle Money', 'San Francisco, Oakland, and Los Angeles, CA', NULL, 'Miracle Messages', 'University of Southern California',
    'May 2022 - July 2024', 'concluded', '103', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Unhoused individuals who expressed interest in the Miracle Friends program', '$750',
    'Monthly', '12 months', 'Social support through the Miracle Friends phone buddy program', false,
    NULL, NULL
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    62, 'Guaranteed Income Program for Domestic Violence Survivors', 'San Mateo County, CA', NULL, 'San Mateo County', 'Community Overcoming Relationship Abuse (CORA)',
    '7/1/2025 - 6/30/2026', 'concluded', '20', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Survivors of domestic violence with at least one minor child', '$1,000',
    'Monthly', '12 months', NULL, false,
    37.4337, -122.4014
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    63, 'Immigrant Families Recovery Program: San Mateo County', 'San Mateo County, CA', NULL, 'Mission Asset Fund (MAF), San Mateo County Government', 'Samaritan House, Legal Aid Society of San Mateo County, Faith in Action Bay Area',
    'February 2022 - December2024', 'concluded', '500', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Households not eligible to receive a second-round stimulus check (Economic Impact Payment) from the Federal government, have a household income less than 80% area median income ($97,440 for an individual), lost income due to the coronavirus (COVID-19) pandemic, and have not yet received a grant from MAF through the CA College Student Support Fund, LA Young Creatives Fund, or Immigrant Families Fund.', '400 USD',
    'Monthly', '24 months', 'Financial resources and services', false,
    37.4337, -122.4014
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    64, 'San Mateo County Guaranteed Income Program for Former Foster Youth', 'San Mateo County, CA', NULL, 'San Mateo County', NULL,
    '1/1/2024 - 6/30/2025', 'concluded', '70', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Current and former foster youth ages 18 up to 22', '$1,000',
    'Monthly', '18 months', NULL, false,
    37.4337, -122.4014
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    65, 'San Mateo County Baby Bonus Pilot Program', 'San Mateo County, CA', NULL, 'First 5 San Mateo County, Health Plan of San Mateo County, County of San Mateo, Jackie Speier Foundation, UpTogether, Stanford University', NULL,
    'March 2025 -', 'active', '400', 'Public/Private',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'San Mateo County birthing parents (with newborn babies) receiving Medi-Cal through the Health Plan of San Mateo may be eligible. Pilot is designed as a randomized controlled trial (RCT). Recipint families receive payments from the time they give birth until their child turns three. The program also brings together key community partners to explore the impact of coordinated care support to families in conjunction with cash aid.', '$300',
    'Monthly', '36 months', 'Some families will get connected to a Community Health Worker who will assist with finding doctors, home visits, food support, and other early childhood services', true,
    37.4337, -122.4014
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    66, 'Aging With Dignity', 'Santa Clara County, CA', NULL, 'Destination Home, Sacred Heart Community Services', NULL,
    NULL, NULL, '50', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Vulnerable seniors, a population ineligible for many public benefits and at increasing risk of homelessness', NULL,
    NULL, NULL, NULL, false,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    67, 'GBI for Unhoused High School Students', 'Santa Clara County, CA', NULL, 'County of Santa Clara', NULL,
    NULL, 'active', '75', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Unhoused high school seniors', '$1,200',
    'Monthly', '24 months', NULL, true,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    68, 'GBI for Young Parents', 'Santa Clara County, CA', NULL, 'County of Santa Clara', NULL,
    NULL, 'active', '100', 'Public',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Young parents and pregnant people ages 14 to 26', '$1,200',
    'Monthly', '24 months', NULL, true,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    69, 'Re-Entry Guaranteed Income', 'Santa Clara County, CA', NULL, 'Destination Home, County of Santa Clara', NULL,
    NULL, 'active', '100', 'Public/Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Justice-involved individuals recently released from jail or prison who had been incarcerated for at least 6 consecutive months', '$1,200',
    'Monthly', '24 months', NULL, true,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    70, 'Silicon Valley Guaranteed Income Project', 'Santa Clara County, CA', NULL, 'Destination: Home', 'UCSF Benioff Homelessness and Housing Initiative',
    '12/1/2022 - 11/1/2024', 'concluded', '150', 'Private',
    'Households', 'Household means test', 'Homeless and unstably housed families', '$1,000',
    'Monthly', '24 months', NULL, true,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    71, 'Santa Clara County UBI Pilot for Former Foster Youth', 'Santa Clara County, CA', NULL, 'My Path, Excite Credit Union', 'GICP',
    'October 2020 - July 2025', 'concluded', '122', 'Public/Private',
    'Individuals', 'Demographic', 'Young adults 22-24 years of age transitioning out of foster care. First cohort of 72 individuals started payments in October 2020, second cohort of 50 individuals started payments in August 2023.', '1000 - 1200 USD',
    'Monthly', '18 -24 months', NULL, false,
    37.3541, -121.9552
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    72, 'Preserving Our Diversity (POD) Pilot #1', 'Santa Monica, CA', NULL, 'City of Santa Monica, Housing and Economic Development', NULL,
    'November 2017 - December 2018', 'concluded', '21', 'Public',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals aged 62 or older living in rent-controlled apartments since Jan 2000', '151 - 813 USD',
    'Monthly', '14 months', NULL, false,
    34.0195, -118.4912
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    73, 'Preserving Our Diversity (POD) Pilot #2', 'Santa Monica, CA', NULL, 'City of Santa Monica, Housing and Economic Development', NULL,
    'November 2019 - June 2023', 'concluded', '248 -  463', 'Public',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals aged 65 or older who have occupied rent controlled apartments since Jan 2000 and have an annual household income equal or less than 50% area median income for LA County', '750 USD for single person household
1300 USD for 2 person household',
    'Monthly', NULL, NULL, false,
    34.0195, -118.4912
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    74, 'Pathway to Income Equity', 'Sonoma County, CA', NULL, 'First 5 Sonoma County', NULL,
    '1/18/2023 - 12/18/2024', 'concluded', '305', 'Public/Private',
    'Households', 'Geographic and means-testing: all resident in an eligible geographic area, such as a census tract or zip-code who meet an income cut-off or threshold.', 'Pregnant and/or parent/guardian of a child 0-5 years of age, Income at less than 185% of Federal Poverty Level, Impacted by COVID-19 (loss of income, housing instability), Sonoma County resident', '500 USD',
    'Monthly', '24 months', NULL, false,
    38.578, -122.9888
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    75, 'Mothers Rising for Guaranteed Basic Income', 'South Los Angeles, CA', 'Live in Watts/Willowbrook (90002, 90059); West Athens (90044, 90047); Broadway Manchester (90003, 90061); Compton (90059, 90223, 90220, 90224, 90221, 90222).', 'Rising Communities', 'Fund for Guaranteed Income (disbursement), F5LA (main funder)',
    '3/30/2024 - 3/30/2027', 'active', '100', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race), self-identify as mother with at least 1 dependent child ages 0-2 or pregnant mother', 'To be eligible, applicants must:  Live in Best Start Region 2 of South Los Angeles, including Watts/Willowbrook 90002, 90059 West Athens 90044, 90047 Broadway Manchester 90003, 90061 Compton 90059, 90223, 90220, 90224, 90221, 90222 Self-identify as a mother, including birthing people, biological or adoptive mothers, legal guardian, or have full caretaking responsibilities Be 18 years old at the time of application deadline Be pregnant or have at least one dependent child ages 0-2 at the time of application deadline, that lives more than 50% of the time with applicant mother/guardian/caretaker Cannot be enrolled in any other GBI pilot program Have a household income of up to 200% of the federal poverty line', '500 USD (250 twice per month)',
    'Twice monthly', '36 months', 'Financial Literacy, professional development opportunities, credit building/repair, pathway for homeownership, access to community navigators', false,
    33.9731, -118.2479
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    76, 'South San Francisco Guaranteed Income Program', 'South San Francisco, CA', NULL, 'City of South San Francisco', 'GICP, YMCA of San Francisco',
    'December 2021 - November 2022', 'concluded', '160', 'Public',
    'Individuals', 'Demographic', 'Foster youth aging out of care, single heads of households, families with minor aged children and residents of the city''s lowest income census block tracks.', '500 USD',
    'Monthly', '12 months', NULL, false,
    37.6547, -122.4077
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    77, 'Stockton Economic Empowerment Demonstration (SEED)', 'Stockton , CA', NULL, 'Reinvent Stockton Foundation', 'GICP, MGI',
    'February 2019 - February 2021', 'concluded', '125', 'Private',
    'Individuals', 'Neighbourhood-level means testing', 'Households in ZIP codes with area-level income under the median of $46,033', '500 USD',
    'Monthly', '24 months', 'Social supports', true,
    37.9577, -121.2908
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    78, 'Ventura County Thrive', 'Ventura County, CA', NULL, 'Ventura County Health and Human Services Agency', 'James Storehouse; California Department of Social Services (CDSS); Urban Institute; Social Finance, Inc.',
    '10/10/2023 - 9/30/2025', 'concluded', '150', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Former Foster Youth Age 21-26.', 'Must have exited extended foster care at age 21.', '1,000 USD',
    'Monthly', NULL, 'Financial literacy, access to resources through James Storehouse', false,
    34.3705, -119.1391
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    79, 'West Hollywood Pilot for Guaranteed Income', 'West Hollywood, CA', NULL, 'City of West Hollywood and National Council of Jewish Women-LA', 'Mayors for a Guaranteed Income (MGI) and Center for Guaranteed Income Research (CGIR)',
    'August 2022 - January 2024', 'concluded', '25', 'Public/Private',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals 50 years and older, living housed or unhoused in West Hollywood, with an income equal to or less than $41,400 (the ''very low income'' category that is 50% of AMI for Los Angeles County in 2021 as determined by U.S. Department of Housing and Urban Development)', '1000 USD',
    'Monthly', '18 months', NULL, false,
    34.09, -118.3617
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    80, 'Yolo County Basic Income (YOBI)', 'Yolo County, CA', NULL, 'Yolo County Health and Human Services Agency (HHSA)', 'University of California, Davis Center for Regional Change; Yolo County Children''s Alliance',
    '4/1/2022 - 3/31/2024', 'concluded', '76', 'Public/Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation)', 'Only CalWORKs households with either a pregnant parent or child under the age of five were eligible to enroll to receive the YOBI payment. Two groups of families were enrolled, those receiving the cash benefit and Housing Support Program (YOBI+ HSP) and those receiving the cash benefit only (YOBI only). 76 families participated, which included about 200 individuals.', 'Dynamic amount based on family size and other income. The monthly cash transfer amount was calculated by subtracting family income from the California Poverty Measure threshold for that family size (and adding one dollar to the difference), with a floor of $600, maximum of $2449, average of $1289.',
    'Monthly', '24 months', 'The CalWORKs Housing Support Program offers rapid re-housing assistance to homeless or at risk of homeless families receiving CalWORKs. Families could enroll or disenroll in Housing Support throughout the program, but all had some housing insecurity. Supportive services available through CalWORKs were provided while eligible and other services from Yolo County Children''s Alliance were provided. Credit union budgeting courses were provided two or three times as optional events.', true,
    38.7646, -121.9018
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    81, 'Miracle Money  - Dignity Fund expansion', 'California', NULL, 'Miracle Messages', NULL,
    'December 2024 -', 'active', '110', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Dignity Fund is an expansion of Miracle Message''s Miracle Money program. It provides direct cash support for unhoused individuals engaged in long-term support through the Miracle Friends phone buddy program.', '$300',
    'Monthly', '12 months', 'Social support through the Miracle Friends phone buddy program', false,
    36.7783, -119.4179
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    82, 'Smooth Transitions', 'State of California', NULL, 'iFoster', 'The Urban Institute, California Department of Social Services (CDSS)',
    '11/14/2023 - 3/1/2026', 'concluded', '300', 'Public/Private',
    'Individuals', 'Youth exiting extended foster care at age 21', NULL, '750 USD',
    'Monthly', '27 months', 'Supports to transitional age youth (TAY) provided by iFoster', true,
    36.7783, -119.4179
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    83, 'Respond, Recover and Rebuild', 'Cherokee Nation', NULL, 'Cherokee Nation', NULL,
    'June 2021', 'concluded', '392,832', 'Public',
    'Individuals', 'None', 'Every Cherokee Nation citizen, and those with a citizenship application with all supporting documentation completed by June 1, 2022', '2000 USD',
    'One time', 'Not applicable', NULL, false,
    35.9154, -94.97
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    84, 'Thriving Providers Project (CO)', 'Alamosa, Conejos, Costilla, Denver, Eagle, Garfield, Gunnison, Mineral, Pitkin, Rio Grande, Saguache', NULL, 'Home Grown', 'Stanford Center on Early Childhood, Impact Charitable, Spiral Impact, Aidkit',
    NULL, 'concluded', '100 cash recipients; 55 consented to be part of study', 'Private',
    'Individuals', 'Home-based child care providers', NULL, '500 USD',
    'Monthly', '12 months', 'Participants are offered an optional Peer Support group of other home-based child care providers through their local CBO', false,
    39.5501, -105.7821
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    85, 'Elevate Boulder', 'Boulder, CO', NULL, 'City of Boulder Housing & Human Services Department', 'Impact Charitable, AidKit and OMNI Institute',
    '1/15/2024 - 1/31/2026', 'concluded', '200', 'Public/Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race), Due to use of ARPA funds, participants must indicate that they have been impacted by COVID-19.', 'Rsidents of the City of Boulder, 18+ years of age, have income between 30 - 60% area median income for Boulder County; and were impacted by COVID-19.', '500 USD',
    'Monthly', '24 months', 'Optional participation in evaluation activities (surveys, focus groups, storytelling) with additional incentive payments. Participants will also receive information about financial coaching opportunities from local government and nonprofit agencies.', false,
    40.015, -105.2705
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    86, 'Thriving Providers Project (CO)', 'Boulder, CO', NULL, 'City of Boulder', 'Impact Charitable, Colorado Statewide Parent Coalition',
    '1/1/2024 - 8/31/2025', 'concluded', '20', 'Public',
    'Individuals', 'Identification with a demographic group (e.g. age, gender identity, race)', 'Low-income (below 80% AMI) x 18 years of age or older at the time of application x City of Boulder resident x Currently providing childcare to at least one child under the age of 5 who is not their own child x Providing at least 20 hours of childcare per week x Unlicensed at the time of application, operating as a license-exempt provider under Colorado regulations (i.e., are caring for no more than four children, or two children under two, at any given time or only a single family).', '501 USD',
    'Monthly', '25 months', NULL, false,
    40.015, -105.2705
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    87, 'Harrison 2 - Colorado Springs', 'Colorado Springs, CO', 'Harrison School District 2', 'UpTogether', NULL,
    'November 2020 - March 2023', 'concluded', '95', 'Private',
    'Households', 'Identification through program/service', 'Families with children in the Harrison School District Two in Colorado Springs, CO', '168',
    'Monthly', '19 months', NULL, false,
    38.8339, -104.8214
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    88, 'Build With Families', 'Greater Denver area (Jefferson, Adams, Arapaho, Denver Counties)', NULL, 'Gary Community Ventures', 'Impact Charitable',
    '6/11/2022 - 3/1/2023', 'concluded', '110', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'To be eligible to enroll, families were required to be living at or below the MIT Self-Sufficiency Standard (https://livingwage.mit.edu/) and live in Gary Community Venture’s four-county metro Denver focus area (Jefferson, Adams, Arapaho, Denver Counties). Participants were required to to complete the Gary Community Ventures application form, participate in one orientation explaining what the sponsor was hoping to accomplish with BWF, and review program terms and sign a Terms of Service (TOS) agreement.', '$199',
    'Monthly', '9 Months', NULL, true,
    39.7392, -104.9903
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    89, 'Denver Basic Income Project', 'Denver, CO', NULL, 'Denver Basic Income Project, Impact Charitable, City of Denver', 'GICP, MGI, University of Denver Center for Housing and Homelessness Research',
    'July 2021 - December 2023', 'concluded', '11 (August 2021 soft launch), 28 (July 2022 2.0) and 820 (full launch by November 2022)', 'Public/Private',
    'Individuals', 'Identification through program/service', 'Individuals 18-years and older who are unhoused or underhoused, do not have severe and unaddressed mental health or substance use needs and are connected to a partner service provider', 'One third of participants will receive a one-time cash transfer of $6,500 at the beginning of the study with an additional $500 for 11 months, one third will receive 12 monthly cash transfers of $1,000, and one third will not receive a cash transfer and will serve as the control group, receiving a stipend of $50 a month.',
    'One-time and monthly, or monthly', '12 months', 'Partner organization services', true,
    39.7392, -104.9903
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    90, 'The Bridge Network', 'Denver, CO', NULL, 'The Bridge Network', 'UpTogether',
    'July 2021 - June 2023', 'concluded', '20 in 12 month pilot, 15 in 24 month pilot', 'Private',
    'Individuals', 'Identification through program/service', 'Families connected with Cross Purpose', '500 USD',
    'Monthly', '12 or 24 months', NULL, false,
    39.7392, -104.9903
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    91, 'Seattle-Denver Income Maintenance Experiment (SIME/DIME)', 'Denver, CO', NULL, 'Stanford Research Institute', NULL,
    '1971  - 1982', 'concluded', '4800', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with income less than $9000 USD if one head of household was employed and less than $11,000 USD if both employed, with even number of white, black and Mexican-American households selected (last group only in Denver, CO)', '316, 400 or 466 USD',
    'Monthly', NULL, NULL, true,
    39.7392, -104.9903
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    92, 'Healthy Beginnings Project', 'Denver, Delores and Montezuma Counties, CO', '80203,  80204,  80205,  80206, 80207,  80208, 80209,  80210  80211  80212  80216  80217, 80218, 80219,  80220,  80223,  80224,  80225, 80230,  80236,  80237 80238  80239  80243  80244  80248  80249 80250  80251  80252  80256  80257  80259  80261,  80262, 80263,  80264,  80265, 80266,  80271  80273  80274 80279,  80280, 80281, 80290,  80291,  80293, 80294 80295 80299 81320,  81324, 81332,  81324, 81321, 81323, 81327, 81328, 81330, 81331, 81334, 81335', 'Impact Charitable', 'Income Movement, Pinon Project, Denver Health',
    '11/30/2023 - 2/14/2025', 'concluded', '20', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation), Must be pregnant 2nd - 3rd trimester. Program participation = applicants identified through Denver Health and Pinon Project.', 'Pregnant individuals, at least 18 years of age, people below 80% AMI, resident of Denver, Delores or Montezuma Counties.', '375 USD',
    'bi-weekly', '15 months', 'Research study participation incentives (varies according to specific participation i.e. survey, vs journal entry), Medical stipends for pre/post natal care. (up to 3 visits at $200 each)', false,
    39.7392, -104.9903
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    93, 'San Luis Valley, Colorado', 'San Luis Valley, CO', NULL, 'UpTogether', 'SLV Immigrant Resource Center, 1st Southwest Fund',
    'December 2021 - September 2022', 'concluded', '75', 'Public',
    'Individuals', 'Identification through program/service', 'Individuals who earn a low-income, as identified by two local nonprofits', '200 USD',
    'Monthly', '18 months', NULL, false,
    37.5833, -106.0
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    94, 'Elm City Reentry Pilot', 'New Haven. CT', NULL, '4-CT', 'Project M.O.R.E. Reentry Welcome Center, City of New Haven, Mastercard''s Global Cities Team and Usio',
    NULL, 'concluded', '20', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Identification with a demographic group (e.g. age, gender identity, race), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation)', 'Participants (ages 18+) are individuals returning from prison to a New Haven City or County address and were selected by Project M.O.R.E. Reentry Welcome Center and are currently receiving services related to their transition back to the community. Participation in the pilot is not contingent upon continued services through Project M.O.R.E.', '500 USD',
    'Monthly', '12 months', 'Reentry Welcome Center', false,
    41.3083, -72.9279
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    95, 'Let''s Go DMV!', 'Washington, DC region (including suburban Maryland and Northern Virginia)', NULL, 'if, A Foundation for Radical Possibility', 'Amalgamated Bank, Amalgamated Foundation, Bread for the City, DC Guaranteed Income Coalition, Greater Washington Community Foundation, Restaurant Opportunities Center of DC, Washington Regional Association of Grantmakers and Whitman-Walker Health.',
    'March 2022- December 2026', 'active', '75', 'Private',
    'Individuals', 'Demographic and means-testing', 'DC-area hospitality workers who lost employment because of COVID. Most participants were already engaged with ROC-DC. Participants are decided on by workers.', '1000 USD',
    'Monthly', '60 months', NULL, false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    96, 'Strong Families, Strong Future DC', 'Washington D.C.', 'Wards 5, 7, and 8', 'Martha’s Table, Office of the Deputy Mayor for Planning and Economic Development', NULL,
    'March 2022 - February 2023', 'concluded', '132', 'Individuals',
    NULL, 'Neighbourhood-level means testing, individual/household means-testing and demographic', 'Individuals  in target wards with a household income no more than 250% of the federal poverty level for the family/household size, and expecting/new mothers.', '900 USD',
    'Monthly', '12 months', 'Weekly access to healthy groceries and children’s/professional clothing at no cost, the opportunity to enroll child in nationally accredited early education programming, the chance to build relationships with other parents while strengthening parenting skills, support for personal education and career journey.', false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    97, 'Family Goal Fund', 'Washington DC', NULL, 'LIFT, Inc', 'GICP',
    'January 2018 -', 'active', '800+', 'Private',
    'Households', 'Identification through program/service', 'Households in the LIFT program with low-income and children 0-8 years of age', '150 USD',
    'Quarterly', 'Up to 24 months', NULL, false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    98, 'Mother Up Pilot', 'Washington DC', NULL, 'Mother''s Outreach Network', NULL,
    '5/1/2023 - 4/1/2026', 'concluded', '50', 'Private',
    'Households', NULL, NULL, '$500',
    'Monthly', '3 years', NULL, false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    99, 'My Sister''s Place Cash Transfer Program', 'Washington DC', NULL, 'My Sister''s Place', 'The Health Equity Fund at The Greater Washington Community Foundation',
    '1/1/2023 - 12/1/2024', 'concluded', '45', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Black mothers with children aged 14 or younger who have current or recent involvement with the D.C. Child & Family Services Agency (CFSA)', '$500',
    'Monthly', '2 years', NULL, false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    100, 'Thrive East of the River', 'Washington DC', 'East of the River', 'Martha''s Table, Bread for the City, 11th Street Bridge Park, and Far Southeast Family Strengthening Collaborative', NULL,
    '7/1/2020 – 1/31/2022', 'concluded', '500', 'Private',
    'Households', 'Household means test', 'Martha''s Table''s Education programs or non-MT families who earn an income of $35,000 and below annually', '$1,100',
    'Monthly', '5 months', NULL, false,
    38.9072, -77.0369
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    101, 'The Delaware Healthy Mother & Infant Consortium (DHMIC)', 'Wilmington and New Castle County, DE', NULL, 'Delaware Healthy Mother & Infant Consortium', 'Rose Hill Community Center and Health Management Associates',
    '4/1/2022 - 3/1/2024', 'concluded', '40', 'Public',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Domestic violence survivors', '$1,000',
    'Monthly', '24 months', NULL, false,
    39.7447, -75.5484
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    102, 'Eastern Band of Cherokee Indians Casino Revenue Fund', 'Eastern Band of Cherokee Indians', NULL, 'Eastern Band of Cherokee Indians', NULL,
    '1996 -', 'active', '15,414', 'Public',
    'Individuals', 'None', 'Individuals over 18, however band members start accumulating the transfer when born, which is dispersed in three tranches less taxes at 18, 21 and 25 years in addition to the bi-yearly payment.', '3500-6000 USD',
    'Bi-annual', NULL, NULL, false,
    35.4745, -83.3207
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    103, 'EBCI GenWell Program', 'Eastern Band of Cherokee Indians', NULL, 'Eastern Band of Cherokee Indians (EBCI)', NULL,
    '3/1/2025 -', 'active', NULL, 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Members of the Eastern Band of Cherokee Indians who are 18 years of age or older, recognized by the Tribe as duly enrolled, and who do not fall within the specific exemptions from eligibility, are eligible to participate in the EBCI GenWell Program.', 'Up to $800',
    'Monthly', 'Ongoing', NULL, false,
    35.4745, -83.3207
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    104, 'Just Income', 'Gainesville, FL', NULL, 'Community Spring', 'CGIR, GICP',
    'January 2022 - February 2023', 'concluded', '115', 'Private',
    'Individuals', 'Demographic', 'Alachua County residents within six months of their release from federal/Florida state prison, release from jail with a felony, or beginning felony probation.', '1000 USD first month, then 600 per month USD',
    'Monthly', '12 months', NULL, true,
    29.6516, -82.3248
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    105, 'GI 305 Community Fund', 'Miami, Florida', 'Zip codes 33125, 33127, 33128, 33135, 33136, 33142, 33147, 33150', 'GI 305', NULL,
    '4/1/2024 - 3/31/2025', 'concluded', '5', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'The 8 eligible zipcodes are areas of Miami, Florida experiencing high rates of climate gentrification and displacement. Participants also need to be over the age of 16.', '$650',
    'Monthly', '12 Months', 'Connection to other community organizations, GI 305 Organizing & Educational Campaign', false,
    25.7617, -80.1918
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    106, 'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation)', 'Atlanta, GA', NULL, 'City of Atlanta and Urban League of Greater Atlanta', 'MGI',
    'January 2022 - May 2023', 'concluded', '300', 'Public/Private',
    'Individuals', 'Individual/household means-testing', 'Individuals 18 and over who earn up to 200% of the Federal Poverty Line for household size ($25,760 for single person)', '500 USD',
    'Monthly', '12 months', NULL, true,
    33.749, -84.388
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    107, 'In Her Hands - Atlanta''s Old Fourth Ward', 'In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods.', 'Old Fourth Ward', 'GRO Fund', 'GiveDirectly, Propel, Aidkit, Old 4th Ward Economic Security Task Force',
    'May 2022 - May 2024', 'concluded', '214', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.', '$850',
    'Monthly', '24 months', NULL, false,
    33.7537, -84.37
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    108, 'In Her Hands - Atlanta''s Westside Neighborhoods', 'In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods.', 'English Ave., Vine City, Bankhead, Washington Park', 'GRO Fund', 'GiveDirectly, Propel, Aidkit, Old 4th Ward Economic Security Task Force',
    'August 2024 - August 2027', 'active', '275', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income women (average income approximately $15,000). Split payment groups (a) receives $1,000 per month for 36 months (b) receives $8,000 lump sum (flexible timing), $800 remaining 35 months.', '$1,000',
    'Monthly', '36 Months', NULL, false,
    33.7537, -84.37
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    109, 'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties)', 'In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods.', NULL, 'GRO Fund', 'GiveDirectly, Propel, Aidkit, Old 4th Ward Economic Security Task Force',
    'August 2022 - August 2024', 'concluded', '236', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.', '$850',
    'Monthly', '24 Months', NULL, false,
    33.7537, -84.37
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    110, 'In Her Hands - City of College Park', 'In Her Hands  includes four sites in Georgia: (1) Atlanta''s Old Fourth Ward, (2) Clay, Terrell, and Randolph Counties, (3) College Park, (4) Atlanta''s Westside neighborhoods.', NULL, 'GRO Fund', 'GiveDirectly, Propel, Aidkit, Old 4th Ward Economic Security Task Force',
    'October 2022 - October 2024', 'concluded', '204', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income women (average income approximately $15,000). Split payment groups (a) receives $850 per month for 24 months (b) receives $4300 lump sum in month 1, $700 remaining 23 months.', '$850',
    'Monthly', '24 Months', NULL, false,
    33.7537, -84.37
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    111, 'Rural Income Maintenance Experiment', 'Calhound and Pocahontas Counties, IA', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1970 - 1972', 'concluded', '810', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '24 months', NULL, true,
    42.39, -94.63
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    112, 'UpLift - The Central Iowa Basic Income Pilot', 'Polk, Dallas, and Warren Counties, IA', NULL, 'Project Coordination Team at The Harkin Institute', 'UPenn CGIR (lead reasearchers) Des Moines University (local research team), Mid-Iowa Health Foundation (lead funder)',
    '5/15/23 - 4/15/25', 'concluded', '110', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race), No eligibility or targeting criteria', 'Age 18+, live in tri-county area, have a dependent up to the age of 25, and have an AMI of 60% or less.', '500',
    'Monthly', NULL, NULL, true,
    41.5868, -93.625
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    113, 'Champaign County Guaranteed Income Project', 'Champaign County, IL', NULL, 'University of Illinois', 'Regional Office of Education Nine (ROE9)',
    '3/1/2023 - 9/30/2026', 'active', '10', 'Public/Private',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'Children and families identified by the McKinney-Vento Act that meet the definition of asset-limited, income-constrained, and employed (ALICE) with a particular focus on Black, Latinx, Asian, and Mixed Race families.', '$750',
    'Monthly', '6 Months', NULL, false,
    40.1403, -88.1963
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    114, 'Affording Survival', 'Chicago, IL', NULL, 'The Network', 'LIFT-Chicago, WINGS Program, Family Rescue, Center for Guaranteed Income Research (CGIR) at the University of Pennsylvania',
    '7/27/2024 - July 2025', 'concluded', '60', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Survivors of domestic violence, over 18, parent/caregiver of a minor child, resides in rapid rehousing program at WINGS or Family Rescue during recruitment phase, lives in the Chicago metropolitan area', '$1,000',
    'Monthly', '12 Months', NULL, false,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    115, 'Chicago Resilient Communities Pilot', 'Chicago, IL', NULL, 'City of Chicago, Department of Family and Support Services, GiveDirectly', 'AidKit, University of Chicago Inclusive Economy Lab, Economic Security Project, Economic Security for Illinois, Harvard Government Performance Lab, 
YWCA Metropolitan Chicago',
    'June 2022  - May 2023', 'concluded', '5000', 'Public',
    'Individuals', 'Individual/household means-testing', 'Individuals 18 years and older with income at or below 250% of the Federal Poverty Level (up to $32,200 for single household) who have experienced economic hardship related to COVID-19', '500 USD',
    'Monthly', '12 months', NULL, true,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    116, 'Dream Keeper Fellowship', 'Chicago, IL', NULL, 'Direct Giving Lab', NULL,
    '1/1/2024 - 1/1/2026', 'concluded', '70 low-income families. Proposed expansion to 200', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income families', '$100',
    'Monthly', '12 Months', NULL, false,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    117, 'Evanston Equitable Recovery Fund', 'Chicago, IL', NULL, 'Family Independence Initiative', NULL,
    '4/26/2021 - 2/26/2022', 'concluded', '24', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Black residents who lived in Evanston between 1919 and 1969 or have a direct ancestor who lived in the city during that time', '$300',
    'Monthly', '10 Months', NULL, false,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    118, 'Family Goal Fund', 'Chicago, IL', NULL, 'LIFT, Inc', 'GICP',
    'January 2018 -', 'active', '800+', 'Private',
    'Households', 'Identification through program/service', 'Households in the LIFT program with low-income and children 0-8 years of age', '150 USD',
    'Quarterly', 'Up to 24 months', NULL, false,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    119, 'Cook County Promise Guaranteed Income', 'Cook County, IL', NULL, 'Cook County Government, Bureau of Economic Development (BED), GiveDirectly', 'AidKit, University of Chicago Inclusive Economy Lab (IEL)',
    'October 2022 - 2025', 'concluded', '3,250', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Individuals  18 or older with a household income at or below 250% of the federal poverty level or less, and  
no one else in your household is participating in another guaranteed income pilot.', '$500',
    'Monthly', '24 months', NULL, false,
    41.812, -87.892
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    120, 'Every Dollar Counts', 'Cook, Iroquois, Kane, LaSalle, Lee, Ogle, Will, Winnebago', NULL, 'Heartland Alliance', 'GICP',
    'January 2020 - December 2023', 'concluded', 'Not available', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals between ages of 21-40 with total household income up to 300% of the Federal Poverty Level (up to $38,640 for a single person)', '50 or 1000 USD',
    'Monthly', '26 months', NULL, false,
    41.812, -87.892
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    121, 'Guaranteed Income Pilot Program', 'Evanston, IL', NULL, 'City of Evanston and Northwestern University', 'Northwestern Good Neighbour Racial Equity Fund',
    'April 2021 - January 2022', 'concluded', '165', 'Public/Private',
    'Individuals', 'Demographic', 'Individuals aged 18-24, senior and undocumented residents with low-income', '500 USD',
    'Monthly', '12 months', NULL, true,
    42.0451, -87.6877
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    122, 'Direct Giving Lab', 'Illinois', NULL, 'Direct Giving Lab', NULL,
    '5/1/2017 - May 2018', 'concluded', '70 low-income families. Proposed expansion to 200', 'Public/Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Selected using the free and reduced meal (FARM) program at Highland Park High School', '$100 or $150',
    'Monthly', '12 or 24 Months', NULL, false,
    40.6331, -89.3985
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    123, 'Empower Parenting with Resources (EmPwR)', 'Illinois', NULL, 'University of Illinois Urbana-Champaign, Brightpoint', 'Illinois Department of Children and Family Services, William T. Grant Foundation, Doris Duke Foundation',
    NULL, NULL, '800', 'Public',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'Families who were referred by the Illinois Department of Children and Family Services to receive services for allegations of child maltreatment', '$100 - $500, adjusted for local cost of living and family size',
    'Monthly', '12 months', NULL, false,
    40.6331, -89.3985
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    124, 'Chicago Future Fund', 'Chicago, IL', 'West Garfield Park', 'EAT Chicago', 'GCIP, Fund for Guaranteed Income',
    'October 2021 - April 2023', 'concluded', '30', 'Private',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals 18-35 who live in targeted neighbourhood, formerly convicted or incarcerated and make less than $12,000/year', '500 USD',
    'Monthly', '18 months', NULL, false,
    41.8781, -87.6298
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    125, 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)', 'Illinois and Texas', NULL, 'OpenResearch', NULL,
    '11/1/2020 - 10/31/2023', 'concluded', '3,000', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Individuals living in one of 19 study counties in Texas and Illinois who were aged 21 to 40, with total household income less than 300% of the federal poverty line (average annual household income of $29,900), not receiving SSI or living in public housing (to avoid risk of losing these key public benefits). Pilot was structured as a randomized controlled trial (RCT), with 1,000 individuals randomly assigned to the treatment group to receive $1,000 per month, and 2,000 individuals randomly assigned to the control group to receive $50 per month. Extensive data were collected with study results available at https://www.openresearchlab.org/projects/unconditional-cash-study.', '$1,000',
    'Monthly', '36 months', NULL, false,
    31.9686, -99.9018
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    126, 'Gary Income Maintenance Experiment', 'Gary, IN', NULL, 'State of Indiana Department of Public Welfare', 'University of Indiana',
    '1971 - 1974', 'concluded', '1782', NULL,
    'Households', 'Individual/household means-testing and demographic', NULL, '275 or 358 USD',
    'Monthly', NULL, NULL, true,
    41.5934, -87.3464
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    127, 'Guaranteed Income Validation Effort (GIVE Gary)', 'Gary, IN', NULL, 'City of Gary', 'MGI',
    'May 2021 - May 2022', 'concluded', '100', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals at least 18 years old with an income of $35,000 or less', '500 USD',
    'Monthly', '12 months', 'Financial wellness services', true,
    41.5934, -87.3464
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    128, 'The Rooted School: The 50 Dollar Study', 'Indianapolis, IN', NULL, 'Rooted School Foundation', 'Center for Guaranteed Income Research (CGIR)',
    '10/1/2022 - 9/30/2024', 'concluded', '470', 'Private',
    'Individuals', 'Demographic', 'High school senior enrolled at Rooted School New Orleans', '50 USD',
    'Weekly', '12 months', NULL, true,
    39.7684, -86.1581
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    129, 'YALift! (Young Adult Louisville Income For Transformation)', 'Louisville, KY', 'California, Russell, Smoketown', 'Louisville Metro Government', 'MGI, Metro United Way, Russell: A Place of Promise',
    'April 2022 - March 2023', 'concluded', '151', 'Public/Private',
    'Individuals', 'Neighbourhood-level means testing and demographic', 'Individuals 18-24 who live in the California, Russell, and Smoketown neighbourhoods.', '500 USD',
    'Monthly', '12 months', NULL, false,
    38.2527, -85.7585
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    130, 'Baby''s First Years - Louisiana', 'Greater New Orleans metropolitan area, LA', NULL, 'Teacher''s College, Columbia University and University of Wisconsin, Madison', 'University of California, Irvine, University of Maryland, College Park, Duke University, New York University, University of New Orleans',
    '5/1/2018 -', 'active', '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income mothers with newborns', '$20 or $333',
    'Monthly', '76 Months', NULL, true,
    29.9511, -90.0715
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    131, 'Shreveport Guaranteed Income', 'Shreveport, LA', NULL, 'City of Shreveport', 'MGI, United Way of Northwest Louisiana, Shreveport Financial Empowerment Centre',
    'March 2022 - March 2023', 'concluded', '110', 'Public/Private',
    'Households', 'Individual/household means-testing and demographic', 'Single caregivers with school-aged children with income up to 120% of the Federal Poverty rate', '600 USD',
    'Monthly', '12 months', NULL, true,
    32.5252, -93.7502
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    132, 'The Truth & Reconciliation Project''s Guaranteed Monthly Income', 'Louisiana', NULL, 'ACLU of Louisiana and the Fund for Guaranteed Income', 'Buck and Gracie Close',
    '12/1/2023 - 12/1/2024', 'concluded', '12', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Individuals in Lousiana who were victims of police violence and didn''t receive legal resistution', '$1,000',
    'Monthly', '12 months', NULL, false,
    30.9843, -91.9623
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    133, 'New Orleans Guaranteed Income Program', 'New Orleans, LA', NULL, 'City of New Orleans', 'MGI, CIGR',
    'April 2022 - March 2023', 'concluded', '125', 'Private',
    'Individuals', 'Demographic', 'Young adults aged 16-24 who are neither in school nor working', '350 USD',
    'Monthly', '12 months', NULL, false,
    29.9511, -90.0715
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    134, 'The Rooted School: The 50 Dollar Study', 'New Orleans, LA', NULL, 'Rooted School Foundation', 'Center for Guaranteed Income Research (CGIR)',
    '10/1/2022 - 9/30/2024', 'concluded', '470', 'Private',
    'Individuals', 'Demographic', 'High school senior enrolled at Rooted School New Orleans', '50 USD',
    'Weekly', '12 months', NULL, true,
    29.9511, -90.0715
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    135, 'Camp Harbor View Guaranteed Income Pilot', 'Boston, MA', NULL, 'Camp Harbor View & UpTogether', 'GICP, UpTogether',
    'August 2021 - August 2023', 'concluded', '50', 'Private',
    'Households', 'Individual/household means-testing and demographic', 'Child in one of CHVs youth serving programs and  self-certify as low-income but not receiving most benefits', '583 USD',
    'Monthly', '24 months', NULL, true,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    136, 'Community Love Fund', 'Boston, MA', NULL, 'The National Council', 'Fund for Guaranteed Income',
    'February 2022 - January 2023', 'concluded', '21', 'Private',
    'Individuals', 'Demographic', 'Women who are incarcerated or formerly incarcerated', '500 USD',
    'Monthly', '12 months', NULL, false,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    137, 'Pediatric RISE', 'Boston, MA', NULL, 'Dana-Farber Cancer Institute Department of Pediatric Oncology', 'Boston Children''s Hospital Division of Pediatric Hematology/Oncology, Dana-Farber Cancer Institute Division of Population Sciences, Harvard Medical School Department of Pediatrics, Dana-Farber Cancer Institute Department of Data Science, Boston Children''s Hospital Department of Cardiology, University of Texas Southwestern Medical Center Department of Pediatrics, Harvard School of Dental Medicine, Harvard Law School',
    '10/1/2024 - 12/31/2024', 'concluded', '20', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income children with cancer', '$300 - $500',
    'Bi-monthly (twice per month)', '3 months', NULL, false,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    138, 'Striving Towards Economic Prosperity (STEP)', 'Boston, MA', 'South End, Roxbury, other Boston neighborhoods', 'Unitd South End Settlements', NULL,
    '10/1/2021', 'active', '32', 'Private',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'Families with children, with 16 families each in cohort 1 and cohort 2', '$800-$850',
    'Monthly', '18-24 months', NULL, false,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    139, 'Trust and Invest Collaborative', 'Boston and Cambridge, MA', NULL, 'UpTogether', 'Massachusetts Department of Transitional Assistance; Harvard University',
    'June 2021 - December 2022', 'concluded', '1482', NULL,
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals 18 and older with at least one dependent child with a household income level under 200% of the federal poverty level.', 'Minimum of $760',
    'Monthly', '18 months', NULL, false,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    140, 'Cambridge RISE (Recurring Income for Success and Empowerment)', 'Cambridge, MA', NULL, 'City of Cambridge', 'MGI, UpTogether',
    'September 2021 - February 2023', 'concluded', '130', 'Private',
    'Households', 'Individual/household means-testing and demographic', 'Individuals with an income up to  80% of the area median income caring for children under 18', '500 USD',
    'Monthly', '18 months', NULL, false,
    42.3736, -71.1097
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    141, 'Chelsea Eats', 'Chelsea, MA', NULL, 'City of Chelsea', 'MGI, Shah Family Foundation',
    'November 2020 - May 2021', 'concluded', '2000', 'Public/Private',
    'Households', 'Identification through program/service', 'No direct targeting but 80% of cash assistance card applications were submitted by residents attending city or partner agency food pantries', '200 - 400 USD',
    'Monthly', '6 months', NULL, true,
    42.3918, -71.0328
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    142, 'Healthy Families MA (HFM) Family Financial Pilot', 'Cities and towns in the HFM Springfield catchment area: Agawam, Blandford, East Longmeadow, Granville, Hampden, Longmeadow, Montgomery, Russell, Southwick, Springfield, Tolland, West Springfield, Wilbraham', NULL, 'Children''s Trust of MA', 'Square One/HFM Springfield',
    '6/15/2023 - 6/30/2025', 'concluded', '123', 'Public',
    'Individuals', 'First - time parents, living in the catchment area', 'Eloigible if enrolled in HFM, although level of engagement does not matter, e.g., could be absent from home visits yet still receive cash payments.', '500 USD after child''s birth, 300 USD additional for twins, 100 USD for prenatal participants until baby''s birth, final 3 payments 550 USD, 650 USD, and 750 USD',
    'Monthly', '24 months', 'participate in HFM home visits, which include referral connections and group offerings, financial skills-building based on partciipants'' interests.', false,
    42.1015, -72.5898
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    143, 'Bridge to Prosperity Cliffs Pilot Program', 'Greater Boston, Worcester, and Springfield, MA', NULL, 'Springfield WORKS', 'The Boston Foundation, Boston Medical, The Food Bank of Western Massachusetts, Department of Transitional Assistance, Women''s Money Matters, WesternMass Economic Development Council, JPMorgan Chase',
    NULL, NULL, '100', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income working families receiving public assistance', '$300 - $700, plus a $10,000 bonus upon program completion',
    'Monthly', '36 months', NULL, false,
    42.3601, -71.0589
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    144, 'Family Health Project', 'Lynn, MA', NULL, 'Health Metrics', 'GICP, Lynn Community Health Centre',
    'January 2018 -', 'concluded', '30', 'Private',
    'Households', 'Individual/household means-testing and demographic', 'Mothers with low-income', '400 USD',
    'Monthly', '36 months', NULL, false,
    42.4668, -70.9495
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    145, 'Economic Stability/Mobility Initiative', 'Newton, MA', NULL, 'The City of Newton and Economic Mobility Pathways (EMPath)', NULL,
    '9/1/2023 - September 2025', 'concluded', '50 families', 'Public',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income Newton families who are at or below 50 percent of the Area Median Income, have children under 18 years old (or are pregnant), and who are interested in working and increasing their income', '$250',
    'Monthly', '12 Months', NULL, false,
    42.337, -71.2092
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    146, 'Prince George Guaranteed Income Pilot Program', 'Prince George''s County, MD', NULL, 'Thrive Prince George''s', 'CASA Prince George''s, United Communities Against Poverty (UCAP), and Capital Area Asset Builders (CAAB)',
    '4/1/2024 - 3/1/2026', 'concluded', '175', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', '50 youth (age 18-24) who have aged out of foster care and 125+ seniors (age 60+) within Prince George''s County.', '$800',
    'Monthly', '24 months', NULL, false,
    38.83, -76.85
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    147, 'Montgomery County Guaranteed Income Program', 'Mongomery, MD', NULL, 'Uptogether, Montgomery Couty Government', NULL,
    'August 2022 - July 2024', 'concluded', '300', 'Public/Private',
    'Households', 'Identification through program/service', '100 households recently served by the Montgomery County Homeless Continuum of Care and 200 participants with at least one child/dependent who had previously sought assistance from the County during the COVID 19 pandemic were invited to apply, and selected through a randomized application process.', '8000 USD',
    'Monthly', '24 months', NULL, false,
    39.1547, -77.2405
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    148, 'Baltimore Young Families Success Fund', 'Baltimore, MD', NULL, 'City of Baltimore', 'MGI',
    '8/1/2022 - 07/01/2024', 'concluded', '200', 'Public/Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals between the ages of 18-24 with children, and have an annual income at or below 300% of the federal poverty level based on household size', '1000 USD',
    'Monthly', '24 months', NULL, true,
    39.2904, -76.6122
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    149, 'Project Home Trust', 'Maine', NULL, 'Quality Housing Coalition', NULL,
    '6/1/2023 - 5/31/2024', 'concluded', '20', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Low-income, single mothers who had previously experienced homelessness.', '$1,000',
    'Monthly', '12 months', NULL, false,
    45.2538, -69.4455
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    150, 'Guaranteed Income to Grow Ann Arbor', 'Ann Arbor, MI', NULL, 'City of Ann Arbor', NULL,
    '1/1/2024 - January 2026', 'concluded', '100 families/individuals', 'Public',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low- and moderate-income households with individuals engaged in some form of entrepreneurship, including home-based businesses', '$528',
    'Monthly', '24 Months', NULL, false,
    42.2808, -83.743
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    151, 'Rx Kids', 'Michigan', NULL, 'GiveDirectly', 'Michigan State University Pediatric Public Health Initiative, Poverty Solutions at the University of Michigan, Greater Flint Health Coalition, Hurley Children''s Hospital',
    '1/1/2024 -', 'active', '10,000+', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Currently at least 16 weeks pregnant or legal guardian of a child 6 months old or younger born after the local community eligibility cutoff date, and resident of an eligible local community in Michigan.', '$1,500 as a one-time payment during pregnancy (after 20 weeks), $500 per month for the first 6 or 12 months (differs by local community) after the baby''s birth',
    'One-time + Monthly', '13 months', NULL, false,
    44.3148, -85.6024
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    152, 'Thriving Families', 'Washtenaw County, MI', NULL, 'Ann Arbor Area Community Foundation; United Way of Washtenaw County', 'UpTogether',
    'April 2022 - April 2024', 'concluded', '45', 'Private',
    'Individuals', 'Identification through program/service', 'Families involved with Washtenaw County social service providers', '1250 USD',
    'Quarterly', '24 months', NULL, false,
    42.25, -83.84
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    153, 'Project Solid Ground', 'Minneapolis–St. Paul (Twin Cities), MN', NULL, 'Avivo', NULL,
    '10/1/2020 - 9/30/2021', 'concluded', '15', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Randomly selected individuals who were participants in Avivo''s treatment, training, or career advancement services', '$1,000',
    'Monthly', '12 months', NULL, false,
    44.9778, -93.265
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    154, 'Minneapolis Guaranteed Basic Income Pilot', 'Minneapolis, MN', NULL, 'City of Minneapolis', 'MGI',
    'June 2022 - May 2024', 'concluded', '200', 'Public',
    'Households', 'Individual/household means-testing', 'Individuals with household income 50% or less of the city''s median area income, with priority given to housing insecure families, those in job training or educational programs who have dropped out due to financial hardship, and young people headed households', '500 USD',
    'Monthly', '24 months', NULL, false,
    44.9778, -93.265
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    155, 'CollegeBound Boost', 'St. Paul, MN', NULL, 'St. Paul’s Office of Financial Empowerment', 'University of Michigan',
    'Fall 2022 -', 'active', '333', 'Public/Private',
    'Households', 'Demographic targeting (individuals who belong to a demographic group)', 'Low-income families enrolled in the CollegeBound Saint Paul program', '$500',
    'Monthly', '18 Months', NULL, false,
    44.9537, -93.09
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    156, 'Guaranteed Income for Artists', 'St. Paul, MN', NULL, 'Springboard for the Arts', 'GICP, City of St. Paul Office of Financial Empowerment, McKnight Foundation, Bush Foundation',
    'April 2021 - October 2022', 'concluded', '25', 'Private',
    'Households', 'Demographic', 'Artists in targeted neighbourhoods who received support from  Coronavirus Personal Emergency Relief Fund', '500 USD',
    'Monthly', '18 months', NULL, false,
    44.9537, -93.09
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    157, 'International Institute of Minnesota''s Guaranteed Income Program for Refugees', 'St. Paul, MN', NULL, 'International Institute of Minnesota', 'University of Illinois',
    'August 2022 - July 2023', 'concluded', '25', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Single-parent households with children under the age of 15,or families with four or more children, one working parent, and one parent with obstacles to employment, orsingle adults with physical or mental illness limiting their ability to work or obtain employment, or families or single adults unable to work due to delays in paperwork processing or other barriers beyond their control.', '750 USD',
    'Monthly', '12 months', NULL, false,
    44.9537, -93.09
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    158, 'People''s Prosperity Pilot', 'St. Paul, MN', NULL, 'City of St. Paul', 'MGI',
    'October 2020 - March 2022', 'concluded', '150', 'Public/Private',
    'Households', 'Neighbourhood-level means testing', 'Households financially impacted by COVID-19, and enrolled in college saving program', '500 USD',
    'Monthly', '18 months', 'Early childhood development, Financial health resources', true,
    44.9537, -93.09
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    159, 'Baby''s First Years - Minnesota', 'Twin Cities (Minneapolis and St. Paul), MN', NULL, 'Teacher''s College, Columbia University and University of Wisconsin, Madison', 'University of California, Irvine, University of Maryland, College Park, Duke University, New York University, University of Minnesota',
    '5/1/2018 -', 'active', '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income mothers with newborns', '$20 or $333',
    'Monthly', '76 Months', NULL, true,
    44.9778, -93.265
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    160, 'Rai$e Program', 'Minnesota', NULL, 'Wilder Foundation', 'Evaluation partner, Wilder Research',
    '1/31/2023 - 8/25/2024', 'concluded', '150', 'Private',
    'Households', 'Identification through program/service', 'Pilot spans two 12-month cohorts: Jan.-Dec. 2023; and Sept. 2023-Aug. 2024. Participants live in Minnesota, but participants are primarily in the Twin Cities metropolitan area.

Program participation — identification through program or service. However, ongoing eligibility is not contingent on ongoing participation in program. Guaranteed Income payments were made to an indiviudal from each selected household of two cohorts of 75. In each cohort of 75, 45 were drawn from Wilder programs; 15 from Build Wealth MN; and 15 from Prepare + Prosper. To be eligibile, an individual from a household must be at least 18 years old; manage their own finances; and be participating in program to strengthen their financial stability. Participants were referred by program staff and entered into lotteries for selection. One person per household was selected.', '500 USD',
    'Monthly', '24 months', 'Benefits counseling is offered to selected households before enrollment and participants at the end of the program. Resources are shared with past participants as well as current ones. During the program, participants are offered optional resources and services focused on financial education, wellness, and empowerment, as well as other community resources. Financial service industry volunteers offer 1:1 counseling to answer financial questions and refer to resources. Participants opt-in and no services are required for program participation.', false,
    46.7296, -94.6859
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    161, 'Magnolia Mother''s Trust Cohort 4', 'Jackson, MS', NULL, 'Springboard to Opportunities', NULL,
    '5/1/2022 - 4/1/2023', 'concluded', '100', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Black mothers living in federally subsidized housing.', '$1,000',
    'Monthly', '12 months', NULL, false,
    32.2988, -90.1848
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    162, 'Magnolia Mother''s Trust', 'Jackson, MS', NULL, 'Springboard to Opportunities', 'GICP',
    '2018 -', 'active', '100', 'Private',
    'Individuals', 'Demographic', 'Black mothers living in federally subsidized housing', '1000 USD',
    'Monthly', '12 months', NULL, false,
    32.2988, -90.1848
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    163, 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi', 'Warren County, MS', NULL, 'Rural GMI Initiative', 'GiveDirectly, the Atwoods, OpenResearch',
    '12/1/2025 -', 'active', 'About 530', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.', '$1,500',
    'Monthly', '16 months', NULL, false,
    32.35, -90.87
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    164, 'LIFT', 'Missoula. MT', '59804', 'Mountain Home, MT', 'University of Montana School of Social Work',
    '8/23/2022 - 8/24/2023', 'concluded', '10', 'Private',
    'Households', 'Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation),', 'All residential clients (mothers with their children) in Mountain Home''s residential program.', '500 USD',
    'Monthly', '12 months', 'Wrap-around, two generational services: evidence-based parenting classes; basic needs and transportation; access to a licensed mental health center for both adults and children; 24/7 telehealth opportunities along with a doula and health navigation team; supportive employment and education program; trauma informed childcare and access to a community center with 250 workshops (tax preparation and financial literacy to health and wellness workshops); non-mandatory monthly skill-building sessions (fundamentals of banking, goal setting, strength-based employment searches, stress management, building credit, reducing debt); free childcare and dinners at each of the 12 monthly sessions.', false,
    46.8722, -113.994
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    165, 'The Returning Citizen Stimulus (RCS) Program', '28 cities in the United States', NULL, 'Center for Employment Opportunities (CEO)', 'Justice and Mobility Fund',
    '4/1/2020 - 2021', 'concluded', '10,400', 'Private',
    'Individuals', 'Individual means test', 'Formerly incarcerated individuals', 'Variable: $2,250-$2,750',
    '3 payments', '3 payments', NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    166, 'Project 100+', 'Multiple', NULL, 'GiveDirectly', 'GICP, Propel, Stand for Children',
    'April 2020 - October 2021', 'concluded', '200,000', 'Private',
    'Households', 'Identification through program/service', 'Individuals who are Providers (Electronic Benefit Transfer) app users and receive Supplemental Nutrition Assistance Program funds', '1000 USD',
    'One time', NULL, NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    167, 'Bootstraps', 'United States', NULL, 'Pale Blue Dot Media, Netroots Foundation, and HandUp', NULL,
    '2018 -', 'active', '20', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Twenty Americans randomly selected by filmmakers', '$12,000',
    'Yearly', '2 Years', NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    168, 'Growing Strong', 'United States', NULL, 'Women in Need Homeless Shelter System', 'Vanderbilt University',
    'January 2020 -', 'active', '200', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Mothers with children under 2 experiencing homelessness living at specific WIN shelters', '$1,500',
    'Monthly', '24 Months', NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    169, 'The Resilience Fund', 'United States', NULL, 'Polaris', NULL,
    '12/1/2023 - 7/1/2025', 'concluded', '24', 'Private',
    'Individuals', 'Individual means test', 'Eligible participants are survivors of human trafficking, encompassing both sex and labor trafficking, residing in the United States', '$500',
    'Monthly', '18 months', NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    170, 'Immigrant Families Recovery Program - National', 'United States', NULL, 'Mission Asset Fund (MAF)', NULL,
    '2021 - 2023', 'concluded', '3000', 'Private',
    'Households', 'Identification through program/service', 'Families who previously received an Immigrant Families Grant from MAF. Families are immigrant families with young children who have been excluded from federal relief.', NULL,
    NULL, NULL, NULL, false,
    39.8283, -98.5795
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    171, 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina', 'Beaufort County, NC', NULL, 'Rural GMI Initiative', 'GiveDirectly, the Atwoods, OpenResearch',
    '11/3/2025 -', 'active', 'About 530', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.', '$1,500',
    'Monthly', '16 months', NULL, false,
    35.53, -76.85
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    172, 'Rural Income Maintenance Experiment', 'Duplic County, NC', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1970 - 1972', 'concluded', '810', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '24 months', NULL, true,
    34.93, -77.94
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    173, 'Excel', 'Durham, NC', NULL, 'StepUp Durham, City of Durham', 'GICP, MGI, CGIR',
    'March 2022 - February 2023', 'concluded', '109', 'Public/Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals who have been released from prison (NC State prison, a prison in another state, or federal prison) within the last 5 years prior to application, returning to a Durham address (City or County), and with an income below 60% Durham-Chapel Hill AMI.', '600 USD',
    'Monthly', '12 months', NULL, false,
    35.994, -78.8986
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    174, 'Baby''s First Years - Nebraska', 'Greater Omaha metropolitan area, NE', NULL, 'Teacher''s College, Columbia University and University of Wisconsin, Madison', 'University of California, Irvine, University of Maryland, College Park, Duke University, New York University, University of Nebraska, Lincoln',
    '5/1/2018 -', 'active', '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income mothers with newborns', '$20 or $333',
    'Monthly', '76 Months', NULL, true,
    41.2565, -95.9345
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    175, 'New Jersey Income Maintenance Experiment', 'Jersey City, NJ', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1968-1972', 'concluded', '1357', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '12 months', NULL, true,
    40.7178, -74.0431
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    176, 'Newark Movement for Economic Equity', 'Newark, NJ', NULL, 'City of Newark', 'MGI, JFI, Community Foundation of New Jersey',
    'October 2021 - September 2023', 'concluded', '200 receiving bi-weekly payment, 200 receiving bi-annual payment', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals 18 and over with an income 200% below the federal poverty income line and who are housing insecure', '250  (bi-weekly) or 3000 (semi-annually) USD',
    'Bi-weekly and semi-annually', '24 months', NULL, true,
    40.7357, -74.1724
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    177, 'New Jersey Income Maintenance Experiment', 'Paterson, NJ', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1968-1973', 'concluded', '1357', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '12 months', NULL, true,
    40.9168, -74.1718
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    178, 'Paterson Guaranteed Income Pilot Program', 'Paterson, NJ', NULL, 'City of Paterson', 'GICP, MGI',
    'July 2021 - June 2022', 'concluded', '110', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals 18 and over with an annual income $30,000 or less for individuals and $88,000 or less for households', '400 USD',
    'Monthly', '12 months', NULL, false,
    40.9168, -74.1718
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    179, 'New Jersey Income Maintenance Experiment', 'Prassaic, NJ', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1968-1974', 'concluded', '1357', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '12 months', NULL, true,
    40.8568, -74.1285
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    180, 'New Jersey Income Maintenance Experiment', 'Scranton, NJ', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1968-1976', 'concluded', '1357', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', NULL, NULL, true,
    41.409, -75.6624
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    181, 'New Jersey Income Maintenance Experiment', 'Trenton, NJ', NULL, 'Institute for Research on Poverty, University of Wisconsin -Madison', NULL,
    '1968-1975', 'concluded', '1357', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with at least one working-age male who was neither a full-time student nor disabled with income up to 150% of the federal poverty level ($3,330 for a family of four in 1968)', 'Varied',
    'Monthly', '16 months', NULL, true,
    40.2206, -74.7597
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    182, 'Students Experiencing Homelessness Basic Needs Stipend Pilot', 'Albuquerque and La Cruces, NM', NULL, 'New Mexico Appleseed', 'GICP, LANL Foundation, Cuba Independent School District, West Las Vegas School District',
    '2020- 2021', 'concluded', '53', 'Public/Private',
    'Individuals', 'Demographic', 'High school students who qualify as unhoused or underhoused', '500 USD',
    'Monthly', '8 months', NULL, false,
    35.0844, -106.6504
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    183, 'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot', 'Alburquerque, NM', NULL, 'New Mexico Appleseed', 'GICP, Albuquerque Public Schools, Las Cruces Public Schools, Western Sky Community Care',
    'January 2020 - December 2021', 'concluded', '65', 'Public/Private',
    'Individuals', 'Individual/household means-testing and demographic', '9th graders and other high-school students who live in housing conditions eligible for services under the federal law', 'Monthly',
    NULL, '3 months in Las Cruces and 4 months in Albuquerque', NULL, false,
    35.0844, -106.6504
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    184, 'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families', 'Bernalillo County, Santa Fe County, Rio Arriba County, McKinley County, Curry County, Roosevelt County, San Juan County, Chaves County, Lea County, Doña Ana County, Luna County, Grant County, and Hidalgo County.', NULL, 'UpTogether', 'UpTogether, Somos Un Pueblo Unido, NM CAFé, NM Voices for Children, Partnership for Community Action, El CENTRO de Igualdad y de Derechos, and Community Foundation of Southern New Mexico, Con Alma Health Foundation, and Thornburg Foundation',
    'January 2022 - December 2023', 'concluded', '330', 'Private',
    'Individuals', 'Demographic', 'Individuals in a undocumented or mixed-status family who are the parent or legal guardian of at least one minor child or an adult with a disability', '500 USD',
    'Monthly', '12 months', 'No', false,
    35.0844, -106.6504
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    185, 'Family Prosperity', 'La Cruces, NM', NULL, 'Community Action Agency, Families and Youth Innovations Plus, Jardin de Los Ninos', 'NMSU Crimson Research',
    '7/19/2023 - 7/19/2025', 'concluded', '300', 'Public/Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Single Caregiver Households', NULL, '500 USD',
    'Monthly', NULL, NULL, true,
    32.3199, -106.7637
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    186, 'Santa Fe Learn, Earn, Achieve Program (SF LEAP)', 'Santa Fe, NM', NULL, 'City of Santa Fe', 'MGI, StartSmall, Santa Fe Community Foundation',
    'October 2021 - September 2022', 'concluded', '100', 'Private',
    'Households', 'Individual/household means-testing and demographic', 'Individuals between 18-30 with an income 200% below the federal poverty line enrolled in a certificate or degree program at Santa Fe Community College', '400 USD',
    'Monthly', '12 months', NULL, false,
    35.687, -105.9378
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    187, 'The Bridge Project', 'New York, NY', 'Washington Heights, Inwood, Harlem, South Bronx, Central Bronx', 'Monarch Foundation', 'CIGR, GICP, Fed Bank of ATL',
    'Phase 1: June  2021 - June 2024
Phase 2: June 2022 - June 2025', 'concluded', 'Phase 1: 100
Phase 2: 500', 'Private',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals with at least one child up to 1 year old or who are currently pregnant in target zip codes, and have an annual household income under $52,000', 'Phase 1: 250 or 500
Phase 2: 500 for first 18 months, 250 for last 18 months',
    'Bi-weekly', '36 months', NULL, true,
    40.7128, -74.006
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    188, 'Jubilant Birth', 'Albany, NY', NULL, 'United Way of the Greater Capital Region', 'Albany County Executive''s Office, Carl E. Touhey Foundation, Highmark Blue Shield of Northeastern New York, Hudson Valley Credit Union, BirthNet, CEK RN Consulting, March of Dimes',
    '5/6/2025 - 5/6/2026', 'concluded', '25', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income, pregnant women in Albany, New York', '$1,000',
    'Monthly', '12 Months', NULL, false,
    42.6526, -73.7562
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    189, 'Artist Grants Program', 'Rochester, NY', NULL, 'The Local Sounds Collaborative', NULL,
    NULL, 'concluded', '6', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), and Identification as a member, worker, and/or participant within the local music community (live musician, studio musician, production engineer, sound technician, etc) and demonstrate financial need', NULL, '200 USD',
    'Monthly', '12 months', NULL, false,
    43.1566, -77.6088
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    190, 'HudsonUP', 'Hudson, NY', NULL, 'City of Hudson', 'GICP, MGI, The Spark of Hudson, Eutopia Foundation, Greater Hudson Promise Neighborhood',
    'November 2020 - September 2026', 'active', '75', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals 18 and over who earn less than City of Hudson median annual income of $35,153', '500 USD',
    'Monthly', '60 months', NULL, false,
    42.2529, -73.791
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    191, 'Ithaca Guaranteed Income', 'Ithaca, NY', NULL, 'Human Services Coalition of Tompkins County', 'CGIR',
    'June 2022 - May 2023', 'concluded', '110', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Primary unpaid caregivers to children and aging or disabled adults with an income at or below 80% area median income', '450 USD',
    'Monthly', '12 months', NULL, true,
    42.444, -76.5019
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    192, 'Level Up Guaranteed Income Pilot', 'Mount Vernon, NY', NULL, 'City of Mount Vernon', 'CGIR, MGI',
    'November 2022 - October 2024', 'concluded', '200', 'Individuals',
    'Individuals', NULL, '‍Individuals at least 18 years of age, have a minimum income requirement of $15,000, but no more than at or below 80% percent of the CDBG Annual Income Limit.', '500 USD',
    'Monthly', '12 months', NULL, true,
    40.9126, -73.8371
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    193, 'Family Goal Fund', 'New York, NY', NULL, 'LIFT, Inc', 'GICP',
    'January 2018 -', 'active', '800+', 'Private',
    'Households', 'Identification through program/service', 'Households in the LIFT program with low-income and children 0-8 years of age', '150 USD',
    'Quarterly', 'Up to 24 months', NULL, false,
    40.7128, -74.006
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    194, 'Baby''s First Years - New York', 'New York City, NY', NULL, 'Teacher''s College, Columbia University and University of Wisconsin, Madison', 'University of California, Irvine, University of Maryland, College Park, Duke University, New York University',
    '5/1/2018 -', 'active', '1,000 across all 4 Baby''s First Years study sites (New York City, New Orleans metropolitan area, the Twin Cities, Omaha metropolitan area)', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income mothers with newborns', '$20 or $333',
    'Monthly', '76 Months', NULL, true,
    40.7128, -74.006
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    195, 'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness', 'New York, NY', NULL, 'Point Source Youth', 'GICP, Chapin Hall at University of Chicago, NYC Office of the Mayor',
    'March 2022 - May 2024', 'concluded', '30', 'Public/Private',
    'Individuals', 'Demographic', 'LGBTQIA Youth 18-24 who are unhoused or underhoused', '1250 USD',
    'Bi-Monthly', 'Up to 24 months', NULL, true,
    40.7128, -74.006
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    196, 'City of Rochester Guaranteed Basic Income (GBI) Pilot Program', 'Rochester, NY', 'Qualified Census tracts', 'City of Rochester', NULL,
    '10/15/2023 - 11/1/2024', 'concluded', '351', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Residents meeting the income criteria', '$500',
    'Monthly', '12 Months', NULL, false,
    43.1566, -77.6088
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    197, 'Artist Grants', 'Rochester, NY', NULL, 'The Local Sound', NULL,
    'June 2022 - May 2023', 'concluded', '20', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals 18 and older, who identify s a member, worker, and/or participant within the local music community (live musician, studio musician, production engineer, sound technician, etc), with spots reserved for artists of color. Year 1 supported 5 artists, Year 2 supported 7 artists, Year 3 supported 8 artists.', '200 USD',
    'Monthly', '12 months', NULL, false,
    43.1566, -77.6088
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    198, 'Project Resilience', 'Ulster County, NY', NULL, 'Ulster County', NULL,
    'May 2021 - April 2022', 'concluded', '100', 'Private',
    'Individuals', 'Individual/household means-testing', 'Individuals making less than 80% area median income of $46,900', '500 USD',
    'Monthly', '12 months', NULL, false,
    41.8586, -74.3118
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    199, 'CRNY Guaranteed Income for Artists', 'New York State', NULL, 'Creatives Rebuild New York', NULL,
    '6/1/2022 - 3/31/2024', 'concluded', '2400', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals 18 years or older as of January 1, 2022, with financial need, and who identify as an artist, culture bearer, or culture maker.', '1000 USD',
    'Monthly', '18 months', 'Benefits Counseling', false,
    43.2994, -74.2179
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    200, 'Ohio Mothers Trust', 'Columbus, OH', NULL, 'Motherful', 'RISE Together Innovation Institute, UpTogether',
    '12/1/2024 - 11/1/2025', 'concluded', '32', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Single mothers with incomes at or below 80% of the area median', '$500',
    'Monthly', '12 months', NULL, false,
    39.9612, -82.9988
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    201, 'YSEQUITY', 'Yellow Springs, Ohio', NULL, 'Yellow Springs Community Foundation', 'Center for Guaranteed Income Research at the University of Pennsylvania',
    'January 2023 - December 2025', 'concluded', '90', 'Private',
    'Individuals', 'Individual/household means-testing', 'Residents of Yellow Springs and Miami Township, Ohio. 18 or older. Meets a certain income threshold. Weighted lottery favors single parents and those in the lowest income bracket.', '300 USD',
    'Monthly', '24 months', 'Optional free financial counseling', false,
    39.8064, -83.8927
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    202, 'UpTogether Tusla', 'Tusla, OK', NULL, 'UpTogether', 'George Kaiser Family Foundation, Community Service Council and its Power of Families program, Family & Children’s Services, James, Inc., Met Cares Foundation, The Parent Child Center of Tulsa, and Tulsa Educare',
    'July 2021 - October 2023', 'concluded', '304', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Individuals with at least one minor dependent child under the age of 9 in the household with a household income at lr below 150% the Federal Poverty Line', '500 USD',
    'Monthly', '18 months', NULL, false,
    36.154, -95.9928
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    203, 'Southern Oregon Success', 'Jackson and Josephine Counties, OR', NULL, 'UpTogether', 'Rogue Community Health, Family Nurturing Center, United Community Action Network, Health Care Coalition of Southern Oregon',
    'March 2022 - July 2023', 'concluded', '70', 'Private',
    'Individuals', 'Identification through program/service', 'Priority given to individuals who were forced to move because of the Alameda Fires in 2021', '100 USD',
    'Monthly', '12 months', 'Parenting support', false,
    42.3265, -122.8756
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    204, 'Oregon Direct Cash Transfers Plus', 'Multnomah, Clackamas, and Deschutes County, OR', NULL, 'Point Source Youth', 'Native American Youth Association, AntFarm Youth Services, J Bar J Youth Services',
    '2/1/2023 - 2/1/2025', 'concluded', '120', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Individuals between 18 and 24 actively experiencing homelessness', '$1,000',
    'Monthly', '25 months', NULL, false,
    45.5152, -122.6784
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    205, 'Black Resilience Fund', 'Portland, OR', NULL, 'Brown Hope', NULL,
    '6/1/2020 -12/31/2025', 'concluded', '50', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Individuals at least 18 years of age, identify as Black, African American or African and a Multonomah County resident, below an income threshold. 30-40% of program participants were members of priority communities including: formerly incarcerated, single parents, minimum-wage or low-wage workers (within $2 of Portland''s minimum wage), or foster care alumni', '$1,000 for adults, $1,500 for adults with 1 or 2 children, $2,000 for adults with 3 or more children',
    'Monthly', '36 Months', NULL, false,
    45.5152, -122.6784
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    206, 'Path Home Basic Income Guarantee Pilot Project', 'Portland, Oregon', NULL, 'Path Home', NULL,
    '2/1/2022 - 1/1/2024', 'concluded', '6', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Families with children who have experienced homelessness or housing instability', '$575',
    'Monthly', '2 years', NULL, false,
    45.5152, -122.6784
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    207, 'Path Home Cash Transfer Pilot Program', 'Portland Oregon and surrounding area', NULL, 'Path Home', NULL,
    '4/15/2024 - 3/15/2026', 'concluded', '15', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Households with children in the Portland area that have stable income of at least $30,660 per year (or $2,555 per month) and no greater than 200% of the Federal Poverty Guideline. Payments are disbursed through direct deposit, with an option to open a new account with a local credit union through a partnership with Path Home for unbanked participants or any participants interested in utilizing a credit union. Data tracking conducted quarterly to track participants'' sense of mental/physical wellbeing and financial and housing stability. Participants agree to participate in a quarterly survey and assessments throughout the duration of the program and follow-ups for several years following.', '$575',
    'Monthly', '24 Months', 'Optional connection to credit union membership. Light-touch case management services available on an ongoing basis with emphasis on financial stability goals.', false,
    45.5152, -122.6784
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    208, 'Multnomah Mothers'' Trust', 'Multonomah County, OR', NULL, 'Multonomah Ideas Lab', 'UpTogether',
    'January 2022 - June 2022', 'concluded', '75', 'Public',
    'Individuals', 'Demographic', 'Black women with children', '1000 USD',
    'Monthly', '6 months', 'Services attached to local community-based organizations', false,
    45.5152, -122.6784
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    209, 'Osage ARP Cash Assistance', 'Osage Nation', NULL, 'Osage Nation', NULL,
    'August 2021', 'concluded', '11,721', 'Public',
    'Individuals', 'Individual/household means-testing', 'Enrolled members of Osage Nation who attest to negative economic impact from COVID-19', 'Up to 2000 USD',
    'One time', NULL, NULL, false,
    36.6348, -96.347
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    210, 'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families', 'Philadelphia, PA', NULL, 'Children''s Hospital of Philadelphia', 'Denver Health, Leonard Davis Institute of Health Economics, University of Pennsylvania Perelman School of Medicine, Morehouse School of Medicine, University of Pennsylvania',
    '7/26/2023 - 11/14/2023', 'concluded', '24', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income parent-infant dyads', '$325',
    'Monthly', '4 months', NULL, false,
    39.9526, -75.1652
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    211, 'Guaranteed Resources Optimize Wellbeing (GROW)', 'Philadelphia, PA', NULL, 'Office of Community Empowerment and Opportunity', NULL,
    '6/1/2023 - June 2024', 'concluded', '51 experiment, 239 control', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'E-TANF beneficiaries are parents who have received TANF benefits for at least 60 months and experience circumstances that prevent them from securing and maintaining full-time employment. All E-TANF beneficiaries in Philadelphia participate in the Work Ready workforce development program administered by JEVS Human Services.', '$50 or $500',
    'Monthly', '12 Months', NULL, false,
    39.9526, -75.1652
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    212, 'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)', 'Philadelphia, PA', NULL, 'Thomas Jefferson University Hospital Sidney Kimmel Cancer Center', 'University of Pennsylvania School of Social Policy and Practice, Mathematica, University of Tennessee College of Social Work',
    '4/1/2023 - 4/1/2024', 'concluded', '100', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Demographic targeting (individuals who belong to a demographic group)', 'Low-income, advanced stage cancer patients over the age of 18, receiving chemotherapy or immunotherapy who are Pennsylvania Medicaid beneficiaries', '$1,000',
    'Monthly', '12 months', NULL, false,
    39.9526, -75.1652
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    213, 'Philadelphia Guaranteed Income Program', 'Philadelphia, PA', NULL, 'WorkReady, City of Philadelphia', 'MGI',
    'March 2022 - March 2023', 'concluded', 'Up to 60', 'Public/Private',
    'Individuals', 'Individual/household means-testing', 'Recipients of Temporary Assistance for Needy Families (TANF)', '500 USD',
    'Monthly', 'Up to 12 months', NULL, true,
    39.9526, -75.1652
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    214, 'PHLHousing+', 'Philadelphia, PA', NULL, 'Philadelphia Housing Development Corporation (PHDC)', 'University of Pennsylvania',
    'September 2022 - April 2025', 'concluded', '300', 'Public/Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation). Households with an income at or below 50% AMI, with at least one child under the age of 15, and on the Philadelphia Housing Authority waitlist for Housing Choice Vouchers (HCV) or public housing.', 'Cash payments subsidize household income so that housing costs are 30% of total income, and payments range betwen $89  - $2079',
    'Monthly', '30 months', NULL, true,
    39.9526, -75.1652
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    215, 'Providence Guaranteed Income Program', 'Rhode Island', NULL, 'City of Providence, Amos House', 'MGI',
    'November 2021 - April 2023', 'concluded', '110', 'Public/Private',
    'Individuals', 'Individual/household means-testing', 'Individuals making incomes below 200% of the Federal Poverty Line ($25,760 and below for single person)', '500 USD',
    'Monthly', '15 months', NULL, true,
    41.5801, -71.4774
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    216, 'CLIMB (Columbia Life Improvement Monetary Boost)', 'Columbia, SC', NULL, 'City of Columbia; Central Carolina Community Foundation', 'MGI, Midlands Father Coalition',
    'September 2021 - August 2022', 'concluded', '100', 'Private',
    'Individuals', 'Identification through program/service', 'Father who are currently or recently enrolled in a program with the Midland Fathers Coalition', '500 USD',
    'Monthly', '12 months', 'Education and services for men', false,
    34.0007, -81.0348
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    217, '37208 Demonstration', 'Nashville, TN', '37208 Zip Code', 'Moving Nashville Forward (MOVE)', 'GICP, NEJA, CGIR',
    'November 2021 - October 2022', 'concluded', '100', 'Private',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals in target zip code making less than $40,000/year', '1000 USD',
    'Monthly', '10 months', NULL, false,
    36.1627, -86.7816
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    218, 'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program', 'Nashville, TN', NULL, 'Black Music Action Coalition (BMAC) and the Academy of Country Music (ACM)', 'BreatheWithMe, Steady',
    '6/1/2023 -', 'active', '20', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Black members of the music community', '$1,000',
    'Monthly', '12 Months', NULL, false,
    36.1627, -86.7816
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    219, 'Austin''s Guaranteed Income Pilot Program', 'Austin, TX', 'City of Austin and Travis County', 'City of Austin (including Austin Public Health, the Homeless Strategy Office, the Equity Office); Uptogether', NULL,
    'September 2022 - September 2023', 'concluded', '135', 'Public/Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Households with a  household income that is at or below 60% of the Area Median Family Income ($66,180 for a household of 4) and who meet at least one of the four other criteria: moving from homelessness toward permanent housing; have a filed eviction; household has been behind on rent for 2 or more months over the past year; and/or household has received a verbal or written notice of intent to evict OR a threat to vacate by landlord or property manager at any time within the past 3 months due to nonpayment of rent', '1000 USD',
    'Monthly', '12 months', NULL, true,
    30.2672, -97.7431
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    220, 'Central Texas 12-Month Pilot', 'Austin and Georgetown, TX', 'City of Austin zip codes: 78752, 78721, 78724, 78732, 78753 and City of Georgetown', 'UpTogether', NULL,
    'March 2021 - March 2022', 'concluded', '173', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Households that earn an income at or below 200% of the Federal Poverty Level at the time of enrollment and live in a targeted zip code in the City of Austin. Outreach was focussed on those who had experienced hardship due to COVID-19.', '$1,000',
    'Monthly', '12 months', NULL, false,
    30.2672, -97.7431
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    221, 'Dallas Targeted Eviction Prevention Program Fund', 'Dallas, TX', 'South Dallas', 'UpTogether', 'Carter’s House, CitySquare, For Oak Cliff, Harmony CDC, T.R. Hoover CDC, United Way of Metropolitan Dallas, Texas Women’s Foundation, the Boone Family Foundation, The Perot Family Foundation, The Muse Family Foundation, and the Louis B. and Mary Ratliff Fund of The Dallas Foundation  Carter’s House, CitySquare, For Oak Cliff, Harmony CDC, and T.R. Hoover CDC',
    'December 2021 - November 2024', 'concluded', '500', 'Private',
    'Individuals', 'Neighbourhood-level means testing', 'Households who have at least one child enrolled in a target school in South Dallas, Texas.', '3000',
    'Monthly', '12 months', NULL, false,
    32.7767, -96.797
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    222, 'UpTogether Morningside', 'Fort Worth, TX', NULL, 'UpTogether', 'Diverge, Rainwater Charitable Foundation',
    'January 2022 - January 2023', 'concluded', '30', 'Private',
    'Individuals', 'Individual/household means-testing and demographic', 'Families identified by a community organization that have at least one child enrolled in Morningside Elementary School in Fort Worth, Texas and are eligible for free/reduced price school lunch.', '265 USD',
    'Monthly', '12 months', NULL, false,
    32.7555, -97.3308
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    223, 'Houston Equity Fund', 'Houston, TX', NULL, 'The Houston Fund', 'MGI',
    'September 2022 - August 2023', 'concluded', '110', 'Individuals',
    NULL, 'Individual/household means-testing', 'Individuals at least 18 years old at the time of application, and have an income at or below the federal poverty level.', '375 USD',
    'Monthly', '12 months', NULL, true,
    29.7604, -95.3698
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    224, 'Rising UpTogether San Antonio', 'San Antonio, TX', NULL, 'UpTogether', 'The City of San Antonio, H. E. Butt Foundation, Methodist Healthcare Ministries, San Antonio Area Foundation',
    '4/1/2021 - 1/1/2023', 'concluded', '1,000', 'Public/Private',
    'Individuals/Families', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Individuals and families with household incomes below 150% of the federal poverty line', '$400',
    'Quarterly', '21 months', NULL, false,
    29.4241, -98.4936
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    225, 'San Antonio Basic Income Pilot', 'San Antonio, TX', '78207 or 78227 zip codes', 'UpTogether', 'University of Texas at San Antonio',
    'December 2020 - January 2023', 'concluded', '1000', 'Public/Private',
    'Households', 'Individual/household means-testing and demographic', 'Households with an income at or below 150% of the poverty level who live in the City of San Antonio in zip code 78207 or 78227, in a household of 4 - 8 people. The first 180 eligible households received the transfer.', 'Lump sum of 1,908 USD and 400 USD quarterly',
    'Quarterly', '24 months', 'Program offers a digital platform for families to give and take advice on navigating life and achieving their financial goals', false,
    29.4241, -98.4936
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    226, 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)', 'Texas and Illinois', NULL, 'OpenResearch', NULL,
    '11/1/2020 - 10/31/2023', 'concluded', '3,000', 'Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Individuals living in one of 19 study counties in Texas and Illinois who were aged 21 to 40, with total household income less than 300% of the federal poverty line (average annual household income of $29,900), not receiving SSI or living in public housing (to avoid risk of losing these key public benefits). Pilot was structured as a randomized controlled trial (RCT), with 1,000 individuals randomly assigned to the treatment group to receive $1,000 per month, and 2,000 individuals randomly assigned to the control group to receive $50 per month. Extensive data were collected with study results available at https://www.openresearchlab.org/projects/unconditional-cash-study.', '$1,000',
    'Monthly', '36 months', NULL, false,
    31.9686, -99.9018
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    227, 'Alexandria Recurring Income for Success and Equity (ARISE)', 'Alexandria, VA', 'Four zip codes (22312, 22311, 22304, 22305) within US Department of Housing and Urban Development ''qualified census tracts''', 'City of Alexandria, VA', 'GICP, Bruhn-Morris Family Foundation, Alexandria Department of Community and Human Services, Ideas42, MGI',
    'Feb 2023 - June 2025', 'concluded', '170', 'Public',
    'Individuals', 'Neighbourhood-level means-testing and individual/household means testing', 'Individuals making at or below 50% of the City''s Area Median Income', '500 USD',
    'Monthly', '24 months', 'Supportive resources offered by the City of Alexandria', true,
    38.8048, -77.0469
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    228, 'Arlington''s Guarantee', 'Arlington, VA', NULL, 'Arlington Community Foundation', 'GICP, Arlington County Dept. of Human Services, Urban Inst.',
    'September 2021 - December 2022', 'concluded', '200', 'Private',
    'Households', 'Individual/household means-testing and demographic', '2nd generation households below 30% area median income and enrolled in local housing program', '500 USD',
    'Monthly', '18 months', NULL, true,
    38.8799, -77.1068
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    229, 'Fairfax County Economic Mobility Pilot (FCEMP)', 'Fairfax, VA', NULL, 'Fairfax Neighborhood and Community Services', NULL,
    '10/1/2023 - January 2026', 'concluded', '180', 'Public/Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'Asset-limited, income-constrained, employed population, that earn more than the Federal Poverty Level, but less than the basic cost of living for county/state in which they live', '$750',
    'Monthly', '15 Months', NULL, false,
    38.8462, -77.3064
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    230, 'Richmond Resilience Initiative (RRI)', 'Richmond, VA', NULL, 'City of Richmond Office of Community Wealth Building', 'UpTogether, MGI, CGIR',
    'October 2020 - May 2024', 'concluded', 'Two cohorts totaling 64 individuals', 'Public/Private',
    'Individuals', 'Individual/household means-testing', 'Currently reside in the city of Richmond, Virginia; employed and earning over $12.71 per hour (the full-time wage federal benefits threshold); have children under the age of 18 living in the household; and not receiving federal benefits, including housing vouchers or assistance.', '500 USD',
    'Monthly', '24 months', 'financial education', false,
    37.5407, -77.436
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    231, 'Spectrum Pilots Direct Cash Transfer Program', 'Burlingame, VT', NULL, 'Spectrum Youth & Family Services', NULL,
    '8/1/2023 - 1/1/2025', 'concluded', '10', 'Private',
    'Individuals', 'Demographic targeting (individuals who belong to a demographic group)', 'Youth facing homelessness or at immediate risk of homelessness', '$750',
    'Bi-weekly', '18 months', NULL, false,
    44.4759, -73.2121
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    232, 'King County GBI Pilot', 'King County, WA', NULL, 'Workforce Development Council of Seattle-King County', 'Washington State Employment Security Department, King County government, JPMorgan Chase, various community-based organizations',
    '12/1/2022 - 12/1/2024', 'concluded', '102', 'Public/Private',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Ranging from people with low-income to students and justice-involved adults', '$500',
    'Monthly', '10 Months', NULL, false,
    47.548, -121.9836
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    233, 'South King County Pilot', 'King County, WA', 'South King County', 'Rainier Beach Action Coalition and Urban Family', NULL,
    '11/1/2022 - 8/1/2023', 'concluded', '10', 'Public',
    'Individuals', 'Individual means test', 'Extremely low-income families residing in King County District 2', '$500',
    'Monthly', '10 months', NULL, false,
    47.548, -121.9836
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    234, 'Hummingbird Nest', 'King County, Pierce County, and Tulalip Reservation, WA', NULL, 'Hummingbird Indigenous Family Services', NULL,
    '8/1/2023 -', 'active', '150', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'At least 12 weeks pregnant and planning to parent, Indigenous to North America/Pacific Islander Living in: King County, Pierce County, or the Tulalip Reservation. King County Income under: $70k for a 2 person household* $85k for a 3 person household* $100k for a 4+ person household*, Pierce County Income under: $55k for a 2 person household* $70k for a 3 person household* $85k for a 4+ person household*', '$1,250',
    'Monthly', '36 Months', NULL, false,
    47.548, -121.9836
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    235, 'Olympic Community Action Programs GBI Pilot', 'North Olympic Peninsula, WA', NULL, 'Olympic Community Actions Programs', NULL,
    '1/1/2022 - 6/1/2023', 'concluded', '25', 'Private',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Families enrolled in the sponsor organization''s early childhood services programs', '$500',
    'Monthly', '12 months', NULL, false,
    48.1172, -123.4307
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    236, 'Seattle-Denver Income Maintenance Experiment (SIME/DIME)', 'Seattle, WA', NULL, 'Stanford Research Institute', NULL,
    '1971  - 1982', 'concluded', '4800', 'Public',
    'Households', 'Individual/household means-testing and demographic', 'Families with income less than $9000 USD if one head of household was employed and less than $11,000 USD if both employed, with even number of white, black and Mexican-American households selected (last group only in Denver, CO)', '316, 400 or 466 USD',
    'Monthly', NULL, NULL, true,
    47.6062, -122.3321
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    237, 'Growing Resilience in Tacoma (GRIT)', 'Tacoma, WA', 'Eastside (98404), Hilltop (98405), South Tacoma (98409), South End (98408)', 'City of Tacoma', 'CIGR, MGI, United Way of Pierce County',
    'December 2021 - November 2022', 'concluded', '110', 'Private',
    'Individuals', 'Demographic and means-testing', 'Single parent or guardian households with children in eligible zip codes, asset limited and income constrained', '500 USD',
    'Monthly', '12 months', NULL, true,
    47.2529, -122.4443
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    238, 'Madison Guaranteed Income Pilot Program (Madison Forward Fund)', 'Madison, WI', NULL, 'TASC Madison', 'MGI, Give Back Foundation, IInstitute for Research on Poverty at UW-Madison, CGIR',
    'Sept 2022 - Aug 2023', 'concluded', '155', 'Private',
    'Households', 'Individual/household means-testing and demographic', 'Individuals 18 and older with a household income less than 200% of the Federal Poverty Line, and with a child under 18 years old living at home.', '500 USD',
    'Monthly', '12 months', NULL, true,
    43.0731, -89.4012
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    239, 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia', 'Mercer County, WV', NULL, 'Rural GMI Initiative', 'GiveDirectly, the Atwoods, OpenResearch',
    '10/14/2025 -', 'active', 'About 530', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'Residents of the participating county, age 18 or older, with household income at or below 200% of the Federal Poverty Level. Program implemented in Mercer County, West Virginia; Beaufort Couny, NC; and Warren County, Mississippi, with about 1,600 participants planned in total across the three sites. Evaluation conducted by OpenResearch.', '$1,500',
    'Monthly', '16 months', NULL, false,
    37.4, -81.11
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    240, 'Basic Income for Care Leavers', 'Wales, UK', NULL, 'Welsh Government', NULL,
    '07/01/22 - 6/30/2025', 'concludd', 'Expected 500 young people are eligible', 'Public',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Identification with a demographic group (e.g. age, gender identity, race)', 'Individuals leaving government care turning 18 between a timeframe of 12 months (1 July 2022 and 30 June 2023)', '1600 GPB',
    'Monthly', '24 months', NULL, false,
    52.1307, -3.7837
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    241, 'Eight Fort Portal Project', 'Busibi, Uganda', NULL, NULL, 'Ghent University',
    '2017 - 2019', 'concluded', '123 adults and  217 children', 'Private',
    'Individuals', 'No criteria', 'Participants randomly selected', '18.25 USD for adults and 9.13 USD for children',
    'Monthly', '24 months', NULL, false,
    0.6928, 30.2789
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    242, 'Novissi', 'Togo', NULL, 'Government of Togo', 'Giver Directly; UC Berkeley (Center for Effective Global Action); Northwestern University (Global Poverty Research Lab); the University of Mannheim; Innovations for Poverty Action',
    'August 2020 -', 'active', '819,972', 'Public/Private',
    'Individuals or households', 'Individual/household means-testing', 'Individuals who hold a voter ID card and are informal workers whose livelihoods were impacted by COVID-19.', '64.70 USD for women and 19.41 USD for men',
    'Bi-monthly', NULL, NULL, false,
    8.6195, 0.8248
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    243, 'B-MINCOME', 'Barcelona, Spain', 'Nou Barris, Sant Andreu and Sant Martí', 'City of Barcelona', 'Catalan Institute of Evaluation of Public Policies; NOVACT - International Institute for Nonviolent Action; Institute of Government and Public Policies; The Young Foundation; Data Management Group, alongside ICTA - Institute of Environmental Science and Technology',
    'October 2017 - December 2019', 'concluded', '1000', 'Public',
    'Individuals', 'Geographic and individual/household means-testing and demographic', 'Individuals randomly selected from three of the cities poorest districts', '100 - 1675 EU',
    'Monthly', '24 months', 'Half of selected participants also participated in active inclusion policies (training and employment; fostering entrepreneurship in the social, solidarity and cooperative economy; grants for refurbishing flats in order to rent out rooms; and, community participation)', true,
    41.3851, 2.1734
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    244, 'Basic Income for Farmers', 'Gyeonggi Province, Republic of Korea (South Korea)', NULL, 'Gyeonggi Provincial Government', NULL,
    'October 2021 -', 'active', '430,000', 'Public',
    'Individuals', 'Demographic', 'Farmers who have had an address in the targeted cities for 3 consecutive years or 10 non-consecutive years, and has farmland or has been engaged in agricultural production', '250,000 Won (~212 USD)',
    'Quarterly', '12 months', NULL, false,
    37.4138, 127.5183
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    245, 'Youth Basic Income Program', 'Gyeonggi Province, Republic of Korea (South Korea)', NULL, 'Gyeonggi Provincial Government', 'Gyeonggi Research Group',
    '2018 -', 'active', '125,000', 'Public',
    'Individuals', 'Demographic', 'Individuals receive the transfer at 24 years of age', '250,000 Won (~212 USD)',
    'Quarterly', '12 months', NULL, false,
    37.4138, 127.5183
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    246, 'Seoul Stepping Stone Income Project (SSIP)', 'Seoul, Republic of Korea (South Korea)', NULL, 'Seoul Metropolitan Government', 'Seoul Welfare Foundation',
    '- Phase 1: July 2022 – June 2025 / 3 years

- Phase 2: July 2023 – June 2025 / 2 years', 'concluded', 'Phase 1: 500 households (control group: 1,000 households) ; 

Phase 2: 1,100 households (control group: 2,200 households)', 'Public',
    'Households', 'Households that meet an income cut-off', '- Phase 1: households earning at or below 50% of the standard median income and with KRW 326 million ($272,803 USD) or less in assets;

Phase 2: households earning at or below 85% of the standard median income and holding - KRW 326 million ($272,803 USD) or less in assets', 'Phase 1: randomly select 500 households with income at or below 50% of the standard median income receive half of the difference between the threshold and the household’s income as a monthly payment;

Phase 2: randomly select 1,100 households with income at or below 85% of the standard median income receive half of the difference between the threshold and the household’s income as a monthly payment  

Monthly payment = (85% of standard median income – current household income) x 0.5 – allowance for livelihood and housing cash benefits / 85% of the standard median income household size (2023) : 1-person household (1,766,208 KRW / 1,374 USD) / 4-person household : 4,590,819 KRW / 3,573 USD)',
    'Monthly', '35 months', NULL, true,
    37.5665, 126.978
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    247, 'Social Income Sierra Leone', 'Sierra Leone', NULL, 'Social Income', 'Aurora, Jamil & Nyanga Jaward, Reachout Salone, Equal Rights Alliance, Polio B&S Organisation, Freetown City Council',
    NULL, 'concluded', '146', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code), Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', NULL, '30 USD',
    'Monthly', '36 months', NULL, false,
    8.4606, -11.7799
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    248, 'Weten wat werkt', 'Utrecht, Netherlands', NULL, 'City of Utrecht', 'Utrecht University',
    '06/01/18 - 10/01/19', 'concluded', '752', 'Public',
    'Individuals', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold), Program participation (e.g. identification through program or service, however eligibility not contingent on ongoing participation)', 'All participants had to be eligible for social assistance in the city of Utrecht', 'Up to 202 EUR',
    'Monthly', NULL, NULL, true,
    52.0907, 5.1214
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    249, 'Basic Income Grant (BIG) Pilot', 'Otjivero-Omitara, Namibia', NULL, 'Namibian Big Coalition (Council of Churches, Namibian Union of Namibian Workers, Namibian NGO Forum and the Namibian Network of AIDS Service Organisations)', NULL,
    'January 2008 - January 2009', 'concluded', '930', 'Public/Private',
    'Individuals', 'Geographic and demographic', 'All individuals in village under 60', '100 NAD',
    'Monthly', '12 months', NULL, false,
    -22.35, 17.9833
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    250, 'Human Development Fund', 'Mongolia', NULL, 'Government of Mongolia', NULL,
    '2010 - 2012', 'concluded', '~2.7 million', 'Public',
    'Individuals', 'No criteria', NULL, '86 USD (February 2010). Between August to December 2010 7.42 USD/month, and of 16.57 USD/month between January 2011 to June 2012.',
    'Mix of monthly and lump sum', NULL, NULL, false,
    46.8625, 103.8467
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    251, 'Liberia Basic Income', 'Maryland County, Liberia', NULL, 'GiveDirectly', NULL,
    'July 2022 - February 2026', 'concluded', '10,987', 'Private',
    'Households', 'None', 'All individuals in target villages receive payment', '408 USD',
    'Annualy', '54 months', 'Mix of monthly and quarterly payments', true,
    4.6333, -7.8333
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    252, 'Basic Income Kenya Study', 'Western and Rift Valley, Kenya', NULL, 'Give Directly', 'Innovations for Poverty Action; Abdul Latif Jameel Poverty Action Lab (MIT)',
    '01/2017 - 12/2030', 'active', '20,847', 'Private',
    'Individuals', 'No criteria', 'All individuals in targeted villages', '1. $0.75 US per day (44 villages for 12 years)
2. $0.75 US per day (80 villages for 2 years)
3. 8548 US total lump sum at start equal in net present value as group 2 (71 villages)',
    'Monthly or lump sum', '2 or 12 years', NULL, false,
    0.1769, 35.7478
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    253, 'Give Directly', 'Rarieda District, Kenya', NULL, 'Give Directly', 'Princeton; Busara Center for Behavioral Economics Innovations for Poverty Action; Abdul Latif Jameel Poverty Action Lab (MIT)',
    '2011 - 2013', 'concluded', '503', 'Private',
    'Households', 'Individual/household means-testing', 'Households in target villages that had a thatched roof (means-tested)', '258 households received monthly transfers (45 USD/month for 9 months); 245 received lump-sum transfer (initial 19 USD followed by 384 USD). In addition, 137 randomly chosen households (either previously receiving monthly or lump sum payment) received 260 USD/month for 7 months.',
    'Monthly or lump sum', '16 months', NULL, true,
    -0.1667, 34.3333
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    254, 'Maezawa Method Basic Income Social Experiment', 'Japan', NULL, 'Yusaku Maezawa', NULL,
    NULL, 'concluded', '500  Lump sum recepients, 500 monthly payment recepients', 'Private',
    'Individuals', 'No eligibility or targeting criteria', 'Individuals were selected amongst the Twitter Followers of Japanese billionaire Yusaku Maezawa', '~750 USD (1,000,000 Yen for the entire year)',
    'Monthly', '12 months', NULL, false,
    36.2048, 138.2529
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    255, 'Reddito di Cittadinanza', 'Livorno, Italy', NULL, 'City of Livorno', NULL,
    '06/01/16 - 12/31/2016', 'concluded', '100', 'Public',
    'Households', 'Individual or household means-testing (e.g. all individuals who meet an income cut-off or threshold)', 'Income was distributed amongst 100 of the poorest families of Livorno', '500 EUR',
    'Monthly', NULL, NULL, false,
    43.5485, 10.3106
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    256, 'Basic Income for the Arts', 'Ireland', NULL, 'Irish Government', 'Department of Tourism, Culture, Arts, Gaeltacht, Sport and Media',
    '10/01/22 - 10/01/25', 'concluded', '2000', 'Public',
    'Individuals', 'Labor participation (program contingent on being an artist)', '2000 individuals were selected from a pool of 8200 applicants to the program', '€325',
    'Weekly', '12 months', NULL, true,
    53.4129, -8.2439
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    257, 'Targeted Subsidies Reform Act', 'Iran', NULL, 'Islamic Republic of Iran', NULL,
    '2010 -', 'active', '~ 75 million', 'Public',
    'Individuals', 'Individual/household means-testing', NULL, '4 USD (transfers amount to 29% median household income)',
    'Monthly', NULL, NULL, false,
    32.4279, 53.688
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    258, 'Jamesta Istimewa', 'Yogyakarta, Indonesia', NULL, 'Yanu Endar Prasetyo (IndoBIG Network & Research Center for Population BRIN)', 'CEOs of Kita Bisa (M. Al Fatih Timur) and M. Faiz Ghifari (Strategic Initiatives Kitabisa.com)',
    '11/01/21 - 04/01/22', 'concluded', '25', 'Private',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', NULL, '500000 IDR',
    'Monthly', '12 months', NULL, false,
    -7.7956, 110.3695
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    259, 'Madhya Pradesh Unconditional Cash Transfers Project', 'Madhya Pradesh, India', NULL, 'UNICEF and the Self Employed Women’s Association (SEWA)', 'India Development Foundation',
    'June 2011 - November 2012', 'concluded', '5,547 in general village pilot of 20 villages and 756 in tribal village pilot', 'Private',
    'Individuals', 'Geographic', 'All residents in pilot villages eligible', '100 RS for children and 200 RS for adults (Y1), and 150 RS for children and 300 RS for adults (Y2).',
    'Monthly', '18 months for general pilot and 12 months for tribal pilot', NULL, true,
    22.9734, 78.6569
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    260, 'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra', 'Domti, Navadkya and Burkhet in Shelkui Village, Dhadgaon District of Nandurbar, Maharashtra State, India', NULL, 'Project DEEP', 'Yung Foundation',
    '5/1/2024 - 5/1/2025', 'concluded', '102', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'The program was implemented in 3 hamlets in Shelkui Village (Domti, Navadkya and Burkhet) which are inhabited by the Pawara, an Adivasi community, designated as a Scheduled Tribe. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups.  These hamlets were chosen based on a few parameters of stressors and opportunities. In Shelkui, while most of the population engages in farming, they grow consumption crops. The main source of income is through migration for men, and in some cases women as well. Migration is largely for unskilled farm labour, and in some cases for other labour like construction. Only 2% of the population have their own enterprise, and 5% have a stable permanent income. Funds were disbursed through the bank accounts of women, targeting 102 households that included 508 people.', 'INR 65,000 or USD 775',
    'Lump sum', '12 months', NULL, false,
    21.82, 74.22
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    261, 'Building Up Lives | Lumpsum Transfers', 'Krishnapur Village, in Wardha District, Arvi Taluka, Maharashtra State, India', NULL, 'Project DEEP', 'DJED Foundation',
    '5/1/2023 - 4/30/2024', 'concluded', '50', 'Private',
    'Households', 'Geographic and individual/household means-testing and demographic', 'This is a universal program, with all households in the selected hamlet receiving the lump sum amount. Krishnapur is a village inhabited by the Kolams, an Adivasi community, designated as a Scheduled Tribe and categorized as particularly vulnerable. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups. This village was chosen based on a few parameters of stressors and opportunities. There is an acute paucity of money in households, given their dependence on uncertain income cycles. The people of Krishnapur are skilled in their own trades of agriculture, farm labour and livestock rearing, and are ambitious about the next generation''s prospects. Most people work multiple jobs, farming on their own land and on another’s to earn a daily wage. Some people pursue courses in nearby villages, tend to the livestock in the community and look for opportunities to set up enterprises. Despite this, their earning capacity is constrained due to the inability to invest in their latent potential and available opportunities. There is additional uncertainty due to the weather linked income cycles. At the time of the baseline, the average net income was INR 76,952 (~USD 900) for a family of 4. This is barely enough to cover the costs and spend on their routine needs. Over time, this has resulted in unhealthy and compounded debt cycles, which people are now trapped in. This inhibits their ability to conduct regular activities at full potential, making risk taking and income diversification endeavours non-existent. These factors cause an acute paucity of funds at a family and local economy level. Annual assessment report available at https://drive.google.com/file/d/1_Ds-cCD_q8bymCxjPdRX_6hPIIzVQtiU/view.', 'INR 65,000 or USD 775',
    'Lump sum', NULL, NULL, false,
    20.7453, 78.6022
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    262, 'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan', 'Amali Phala, Mana Mangari and Kadiya Mangari, Sada Village, Dungarpur District, Rajasthan State, India', NULL, 'Project DEEP', 'Shram Sarathi',
    '12/1/2023 - 12/1/2024', 'concluded', '112', 'Private',
    'Households', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'Sada is a village inhabited by the Meena community, designated as a Scheduled Tribe and categorized as particularly vulnerable. Scheduled Tribes are designated groups of indigenous communities recognized by the Government of India for special protection and assistance since they are among the most disadvantaged socioeconomic groups. This village was chosen based on a few parameters of stressors and opportunities. Everyone grows consumption crops, like wheat, maize and rice. 73% of the families are dependent on circular migration for their income with one or more members working in nearby cities for a few months. The common occupations are helpers or cooks at a tea or snacks stall, working in a kirana or clothes store, domestic help or daily wage at construction sites and other odd jobs. The net average annual income for a family of fifive is INR 75,336 (~USD 900). This is barely enough to cover the costs and spend on their routine needs. The program was implemented in 3 hamlets in Sada Village (Amali Phala, Mana Mangari & Kadiya Mangari). Funds were disbursed through the bank accounts of women, targeting 112 households that included 505 people. Assessment report is available at https://drive.google.com/file/d/1pV9aLEaZ2eJaEtsNr3vGlO2dbb3vfpZ3/view.', 'INR 65,000 or USD 775',
    'Lump sum', '12 months', NULL, false,
    23.8431, 73.7147
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    263, 'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme)', 'Tamil Nadu, India', NULL, 'Tamil Nadu State Government', NULL,
    NULL, 'active', 'Expected up to 10,000,000 women', 'Public',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'Not disclosed yet, but government has suggested financial targetting towards the poorest women in Tamil Nadu', '1000 INR',
    'Monthly', NULL, NULL, false,
    11.1271, 78.6569
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    264, 'Basic Income & Care for Transgender Persons', 'Hyderabad, India', NULL, 'Anveshi', 'India Network for Basic Income (INBI) and American Jewish World Service (AJWS).',
    NULL, 'concluded', NULL, 'Private',
    'Individuals', 'Identification with a demographic group (e.g. age, gender identity, race)', NULL, NULL,
    'Monthly', '12 months', 'The program also provides ''a safe space for caring and sharing through the monthly Care Workshops in order to promote and bring to conversation self-care practices for individual participants, and in the process also co-create a community of care''', false,
    17.385, 78.4867
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    265, 'UBI+', 'Hyderabad, India', NULL, 'WorkFree', 'University of Bath, The India Network for Basic Income (INBI) Foundation, The Montfort Social Institute (MSI), IWWAGE, openDemocracy',
    NULL, 'concluded', '1250', 'Public',
    'Individuals', 'Geographic means-testing (e.g. all resident in an eligible geographic area, such as a census tract or zip-code)', 'Not a condition, but ''almost all [participants] make their living from waste picking or domestic service''', '1000 INR for adults, 500 INR for children (paid to a parent)',
    'Monthly', '18 months', 'All participants ''will receive community organising support for 24 months''', false,
    17.385, 78.4867
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    266, 'My Basic Income', 'Germany', NULL, 'Mein Grundeinkommen e.V.', NULL,
    NULL, 'active', '1464', 'Private, Raffle',
    'Individuals', 'Individuals registered for a raffle', NULL, '1200 euros',
    'Monthly', '12 months', NULL, false,
    51.1657, 10.4515
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    267, 'Pilotprojekt Grundeinkommen', 'Germany', NULL, 'German Institute for Economic Research (DIW Berlin)', 'Mein Grundeinkommen',
    'June 2021 - May 2024', 'concluded', '122', 'Private',
    'Individuals', 'No criteria', 'Participants randomly selected', '1200 EU',
    'Monthly', '36 months', NULL, true,
    51.1657, 10.4515
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    268, 'Finland Basic Income Experiment', 'Finland', NULL, 'Kela and Ministry of Health and Social Affairs', NULL,
    'January 2017 - December 2018', 'concluded', '2000', 'Public',
    'Individuals', 'Demographic', 'Random selection from all individuals between ages of 25 and 58 for whom Kela paid a labour market subsidy or basic unemployment allowance in November 2016 for some other reason than a temporary layoff', '560 EU',
    'Monthly', '24 months', NULL, true,
    61.9241, 25.7482
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    269, 'Wealth Partaking Scheme', 'Macau Special Administrative Region, China', NULL, 'Government of Macau', NULL,
    '2008 -', 'active', '638,300 permanent residents and 62,000 non-permanent residents', 'Public',
    'Individuals', 'No criteria', NULL, '1,150 USD (permanent residents); 750 USD non-permanent residents',
    'Yearly', NULL, NULL, false,
    22.1987, 113.5439
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    270, 'Scheme $6,000', 'Hong Kong, China', NULL, 'Government of Hong Kong', NULL,
    '2011', 'concluded', '~4 million', 'Public',
    'Individuals', 'Demographic', 'Individuals 18 years and older with Hong Kong permanent identity cards', '6000 HK',
    'Lump sum', NULL, NULL, false,
    22.3193, 114.1694
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    271, 'New Leaf Project', 'Vancouver, BC, Canada', NULL, 'Foundations for Social Change', 'University Of British Columbia',
    '2018 - 2019', 'concluded', '50', 'Public/Private',
    'Individuals', 'Demographic', 'Individuals 19 and older who had recently been homeless', '7500 USD',
    'One time', NULL, 'Series of workshops involving the development of a personal plan and self-affirmation exercises. Select participants offered coaching for a period of 6 months to support developing life skills and strategies', true,
    49.2827, -123.1207
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    272, 'Agreements with Young Adults', 'British Columbia, Canada', NULL, 'Government of BC', NULL,
    'March 2022 -', 'active', 'Any individual transitioning out of care', 'Public',
    'Individuals', 'Demographic', 'Individuals 19-26 in care on their 19th birthday', '1250 CAD',
    'Monthly', '12 months', 'Youth will also be eligible to receive a $600/month rent supplement and increased access to counselling, medical benefits and life-skills programming', false,
    53.7267, -127.6476
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    273, 'Manitoba Basic Annual Income Experiment (MINCOME)', 'Dauphin, MB, Canada', NULL, 'Province of Manitoba', 'Government of Canada',
    '1976 - 1978', 'concluded', '2263', 'Public',
    'Households', 'Individual/household means-testing', 'Households with head of household under 57 years of age with an average yearly income less than $13,000 in Winnipeg and 9,000 in Dauphin. Households with a disabled adult, one more more heads in armed forces, mentally incompetent and who were unable to complete surveys due to language barriers ineligible to participate', '316 - 483 CAD',
    'Monthly', NULL, NULL, true,
    51.1494, -100.0494
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    274, 'Manitoba Basic Annual Income Experiment (MINCOME)', 'Winnipeg, MB, Canada', NULL, 'Province of Manitoba', 'Government of Canada',
    '1975 - 1978', 'concluded', '2263', 'Public',
    'Households', 'Individual/household means-testing', 'Households with head of household under 57 years of age with an average yearly income less than $13,000 in Winnipeg and 9,000 in Dauphin. Households with a disabled adult, one more more heads in armed forces, mentally incompetent and who were unable to complete surveys due to language barriers ineligible to participate', '316 - 483 CAD',
    'Monthly', NULL, NULL, true,
    49.8951, -97.1384
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    275, 'Ontario Basic Income Pilot', 'Hamilton, Brantford, Brant County, ON, Canada', NULL, 'Government of Ontario Ministry of Children, Community and Social Services', 'St. Michael''s Hospital, McMaster University',
    '2017 - 2018', 'concluded', '2748', 'Public',
    NULL, 'Individual/household means-testing', 'Individuals between 18-64', '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD',
    'Annual', '12 months', NULL, true,
    43.2557, -79.8711
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    276, 'Ontario Basic Income Pilot', 'Lindsay, ON, Canada', NULL, 'Government of Ontario Ministry of Children, Community and Social Services', 'St. Michael''s Hospital, McMaster University',
    '2019 - 2018', 'concluded', '1844', 'Public',
    NULL, 'Individual/household means-testing', 'Individuals between 18-65', '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD',
    'Annual', '12 months', NULL, true,
    44.3546, -78.7409
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    277, 'Ontario Basic Income Pilot', 'Thunder Bay, ON, Canada', NULL, 'Government of Ontario Ministry of Children, Community and Social Services', 'St. Michael''s Hospital, McMaster University',
    '2018 - 2018', 'concluded', '1908', 'Public',
    NULL, 'Individual/household means-testing', 'Individuals between 18-65', '16,989 CAD for a single person less 50% of any earned income
24,027 CAD for a couple, less 50% of any earned income
Persons with disabilities receive an additional 500 CAD',
    'Annual', '12 months', NULL, true,
    48.3809, -89.2477
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    278, 'Renda Basica de Cidadania (Citizens'' Basic Income Program)', 'Maricá, Brazil', NULL, 'Municipal Government of Maricá', 'Jain Family Institute; Universidade Federal Fluminense',
    'December 2019 -', 'active', '42,000', 'Public',
    'Individuals', 'Individual/household means-testing', 'Individuals who are part of Brazil''s Cadastro Único, a unified registry for social benefits', '130 Mumbuca, a currency spendable only within the Municipality of Marica',
    'Monthly', NULL, NULL, false,
    -22.9194, -42.8186
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;

INSERT INTO public.stanford_experiments (
    id, name, location, neighborhood, managing_orgs, other_affiliations,
    implementation_dates, implementation_status, total_participants, type_of_funding,
    participants_receiving, type_of_targeting, targeting_details, transfer_amount,
    frequency_of_payment, duration_of_payment, other_intervention_components, is_rct,
    latitude, longitude
) VALUES (
    279, 'Quatinga Velho', 'Mogi das Cruzes, Brazil', 'Quatinga Velho', 'Instituto ReCivitas', NULL,
    '2008 - 2014', 'concluded', '100', 'Private',
    'Individuals', 'Individual/household means-testing', NULL, '30 Reais',
    'Monthly', NULL, NULL, false,
    -23.5205, -46.1854
) ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    location = EXCLUDED.location,
    neighborhood = EXCLUDED.neighborhood,
    managing_orgs = EXCLUDED.managing_orgs,
    other_affiliations = EXCLUDED.other_affiliations,
    implementation_dates = EXCLUDED.implementation_dates,
    implementation_status = EXCLUDED.implementation_status,
    total_participants = EXCLUDED.total_participants,
    type_of_funding = EXCLUDED.type_of_funding,
    participants_receiving = EXCLUDED.participants_receiving,
    type_of_targeting = EXCLUDED.type_of_targeting,
    targeting_details = EXCLUDED.targeting_details,
    transfer_amount = EXCLUDED.transfer_amount,
    frequency_of_payment = EXCLUDED.frequency_of_payment,
    duration_of_payment = EXCLUDED.duration_of_payment,
    other_intervention_components = EXCLUDED.other_intervention_components,
    is_rct = EXCLUDED.is_rct,
    latitude = EXCLUDED.latitude,
    longitude = EXCLUDED.longitude;


-- 4. Cross-Reference and Augment Matched Programs in public.programs
-- Set default data_source for existing community records
UPDATE public.programs SET data_source = 'community_submission' WHERE data_source IS NULL;

-- Match: Alaska Permanent Fund Dividend 2026
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Alaska Permanent Dividend Fund' LIMIT 1),
    total_participants = '667,047',
    is_rct = false
WHERE name = 'Alaska Permanent Fund Dividend 2026';

-- Match: Basic Income for the Arts Scheme 2026-2029
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income for the Arts' AND location = 'Ireland' LIMIT 1),
    total_participants = '2,000',
    is_rct = true
WHERE name = 'Basic Income for the Arts Scheme 2026-2029';

-- Match: Camp Harbor View Guaranteed Income Program
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Camp Harbor View Guaranteed Income Pilot' LIMIT 1),
    total_participants = '50',
    is_rct = true
WHERE name = 'Camp Harbor View Guaranteed Income Program';

-- Match: Cook County Promise Guaranteed Income Program — Next Phase
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Cook County Promise Guaranteed Income' LIMIT 1),
    total_participants = '3,250',
    is_rct = false
WHERE name = 'Cook County Promise Guaranteed Income Program — Next Phase';

-- Match: Evanston Guaranteed Income Program 2026
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income Pilot Program' AND location = 'Evanston, IL' LIMIT 1),
    total_participants = '165',
    is_rct = true
WHERE name = 'Evanston Guaranteed Income Program 2026';

-- Match: GiveDirectly 12-Year Universal Basic Income Study
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Basic Income Kenya Study' LIMIT 1),
    total_participants = '20,847',
    is_rct = true
WHERE name = 'GiveDirectly 12-Year Universal Basic Income Study';

-- Match: Guaranteed Income for Artists
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Guaranteed Income for Artists' AND location = 'St. Paul, MN' LIMIT 1),
    total_participants = '25',
    is_rct = false
WHERE name = 'Guaranteed Income for Artists';

-- Match: Gyeonggi Youth Basic Income
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Youth Basic Income Program' LIMIT 1),
    total_participants = '125,000',
    is_rct = false
WHERE name = 'Gyeonggi Youth Basic Income';

-- Match: Macao Wealth Partaking Scheme 2026
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Wealth Partaking Scheme' LIMIT 1),
    total_participants = '700,000+',
    is_rct = false
WHERE name = 'Macao Wealth Partaking Scheme 2026';

-- Match: Mein Grundeinkommen Basic Income Raffle
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'My Basic Income' LIMIT 1),
    total_participants = '1,464',
    is_rct = false
WHERE name = 'Mein Grundeinkommen Basic Income Raffle';

-- Match: One Family Philadelphia Guaranteed Income Financial Treatment Pilot
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)' LIMIT 1),
    total_participants = '100',
    is_rct = false
WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment Pilot';

-- Match: PHLHousing+
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'PHLHousing+' LIMIT 1),
    total_participants = '300',
    is_rct = true
WHERE name = 'PHLHousing+';

-- Match: Preserving Our Diversity
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name LIKE 'Preserving Our Diversity%' LIMIT 1),
    total_participants = '463',
    is_rct = false
WHERE name = 'Preserving Our Diversity';

-- Match: Programa de Renda Básica de Cidadania de Maricá
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Renda Basica de Cidadania (Citizens'' Basic Income Program)' LIMIT 1),
    total_participants = '42,000',
    is_rct = false
WHERE name = 'Programa de Renda Básica de Cidadania de Maricá';

-- Match: Rx Kids
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Rx Kids' LIMIT 1),
    total_participants = '10,000+',
    is_rct = false
WHERE name = 'Rx Kids';

-- Match: Sacramento Creative Growth Fellowship Program
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'Creative Growth Fellowship' LIMIT 1),
    total_participants = '200',
    is_rct = false
WHERE name = 'Sacramento Creative Growth Fellowship Program';

-- Match: The Bridge Project
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name = 'The Bridge Project' LIMIT 1),
    total_participants = '600',
    is_rct = true
WHERE name = 'The Bridge Project';

-- Match: The Magnolia Mother’s Trust
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name LIKE 'Magnolia Mother%' LIMIT 1),
    total_participants = '100',
    is_rct = false
WHERE name = 'The Magnolia Mother’s Trust';

-- Match: Thriving Providers Project — Pittsburgh
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name LIKE 'Thriving Providers%' LIMIT 1),
    total_participants = '100',
    is_rct = false
WHERE name = 'Thriving Providers Project — Pittsburgh';

-- Match: Seoul Youth Allowance
UPDATE public.programs
SET data_source = 'stanford_basic_income_lab',
    stanford_experiment_id = (SELECT id FROM public.stanford_experiments WHERE name LIKE 'Seoul Stepping Stone%' LIMIT 1),
    total_participants = '1,600',
    is_rct = true
WHERE name = 'Seoul Youth Allowance';
