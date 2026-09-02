-- Migration 00022: Ingest Universal Child Allowances, Basic Pensions, and Demogrants

-- Adds well-established nationwide universal cash transfer programs (Germany, Norway, Denmark, UK, Ireland, NZ, Mauritius, Sweden, Finland, etc.)


INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    382,
    'Kindergeld (Universal Child Allowance)',
    'Federal Central Tax Office (Familienkasse / BZSt)',
    'Kindergeld is Germany''s foundational universal cash allowance paid unconditionally to parents for every child from birth up to age 18 (and up to age 25 if enrolled in higher education or vocational training), regardless of parental income or employment status. Disbursed monthly to guarantee baseline child subsistence.',
    280,
    'EUR',
    '€255 per child monthly (~$280 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Germany'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    51.1657,
    10.4515,
    0,
    18,
    NULL,
    NULL,
    '18,000,000+ children',
    'Universal for all resident children and parents in Germany',
    FALSE,
    'community_submission',
    'https://www.arbeitsagentur.de/familie-und-kinder/infos-rund-um-kindergeld',
    ARRAY['https://www.arbeitsagentur.de/familie-und-kinder/infos-rund-um-kindergeld', 'https://www.bzst.de/EN/Private_individuals/Kindergeld/kindergeld_node.html'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Kindergeld (Universal Child Allowance)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    383,
    'Barnetrygd (Universal Child Benefit)',
    'Norwegian Labour and Welfare Administration (NAV)',
    'Barnetrygd is Norway''s universal child benefit providing a non-means-tested, tax-free cash transfer for every child under 18 residing in Norway. Payouts are made monthly directly into parents'' bank accounts to support childhood development and alleviate child poverty universally.',
    165,
    'NOK',
    '1,766 NOK per child monthly (~$165 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Norway'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    60.472,
    8.4689,
    0,
    18,
    NULL,
    NULL,
    '1,100,000+ children',
    'Universal for all resident children in Norway',
    FALSE,
    'community_submission',
    'https://www.nav.no/barnetrygd',
    ARRAY['https://www.nav.no/barnetrygd', 'https://www.norden.org/en/info-norden/child-benefit-norway'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Barnetrygd (Universal Child Benefit)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    384,
    'Børne- og ungeydelse (Family / Youth Allowance)',
    'Udbetaling Danmark / Danish Ministry of Taxation',
    'Børne- og ungeydelse is Denmark''s universal tax-free cash benefit disbursed automatically to parents of all children under 18 living in Denmark. The benefit is completely non-means-tested at baseline, scaled slightly by child age cohort, and delivered quarterly or monthly.',
    230,
    'DKK',
    '~1,600 to 4,900 DKK per quarter (~$230 USD/mo average)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Regular recurring transfers)',
    ARRAY['Denmark'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    56.2639,
    9.5018,
    0,
    18,
    NULL,
    NULL,
    '1,200,000+ children',
    'Universal for all resident children in Denmark',
    FALSE,
    'community_submission',
    'https://www.borger.dk/familie-og-boern/Familieydelser-oversigt/Boerne-ungeydelse',
    ARRAY['https://www.borger.dk/familie-og-boern/Familieydelser-oversigt/Boerne-ungeydelse', 'https://www.norden.org/en/info-norden/child-and-youth-allowance-denmark'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Børne- og ungeydelse (Family / Youth Allowance)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    385,
    'Child Benefit (United Kingdom)',
    'HM Revenue & Customs (HMRC)',
    'UK Child Benefit is a universal baseline cash allowance paid regularly for every child under 16 (or under 20 in qualifying education). Issued directly to parents at £25.60/week for the eldest child and £16.95/week for subsequent children without initial means testing.',
    140,
    'GBP',
    '£102.40 monthly for eldest child, £67.80 for additional children (~$140 USD/mo)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'external_self_apply',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Weekly/monthly recurring transfers)',
    ARRAY['United Kingdom'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    55.3781,
    -3.436,
    0,
    16,
    NULL,
    NULL,
    '12,000,000+ children',
    'Universal baseline for all children in the UK',
    FALSE,
    'community_submission',
    'https://www.gov.uk/child-benefit',
    ARRAY['https://www.gov.uk/child-benefit', 'https://www.gov.uk/child-benefit/what-youll-get'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Child Benefit (United Kingdom)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    386,
    'Child Benefit (Ireland)',
    'Department of Social Protection (An Roinn Coimirce Sóisialaí)',
    'Ireland Child Benefit delivers a universal, non-taxable monthly payment of €140 per child to parents or guardians of all children under 16 (and up to age 18 if in full-time education or with a disability), universally administered regardless of family income.',
    155,
    'EUR',
    '€140 per child monthly (~$155 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'external_self_apply',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Ireland'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    53.1424,
    -7.6921,
    0,
    18,
    NULL,
    NULL,
    '1,200,000+ children',
    'Universal for all resident children in Ireland',
    FALSE,
    'community_submission',
    'https://www.gov.ie/en/service/f14149-child-benefit/',
    ARRAY['https://www.gov.ie/en/service/f14149-child-benefit/', 'https://www.citizensinformation.ie/en/social-welfare/families-and-children/child-benefit/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Child Benefit (Ireland)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    387,
    'New Zealand Superannuation (NZ Super)',
    'Ministry of Social Development / Work and Income NZ',
    'New Zealand Superannuation (NZ Super) is a universal, non-means-tested basic income pension for all New Zealand citizens and permanent residents aged 65 and older. Paid fortnightly at a flat baseline rate without regard to other employment earnings, personal wealth, or asset ownership.',
    1250,
    'NZD',
    'NZ$500+ weekly / NZ$1,000+ fortnightly (~$1,250 USD/mo single)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'external_self_apply',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Fortnightly recurring transfers)',
    ARRAY['New Zealand'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -40.9006,
    174.886,
    65,
    NULL,
    NULL,
    NULL,
    '880,000+ seniors',
    'Universal for all New Zealand residents aged 65+',
    FALSE,
    'community_submission',
    'https://www.workandincome.govt.nz/eligibility/seniors/superannuation/',
    ARRAY['https://www.workandincome.govt.nz/eligibility/seniors/superannuation/', 'https://www.govt.nz/browse/tax-and-benefits/nz-superannuation-and-veterans-pension/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'New Zealand Superannuation (NZ Super)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    388,
    'Basic Retirement Pension (Mauritius)',
    'Ministry of Social Integration, Social Security and National Solidarity',
    'Mauritius Basic Retirement Pension (BRP) is a non-contributory universal basic income pension provided unconditionally to all Mauritian citizens and permanent residents aged 60 and older. It represents a pillar of universal basic security in the Global South, paid regardless of employment history or private wealth.',
    300,
    'MUR',
    'Rs 13,500 - 14,000 monthly (~$300 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Mauritius'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -20.3484,
    57.5522,
    60,
    NULL,
    NULL,
    NULL,
    '260,000+ seniors',
    'Universal for all Mauritian citizens & residents aged 60+',
    FALSE,
    'community_submission',
    'https://socialsecurity.govmu.org/Pages/Social-Aid/Basic-Retirement-Pension.aspx',
    ARRAY['https://socialsecurity.govmu.org/Pages/Social-Aid/Basic-Retirement-Pension.aspx', 'https://statsmauritius.govmu.org/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Basic Retirement Pension (Mauritius)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    389,
    'Barnbidrag (Universal Child Allowance)',
    'Försäkringskassan (Swedish Social Insurance Agency)',
    'Barnbidrag provides a universal, tax-free cash allowance of 1,250 SEK (~ USD) per month for every child up to age 16 living in Sweden, with additional large-family supplements (flerbarnstillägg) for families with two or more children.',
    120,
    'SEK',
    '1,250 SEK per child monthly (~$120 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Sweden'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    60.1282,
    18.6435,
    0,
    16,
    NULL,
    NULL,
    '2,000,000+ children',
    'Universal for all children resident in Sweden',
    FALSE,
    'community_submission',
    'https://www.forsakringskassan.se/privatperson/foralder/barnbidrag',
    ARRAY['https://www.forsakringskassan.se/privatperson/foralder/barnbidrag'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Barnbidrag (Universal Child Allowance)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    390,
    'Lapsilisä (Universal Child Benefit)',
    'Kela (Social Insurance Institution of Finland)',
    'Lapsilisä is Finland''s universal, non-taxable monthly child allowance paid to all parents of children under 17 residing in Finland. The cash transfer scales progressively with family size from €94.88/month for the first child to €182.69/month for fifth and subsequent children without means testing.',
    105,
    'EUR',
    '€94.88 to €182.69 per child monthly (~ -  USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Finland'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    61.9241,
    25.7482,
    0,
    17,
    NULL,
    NULL,
    '1,000,000+ children',
    'Universal for all resident children under 17 in Finland',
    FALSE,
    'community_submission',
    'https://www.kela.fi/lapsilisa',
    ARRAY['https://www.kela.fi/lapsilisa'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Lapsilisä (Universal Child Benefit)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    391,
    'Familienbeihilfe (Universal Family Allowance)',
    'Federal Ministry of Finance (BMF) & Austrian Tax Office',
    'Familienbeihilfe is a universal child and youth cash allowance paid unconditionally to all families with children residing in Austria. Payouts range between €120 and €180/month per child depending on age, supplemented with tax credits, regardless of parental income.',
    160,
    'EUR',
    '€120 to €180 per child monthly (~$160 USD average)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Austria'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    47.5162,
    14.5501,
    0,
    18,
    NULL,
    NULL,
    '1,800,000+ children',
    'Universal for all children residing in Austria',
    FALSE,
    'community_submission',
    'https://www.oesterreich.gv.at/themen/familie_und_partnerschaft/geburt/3/2/1.html',
    ARRAY['https://www.oesterreich.gv.at/themen/familie_und_partnerschaft/geburt/3/2/1.html'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Familienbeihilfe (Universal Family Allowance)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    392,
    'Allocation Familiale (Luxembourg Universal Child Allowance)',
    'Caisse pour l''avenir des enfants (CAE / Zukunftskeess)',
    'Luxembourg’s universal child benefit provides a flat-rate monthly allowance of €299.86 (~ USD) per child from birth up to age 18 (and up to age 25 if studying), with additional automatic age bonuses added for children over 6 and 12 years old.',
    330,
    'EUR',
    '€299.86 monthly per child (~$330 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Luxembourg'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    49.8153,
    6.1296,
    0,
    18,
    NULL,
    NULL,
    '180,000+ children',
    'Universal for all resident children in Luxembourg',
    FALSE,
    'community_submission',
    'https://cae.public.lu/fr/prestations/allocations/allocation-familiale.html',
    ARRAY['https://cae.public.lu/fr/prestations/allocations/allocation-familiale.html'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Allocation Familiale (Luxembourg Universal Child Allowance)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    393,
    'Old Age Pension (Botswana)',
    'Department of Social Protection (Botswana)',
    'Botswana''s Old Age Pension is a non-contributory universal basic income pension disbursed monthly to all Botswana citizens aged 65 and older. Delivered via post offices and electronic transfers to guarantee unhindered baseline subsistence across rural and urban districts.',
    50,
    'BWP',
    'P630 monthly (~$50 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Botswana'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -22.3285,
    24.6849,
    65,
    NULL,
    NULL,
    NULL,
    '130,000+ seniors',
    'Universal for all Botswana citizens aged 65+',
    FALSE,
    'community_submission',
    'https://www.gov.bw/social-programmes/old-age-pension',
    ARRAY['https://www.gov.bw/social-programmes/old-age-pension'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Old Age Pension (Botswana)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    394,
    'Universal Old Age Grant (Namibia)',
    'Ministry of Gender Equality, Poverty Eradication and Social Welfare',
    'Namibia''s Universal Old Age Grant provides an unconditional, non-means-tested monthly cash grant of N$1,400 to all Namibian citizens and permanent residents upon reaching age 60, constituting one of the few universal basic income pensions in Sub-Saharan Africa.',
    75,
    'NAD',
    'N$1,400 monthly (~$75 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Namibia'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -22.9576,
    18.4904,
    60,
    NULL,
    NULL,
    NULL,
    '200,000+ seniors',
    'Universal for all Namibian residents aged 60+',
    FALSE,
    'community_submission',
    'https://mgepesw.gov.na/social-grants',
    ARRAY['https://mgepesw.gov.na/social-grants'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Universal Old Age Grant (Namibia)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    395,
    'Renta Dignidad (Bolivia)',
    'Gestora Pública de la Seguridad Social de Largo Plazo (Bolivia)',
    'Renta Dignidad is a universal non-contributory monthly cash pension paid unconditionally to all Bolivian citizens aged 60 and older. Funded by domestic hydrocarbon tax revenues and state enterprise dividends, ensuring nationwide elder economic security.',
    50,
    'BOB',
    'Bs 350 monthly (~$50 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Bolivia'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -16.2902,
    -63.5887,
    60,
    NULL,
    NULL,
    NULL,
    '1,100,000+ seniors',
    'Universal for all Bolivian citizens aged 60+',
    FALSE,
    'community_submission',
    'https://www.gestora.bo/RentaDignidad',
    ARRAY['https://www.gestora.bo/RentaDignidad'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Renta Dignidad (Bolivia)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    396,
    'Old Age Pension Scheme (Brunei)',
    'Community Development Department (JAPEM), Ministry of Culture, Youth and Sports',
    'Brunei’s Old Age Pension is an unconditional, non-means-tested monthly cash transfer of B (~ USD) granted to all citizens and permanent residents aged 60 and older residing in the country.',
    190,
    'BND',
    'B monthly (~ USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Brunei'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    4.5353,
    114.7277,
    60,
    NULL,
    NULL,
    NULL,
    '45,000+ seniors',
    'Universal for all Brunei residents aged 60+',
    FALSE,
    'community_submission',
    'http://www.japem.gov.bn/',
    ARRAY['http://www.japem.gov.bn/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Old Age Pension Scheme (Brunei)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    397,
    'Senior Citizens Allowance / Elderly Fund (Kiribati)',
    'Ministry of Internal and Social Affairs (Kiribati)',
    'Kiribati provides a universal cash allowance to all elderly citizens aged 65 and older across all islands, funded by the sovereign Revenue Equalization Reserve Fund (RERF) to ensure universal elder subsistence.',
    135,
    'AUD',
    'AU monthly (~ USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Kiribati'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -3.3704,
    -168.734,
    65,
    NULL,
    NULL,
    NULL,
    '7,000+ seniors',
    'Universal for all Kiribati citizens aged 65+',
    FALSE,
    'community_submission',
    'https://www.president.gov.ki/',
    ARRAY['https://www.president.gov.ki/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Senior Citizens Allowance / Elderly Fund (Kiribati)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    398,
    'Senior Citizens Allowance (Tuvalu)',
    'Department of Social Protection (Tuvalu)',
    'Tuvalu operates an unconditional universal monthly cash allowance for all citizens aged 70 and older residing in Tuvalu, providing baseline non-contributory income support across all outer atolls.',
    100,
    'AUD',
    'AU monthly (~ USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Tuvalu'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    -7.1095,
    177.6493,
    70,
    NULL,
    NULL,
    NULL,
    '1,000+ seniors',
    'Universal for all Tuvalu citizens aged 70+',
    FALSE,
    'community_submission',
    'https://tuvalugov.tv/',
    ARRAY['https://tuvalugov.tv/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Senior Citizens Allowance (Tuvalu)'
);

INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    399,
    'Jido Teate (Universal Child Allowance)',
    'Children and Families Agency (Kodomo Katei-chō)',
    'Japan''s Child Allowance (Jido Teate) is a nationwide cash stipend paid to parents for all children from birth through high school graduation (age 18), providing ¥10,000 to ¥15,000 per month per child, with income caps fully abolished to achieve complete universality.',
    100,
    'JPY',
    '¥10,000 to ¥15,000 per child monthly (~$100 USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Japan'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    36.2048,
    138.2529,
    0,
    18,
    NULL,
    NULL,
    '16,000,000+ children',
    'Universal for all children in Japan through age 18',
    FALSE,
    'community_submission',
    'https://www.cfa.go.jp/policies/child-allowance/',
    ARRAY['https://www.cfa.go.jp/policies/child-allowance/'],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name = 'Jido Teate (Universal Child Allowance)'
);
