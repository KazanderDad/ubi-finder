-- Migration 00006: Add delivery mechanisms, distribution classes, funding sources, and geographic hierarchy

-- 1. Add distribution and delivery columns to programs
ALTER TABLE public.programs 
  ADD COLUMN IF NOT EXISTS distribution_type text DEFAULT 'guaranteed_recurrent',
  ADD COLUMN IF NOT EXISTS payout_rail text DEFAULT 'direct_deposit',
  ADD COLUMN IF NOT EXISTS funding_source text DEFAULT 'philanthropic_grant',
  ADD COLUMN IF NOT EXISTS state_province text,
  ADD COLUMN IF NOT EXISTS municipalities text[] DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS latitude numeric,
  ADD COLUMN IF NOT EXISTS longitude numeric;

-- 2. Add municipality and payout preference to user_profiles
ALTER TABLE public.user_profiles
  ADD COLUMN IF NOT EXISTS municipality text,
  ADD COLUMN IF NOT EXISTS preferred_payout_rails text[] DEFAULT '{}';

-- 3. Seed / Update existing programs with coordinates, rails, funding, and distribution classes
UPDATE public.programs 
SET 
  distribution_type = 'daily_claim_protocol',
  payout_rail = 'crypto_wallet',
  funding_source = 'protocol_yield',
  latitude = 32.0853,
  longitude = 34.7818,
  state_province = 'Global',
  municipalities = ARRAY['Global']
WHERE name ILIKE '%GoodDollar%';

UPDATE public.programs 
SET 
  distribution_type = 'daily_claim_protocol',
  payout_rail = 'crypto_wallet',
  funding_source = 'protocol_yield',
  latitude = 52.5200,
  longitude = 13.4050,
  state_province = 'Berlin',
  municipalities = ARRAY['Berlin', 'Global']
WHERE name ILIKE '%Circles%';

UPDATE public.programs 
SET 
  distribution_type = 'lottery_raffle',
  payout_rail = 'direct_deposit',
  funding_source = 'community_crowdfund',
  latitude = 52.5200,
  longitude = 13.4050,
  state_province = 'Berlin',
  municipalities = ARRAY['Berlin', 'Germany']
WHERE name ILIKE '%Grundeinkommen%' OR name ILIKE '%Mein%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'prepaid_card',
  funding_source = 'philanthropic_grant',
  latitude = 37.9577,
  longitude = -121.2908,
  state_province = 'CA',
  municipalities = ARRAY['Stockton']
WHERE name ILIKE '%Stockton%' OR name ILIKE '%SEED%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'prepaid_card',
  funding_source = 'municipal_government',
  latitude = 37.7749,
  longitude = -122.4194,
  state_province = 'CA',
  municipalities = ARRAY['San Francisco']
WHERE name ILIKE '%Abundant Birth%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'direct_deposit',
  funding_source = 'state_federal',
  latitude = 64.2008,
  longitude = -149.4937,
  state_province = 'AK',
  municipalities = ARRAY['Statewide']
WHERE name ILIKE '%Alaska%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'mobile_money',
  funding_source = 'philanthropic_grant',
  latitude = 0.0236,
  longitude = 37.9062,
  state_province = 'Siaya',
  municipalities = ARRAY['Bondo', 'Ugunja']
WHERE name ILIKE '%GiveDirectly%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'direct_deposit',
  funding_source = 'municipal_government',
  latitude = -22.9194,
  longitude = -42.8186,
  state_province = 'Rio de Janeiro',
  municipalities = ARRAY['Maricá']
WHERE name ILIKE '%Maricá%' OR name ILIKE '%Marica%';

UPDATE public.programs 
SET 
  distribution_type = 'guaranteed_recurrent',
  payout_rail = 'direct_deposit',
  funding_source = 'state_federal',
  latitude = 48.3809,
  longitude = -89.2477,
  state_province = 'ON',
  municipalities = ARRAY['Thunder Bay', 'Hamilton', 'Lindsay']
WHERE name ILIKE '%Ontario%';

-- Add a Canadian Maritime program sample with Moncton municipal scope if none exists
INSERT INTO public.programs (
  program_id, name, organization, description, monthly_amount_usd, currency, amount_description,
  payment_method, status, payout_status, application_status, available_regions, required_states,
  distribution_type, payout_rail, funding_source, state_province, municipalities,
  latitude, longitude, website, apply_url, verified
)
SELECT 
  (SELECT COALESCE(MAX(program_id), 0) + 1 FROM public.programs),
  'New Brunswick Youth Basic Income Pilot',
  'Government of New Brunswick & Social Labs',
  'A regional basic income initiative delivering monthly financial floors to young adults transitioning into the workforce in Moncton and Saint John.',
  750,
  'CAD',
  '$1,000 CAD per month',
  'standard',
  'active',
  'Ongoing',
  'Open',
  ARRAY['Canada'],
  ARRAY['NB', 'New Brunswick'],
  'guaranteed_recurrent',
  'direct_deposit',
  'municipal_government',
  'NB',
  ARRAY['Moncton', 'Saint John'],
  46.0878,
  -64.7782,
  'https://www2.gnb.ca',
  'https://www2.gnb.ca/apply',
  true
WHERE NOT EXISTS (
  SELECT 1 FROM public.programs WHERE name ILIKE '%New Brunswick%'
);
