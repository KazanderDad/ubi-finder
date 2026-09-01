-- Migration 00025: Fix any truncated dollar amounts in descriptions and amount_descriptions
-- Restores intact currency symbols (,000, ,200, , etc.)

UPDATE public.programs
SET 
    description = 'The Alaska Permanent Fund Dividend (PFD) is the world''s longest-running and most prominent sovereign wealth resource dividend. Funded directly by state mineral and oil royalties, every eligible resident of Alaska (including children) receives an annual unconditional cash dividend payout (typically ranging between ,000 and ,200 depending on oil fund performance), provided they have lived in Alaska for a full calendar year.',
    amount_description = ',000 to ,200 annual dividend per resident (~ - /mo equivalent)',
    monthly_amount_usd = 175
WHERE name ILIKE '%Alaska Permanent Fund%' OR name ILIKE '%Alaska Permanent Dividend%';

UPDATE public.programs
SET 
    amount_description = '3,600 Yuan annually per child under 3 (~ USD/yr)',
    total_participants = '25,000,000+ infants and toddlers'
WHERE name ILIKE '%National Childcare Subsidy (China)%';

UPDATE public.programs
SET 
    amount_description = '6,928 DKK monthly Grundbeløb basic pension (~,000 USD/mo)',
    total_participants = '1,100,000+ seniors'
WHERE name ILIKE '%Folkepension%';

UPDATE public.programs
SET 
    amount_description = '€200 per child monthly (~ USD)',
    total_participants = '8,000,000+ children'
WHERE name ILIKE '%Prestación Universal por Crianza%' OR name ILIKE '%Universal Child Benefit - Spain%';

UPDATE public.programs
SET 
    amount_description = '800 PLN per child monthly (~ USD)',
    total_participants = '7,000,000+ children'
WHERE name ILIKE '%Family 800+%' OR name ILIKE '%Rodzina 800+%';

-- General cleanup: Fix leading comma numbers like ",000" -> ",000" or missing symbols in amount_description
UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',000', ',000')
WHERE amount_description LIKE '%,000%';

UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',500', ',500')
WHERE amount_description LIKE '%,500%';

UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',200', ',200')
WHERE amount_description LIKE '%,200%';

UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',400', ',400')
WHERE amount_description LIKE '%,400%';

UPDATE public.programs
SET amount_description = REPLACE(amount_description, ',600', ',600')
WHERE amount_description LIKE '%,600%';
