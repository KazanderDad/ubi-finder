-- Migration 00025: Fix all corrupted dollar amounts in descriptions and amount_descriptions
-- Restores intact currency symbols ($1,000, $3,200, $500, etc.)

UPDATE public.programs
SET 
    description = 'The Alaska Permanent Fund Dividend (PFD) is the world''s longest-running and most prominent sovereign wealth resource dividend. Funded directly by state mineral and oil royalties, every eligible resident of Alaska (including children) receives an annual unconditional cash dividend payout (typically ranging between $1,000 and $3,200 depending on oil fund performance), provided they have lived in Alaska for a full calendar year.',
    amount_description = '$1,000 to $3,200 annual dividend per resident (~$135 - $270/mo equivalent)',
    monthly_amount_usd = 175
WHERE name ILIKE '%Alaska Permanent Fund%' OR name ILIKE '%Alaska Permanent Dividend%';

UPDATE public.programs
SET 
    amount_description = '3,600 Yuan annually per child under 3 (~$500 USD/yr)',
    total_participants = '25,000,000+ infants and toddlers'
WHERE name ILIKE '%National Childcare Subsidy (China)%';

UPDATE public.programs
SET 
    amount_description = '6,928 DKK monthly Grundbeløb basic pension (~$1,000 USD/mo)',
    total_participants = '1,100,000+ seniors'
WHERE name ILIKE '%Folkepension%';

UPDATE public.programs
SET 
    amount_description = '€200 per child monthly (~$220 USD)',
    total_participants = '8,000,000+ children'
WHERE name ILIKE '%Prestación Universal por Crianza%' OR name ILIKE '%Universal Child Benefit - Spain%';

UPDATE public.programs
SET 
    amount_description = '800 PLN per child monthly (~$219 USD)',
    total_participants = '7,000,000+ children'
WHERE name ILIKE '%Family 800+%' OR name ILIKE '%Rodzina 800+%';

UPDATE public.programs
SET 
    amount_description = 'NZ$500+ weekly / NZ$1,000+ fortnightly (~$1,250 USD/mo single)'
WHERE name ILIKE '%New Zealand Superannuation%';

UPDATE public.programs
SET 
    description = 'Namibia''s Universal Old Age Grant provides an unconditional, non-means-tested monthly cash grant of N$1,400 to all Namibian citizens and permanent residents upon reaching age 60, constituting one of the few universal basic income pensions in Sub-Saharan Africa.',
    amount_description = 'N$1,400 monthly (~$75 USD)'
WHERE name ILIKE '%Namibia%';
