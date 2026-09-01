-- Migration 00026: Comprehensive description, amount_description, and body text restoration
-- Thoroughly restores full dollar signs and thousand ranges in descriptions, targeting details, and amounts across all programs

-- 1. Restore Alaska Permanent Fund Dividend description and amount
UPDATE public.programs
SET 
    description = 'The Alaska Permanent Fund Dividend (PFD) is the world''s longest-running and most prominent sovereign wealth resource dividend. Funded directly by state mineral and oil royalties, every eligible resident of Alaska (including children) receives an annual unconditional cash dividend payout (typically ranging between $1,000 and $3,200 depending on oil fund performance), provided they have lived in Alaska for a full calendar year.',
    amount_description = '$1,000 to $3,200 annual dividend per resident (~$135 - $270/mo equivalent)',
    monthly_amount_usd = 175
WHERE name ILIKE '%Alaska Permanent%';

-- 2. Restore Namibia Universal Old Age Grant
UPDATE public.programs
SET 
    description = 'Namibia''s Universal Old Age Grant provides an unconditional, non-means-tested monthly cash grant of N$1,400 to all Namibian citizens and permanent residents upon reaching age 60, constituting one of the few universal basic income pensions in Sub-Saharan Africa.',
    amount_description = 'N$1,400 monthly (~$75 USD)'
WHERE name ILIKE '%Namibia%';

-- 3. Restore New Zealand Superannuation
UPDATE public.programs
SET 
    amount_description = 'NZ$500+ weekly / NZ$1,000+ fortnightly (~$1,250 USD/mo single)'
WHERE name ILIKE '%New Zealand Superannuation%';

-- 4. Restore Denmark Folkepension
UPDATE public.programs
SET 
    description = 'Denmark''s Folkepension consists of a foundational universal basic retirement income component (Grundbeløb) that all Danish citizens and qualifying residents receive unconditionally upon reaching the statutory retirement age, guaranteed without means testing of private savings or assets.',
    amount_description = '6,928 DKK monthly Grundbeløb basic pension (~$1,000 USD/mo)'
WHERE name ILIKE '%Folkepension%';

-- 5. Restore China National Childcare Subsidy
UPDATE public.programs
SET 
    description = 'China''s nationwide universal childcare cash subsidy provides families with 3,600 Yuan (~$500 USD) annually (~$42 USD/mo) for every infant and toddler from birth until age 3, disbursed completely independent of parental earnings or family income to support early childhood and address demographic shifts.',
    amount_description = '3,600 Yuan annually per child under 3 (~$500 USD/yr)'
WHERE name ILIKE '%National Childcare Subsidy (China)%';

-- 6. Restore Spain Universal Child Benefit
UPDATE public.programs
SET 
    description = 'Spain''s Universal Child Benefit (Prestación por Crianza) provides a universal monthly cash grant of €200 (~$220 USD) for every child and youth under 18 years old. Designed as a foundational universal measure to eliminate child poverty and guarantee child subsistence unconditionally across all autonomous communities.',
    amount_description = '€200 per child monthly (~$220 USD)'
WHERE name ILIKE '%Prestación Universal por Crianza%' OR name ILIKE '%Universal Child Benefit - Spain%';

-- 7. Fix any remaining occurrences of broken text patterns in descriptions
UPDATE public.programs
SET description = REPLACE(description, 'between ,000 and ,200', 'between $1,000 and $3,200')
WHERE description LIKE '%between ,000 and ,200%';

UPDATE public.programs
SET description = REPLACE(description, 'of N,400', 'of N$1,400')
WHERE description LIKE '%of N,400%';

UPDATE public.programs
SET description = REPLACE(description, 'NZ,000', 'NZ$1,000')
WHERE description LIKE '%NZ,000%';

UPDATE public.programs
SET description = REPLACE(description, ' (~,000', ' (~$1,000')
WHERE description LIKE '% (~,000%';

UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',000 to ,200', '$1,000 to $3,200')
WHERE amount_description LIKE '%,000 to ,200%';
