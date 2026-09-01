-- Migration 00023: Ingest Missing Universal Cash Transfer Programs and Enrich References
-- Covers Spain Child Benefit, China National Childcare Subsidy, Denmark Folkepension, Poland Family 800+, Alaska PFD, Iran National Cash Subsidy, and all user references.

-- 1. Insert Spain Universal Child Benefit (Prestación Universal por Crianza)
INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    378,
    'Prestación Universal por Crianza (Universal Child Benefit - Spain)',
    'Ministry of Social Rights, Consumer Affairs and 2030 Agenda (Spain)',
    'Spain''s Universal Child Benefit (Prestación por Crianza) provides a universal monthly cash grant of €200 (~$220 USD) for every child and youth under 18 years old. Designed as a foundational universal measure to eliminate child poverty and guarantee child subsistence unconditionally across all autonomous communities.',
    220,
    'EUR',
    '€200 per child monthly (~ USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Spain'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    40.4637,
    -3.7492,
    0,
    18,
    NULL,
    NULL,
    '88,000,000+ children',
    'Universal for all resident children and youth under 18 in Spain',
    FALSE,
    'community_submission',
    'https://www.mdsocialesa2030.gob.es/',
    ARRAY[
        'https://www.humanium.org/en/spains-2025-universal-child-benefit-aims-to-combat-child-poverty/',
        'https://www.hrw.org/news/2025/02/06/spains-universal-child-benefit-could-transform-lives'
    ],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name ILIKE '%Prestación Universal por Crianza%' OR name ILIKE '%Universal Child Benefit - Spain%'
);

-- 2. Insert China National Childcare Subsidy
INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    379,
    'National Childcare Subsidy (China)',
    'National Health Commission (NHC) & Ministry of Finance of the PRC',
    'China''s nationwide universal childcare cash subsidy provides families with 3,600 Yuan (~$500 USD) annually (~$42 USD/mo) for every infant and toddler from birth until age 3, disbursed completely independent of parental earnings or family income to support early childhood and address demographic shifts.',
    42,
    'CNY',
    '33,600 Yuan annually per child under 3 (~$500 USD/yr)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Annual / regular cash disbursements)',
    ARRAY['China'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    35.8617,
    104.1954,
    0,
    3,
    NULL,
    NULL,
    '2525,000,000+ infants and toddlers',
    'Universal for all children from birth through age 3 in China',
    FALSE,
    'community_submission',
    'http://www.nhc.gov.cn/',
    ARRAY[
        'https://www.newsweek.com/map-shows-countries-paying-people-to-have-babies-as-birth-rate-drops-12363970'
    ],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name ILIKE '%National Childcare Subsidy (China)%'
);

-- 3. Insert Denmark Folkepension (Universal Basic Retirement Component)
INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    380,
    'Folkepension (Universal Basic Retirement Pension - Denmark)',
    'Udbetaling Danmark / Ministry of Social Affairs and Housing',
    'Denmark''s Folkepension consists of a foundational universal basic retirement income component (Grundbeløb) that all Danish citizens and qualifying residents receive unconditionally upon reaching the statutory retirement age, guaranteed without means testing of private savings or assets.',
    1000,
    'DKK',
    '6,928 DKK monthly Grundbeløb basic pension (~$1,000 USD/mo)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Denmark'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    56.2639,
    9.5018,
    67,
    NULL,
    NULL,
    NULL,
    '1,1001,100,000+ seniors',
    'Universal basic Grundbeløb component for all Danish residents reaching retirement age',
    FALSE,
    'community_submission',
    'https://www.borger.dk/pension-og-efterloen/Folkepension-oversigt/folkepension-hvad-kan-jeg-faa',
    ARRAY[
        'https://www.borger.dk/pension-og-efterloen/Folkepension-oversigt/folkepension-hvad-kan-jeg-faa',
        'https://www.norden.org/en/info-norden/old-age-pension-denmark'
    ],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name ILIKE '%Folkepension%'
);

-- 4. Insert Poland Family 800+ (Rodzina 800+)
INSERT INTO public.programs (
    program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
    payment_method, distribution_type, payout_rail, funding_source, involvement_level, status, application_status,
    payout_status, available_regions, required_states, municipalities, latitude, longitude, min_age, max_age,
    gender_requirement, max_household_income_usd, total_participants, targeting_details,
    is_rct, data_source, website, sources, verified
)
SELECT
    381,
    'Family 800+ (Rodzina 800+ - Universal Child Benefit Poland)',
    'Social Insurance Institution (ZUS - Zakład Ubezpieczeń Społecznych)',
    'Poland''s Family 800+ (formerly Rodzina 500+) provides an unconditional, non-means-tested monthly cash transfer of 800 PLN (~$219 USD) per child to all families residing in Poland for every child until they turn 18. Covers over 7 million children as a universal demogrant.',
    219,
    'PLN',
    '800 PLN per child monthly (~ USD)',
    'standard'::public.payment_method,
    'guaranteed_recurrent',
    'direct_deposit',
    'state_federal',
    'automated_claim',
    'active_open'::public.program_status,
    'Accepting applications',
    'Active (Monthly recurring transfers)',
    ARRAY['Poland'],
    ARRAY[]::TEXT[],
    ARRAY[]::TEXT[],
    51.9194,
    19.1451,
    0,
    18,
    NULL,
    NULL,
    '78,000,000+ children',
    'Universal for all resident children in Poland through age 18',
    FALSE,
    'community_submission',
    'https://www.zus.pl/swiadczenia/program-rodzina-800plus',
    ARRAY[
        'https://www.newsweek.com/list-countries-offering-financial-incentives-have-more-children-10926521',
        'https://fra.europa.eu/en/publication/2017/mapping-minimum-age-requirements-concerning-rights-child-eu/child-benefits-children-living-their-families'
    ],
    TRUE
WHERE NOT EXISTS (
    SELECT 1 FROM public.programs WHERE name ILIKE '%Family 800+%' OR name ILIKE '%Rodzina 800+%'
);

-- 5. Enrich Finland (Lapsilisä) with EU FRA Citation
UPDATE public.programs
SET sources = ARRAY[
    'https://www.kela.fi/lapsilisa',
    'https://fra.europa.eu/en/publication/2017/mapping-minimum-age-requirements-concerning-rights-child-eu/child-benefits-children-living-their-families'
]
WHERE name ILIKE '%Lapsilisä%';

-- 6. Enrich Brunei (Old Age Pension) with Citations
UPDATE public.programs
SET sources = ARRAY[
    'http://www.japem.gov.bn/',
    'https://dds.cepal.org/bpsnc/sp',
    'https://www.worldfinance.com/wealth-management/top-5-most-sustainable-pension-systems-worldwide',
    'https://www.sciencedirect.com/science/article/abs/pii/S0305750X06001793'
]
WHERE name ILIKE '%Brunei%' AND (name ILIKE '%Old Age%' OR name ILIKE '%Pension%');

-- 7. Ensure Alaska Permanent Fund Dividend (PFD) is fully enriched
UPDATE public.programs
SET 
    description = 'The Alaska Permanent Fund Dividend (PFD) is the world''s longest-running and most prominent sovereign wealth resource dividend. Funded directly by state mineral and oil royalties, every eligible resident of Alaska (including children) receives an annual unconditional cash dividend payout (typically ranging between $1,000 and $3,200 depending on oil fund performance), provided they have lived in Alaska for a full calendar year.',
    amount_description = '$1,000 to $3,200 annual dividend per resident (~$135 - $270/mo equivalent)',
    monthly_amount_usd = 175,
    sources = ARRAY[
        'https://pfd.alaska.gov/',
        'https://apfc.org/',
        'https://en.wikipedia.org/wiki/Alaska_Permanent_Fund'
    ]
WHERE name ILIKE '%Alaska Permanent Fund%' OR name ILIKE '%Alaska Permanent Dividend%';

-- 8. Ensure Iran Targeted Subsidies Reform Act / National Cash Subsidy is fully enriched
UPDATE public.programs
SET 
    name = 'National Cash Subsidy (Iran Targeted Subsidies Reform)',
    description = 'Iran established a nationwide basic income framework in 2010. To replace regressive and expensive state energy and food price subsidies, the government shifted to depositing a monthly unconditional cash transfer directly into the personal bank accounts of all citizens across the country (~75 million people).',
    amount_description = '455,000 to 3,000,000+ Rials monthly per citizen',
    monthly_amount_usd = 45,
    sources = ARRAY[
        'https://en.wikipedia.org/wiki/Universal_basic_income_by_country',
        'https://www.imf.org/external/pubs/ft/wp/2014/wp14120.pdf'
    ]
WHERE name ILIKE '%Targeted Subsidies Reform%' OR name ILIKE '%Iran%';
