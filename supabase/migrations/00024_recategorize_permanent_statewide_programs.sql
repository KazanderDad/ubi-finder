-- Migration 00024: Recategorize Permanent Statewide & Nationwide Programs
-- Sets distribution_type = 'permanent_statewide' for established permanent universal cash policies (Alaska PFD, Germany Kindergeld, Norway Barnetrygd, Denmark Folkepension, etc.)

UPDATE public.programs
SET distribution_type = 'permanent_statewide'
WHERE 
    name ILIKE '%Alaska Permanent Fund%'
    OR name ILIKE '%Alaska Permanent Dividend%'
    OR name ILIKE '%Kindergeld%'
    OR name ILIKE '%Barnetrygd%'
    OR name ILIKE '%Børne- og ungeydelse%'
    OR name ILIKE '%Folkepension%'
    OR (name ILIKE '%Child Benefit%' AND (available_regions @> ARRAY['United Kingdom'] OR available_regions @> ARRAY['Ireland']))
    OR name ILIKE '%New Zealand Superannuation%'
    OR name ILIKE '%Basic Retirement Pension (Mauritius)%'
    OR name ILIKE '%Barnbidrag%'
    OR name ILIKE '%Lapsilisä%'
    OR name ILIKE '%Familienbeihilfe%'
    OR name ILIKE '%Allocation Familiale%'
    OR (name ILIKE '%Old Age Pension%' AND (available_regions @> ARRAY['Botswana'] OR available_regions @> ARRAY['Brunei']))
    OR name ILIKE '%Universal Old Age Grant%'
    OR name ILIKE '%Renta Dignidad%'
    OR name ILIKE '%Senior Citizens Allowance%'
    OR name ILIKE '%Jido Teate%'
    OR name ILIKE '%Prestación Universal por Crianza%'
    OR name ILIKE '%National Childcare Subsidy (China)%'
    OR name ILIKE '%Family 800+%'
    OR name ILIKE '%Rodzina 800+%'
    OR name ILIKE '%Targeted Subsidies Reform%'
    OR name ILIKE '%National Cash Subsidy (Iran%'
    OR name ILIKE '%Wealth Partaking Scheme%'
    OR name ILIKE '%Renda Básica de Cidadania de Maricá%'
    OR name ILIKE '%Moeda Social Arariboia%'
    OR name ILIKE '%Moeda Social de Saquarema%'
    OR name ILIKE '%Renda Básica da Cidadania de Saquarema%'
    OR name ILIKE '%Gyeonggi Youth Basic Income%'
    OR name ILIKE '%Seoul Youth Allowance%';
