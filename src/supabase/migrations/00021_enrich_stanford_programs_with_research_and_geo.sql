-- Migration 00021: Geocode and Enrich all Stanford Basic Income Lab Programs with Coordinates, Sources & Web Metadata

UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Alaska Permanent Dividend Fund';
UPDATE public.programs
SET
    latitude = 33.5186,
    longitude = -86.8104,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Embrace Mothers';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Returning Home Career Grant';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Community-Based Roads to Prosperity';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'NET Growth Movement';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Coco Go BIG';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Rise Up Alameda';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'ELEVATE Concord: Family Economic Equity Pilot';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Immigrant Families Recovery Program: Coachella''s UBI Recovery Program';
UPDATE public.programs
SET
    latitude = 33.8958,
    longitude = -118.2201,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Compton Pledge';
UPDATE public.programs
SET
    latitude = 32.7157,
    longitude = -117.1611,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Family Income for Empowerment Program';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'City of El Monte Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Advancing Fresno County Guaranteed Income';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'HIP (Humboldt Income Program)';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Breathe: LA County''s Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'LA County Breathe - Former Foster Youth Expansion 1';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'LA County Breathe - Former Foster Youth Expansion 2';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'TAYportunity Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 33.7701,
    longitude = -118.1937,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Long Beach Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 33.7701,
    longitude = -118.1937,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Long Beach Pledge (Cohort 1)';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'BIG:LEAP (Basic Income Guaranteed: L.A. Economic Assistance Pilot)';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family Goal Fund';
UPDATE public.programs
SET
    latitude = 31.169546,
    longitude = -91.867805,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'BOOST: Building Outstanding Opportunities for Students to Thrive';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Pregnancy Assistance Income with Dignity (P.A.I.D.)';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'NCJWLA Guaranteed Income Project';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Miracle Money';
UPDATE public.programs
SET
    latitude = 38.0834,
    longitude = -122.7633,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'MOMentum';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Alas';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Elevate MV';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Miracle Money  - Thriving Community Fund (TCF) expansion';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Abundant Birth Project';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'California Abundant Birth Project';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'California Abundant Birth Project — Contra Costa County, CA';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'California Abundant Birth Project — Los Angeles County, CA';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'California Abundant Birth Project — Riverside County';
UPDATE public.programs
SET
    latitude = 37.8044,
    longitude = -122.2712,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Restorative Reentry Fund';
UPDATE public.programs
SET
    latitude = 37.8044,
    longitude = -122.2712,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Oakland Resilient Families';
UPDATE public.programs
SET
    latitude = 37.8044,
    longitude = -122.2712,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Miracle Money — Oakland, San Francisco, and Los Angeles, CA';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Palm Springs'' Universal Basic Income pilot';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'City of Pomona Household Universal Grants Pilot Program (Pomona HUG)';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Inland SoCal United Way (ISCUW) Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Creative Growth Fellowship';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 1';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 2';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'United Way California Capital Region (UWCCR) Guaranteed Income Program Cohort 3';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Collegiate Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 38.5816,
    longitude = -121.4944,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family First Economic Support Pilot';
UPDATE public.programs
SET
    latitude = 32.7157,
    longitude = -117.1611,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Black Women''s Resilience Project';
UPDATE public.programs
SET
    latitude = 32.7157,
    longitude = -117.1611,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'San Diego for Every Child';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'It All Adds Up pilot (Bay Area Thriving Families study)';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'San Francisco''s Guaranteed Income Pilot for Artists (GIPA)';
UPDATE public.programs
SET
    latitude = 37.8044,
    longitude = -122.2712,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'BEEM: The Black Economic Equity Movement Project';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Cash Transfers and Rapid Re-Housing';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Project Empower';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'San Francisco Housing Stability Fund';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Trust Youth Initiative San Francisco';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Creative Communities Coalition Coalition for Guaranteed Income (CCCGI)';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Foundations for the Future';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Compass Family Service Basic Income Pilot';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Miracle Money — San Francisco, Oakland, and Los Angeles, CA';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Guaranteed Income Program for Domestic Violence Survivors';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Immigrant Families Recovery Program: San Mateo County';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'San Mateo County Guaranteed Income Program for Former Foster Youth';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'San Mateo County Baby Bonus Pilot Program';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Aging With Dignity';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'GBI for Unhoused High School Students';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'GBI for Young Parents';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Re-Entry Guaranteed Income';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Silicon Valley Guaranteed Income Project';
UPDATE public.programs
SET
    latitude = 37.3541,
    longitude = -121.9552,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Santa Clara County UBI Pilot for Former Foster Youth';
UPDATE public.programs
SET
    latitude = 34.0195,
    longitude = -118.4912,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Preserving Our Diversity (POD) Pilot #1';
UPDATE public.programs
SET
    latitude = 34.0195,
    longitude = -118.4912,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Preserving Our Diversity (POD) Pilot #2';
UPDATE public.programs
SET
    latitude = 38.578,
    longitude = -122.9888,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Pathway to Income Equity';
UPDATE public.programs
SET
    latitude = 34.0522,
    longitude = -118.2437,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Mothers Rising for Guaranteed Basic Income';
UPDATE public.programs
SET
    latitude = 37.7749,
    longitude = -122.4194,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'South San Francisco Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 37.9577,
    longitude = -121.2908,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Stockton Economic Empowerment Demonstration (SEED)';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Ventura County Thrive';
UPDATE public.programs
SET
    latitude = 34.09,
    longitude = -118.3617,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'West Hollywood Pilot for Guaranteed Income';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Yolo County Basic Income (YOBI)';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Miracle Money  - Dignity Fund expansion';
UPDATE public.programs
SET
    latitude = 36.116203,
    longitude = -119.681564,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Smooth Transitions';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Respond, Recover and Rebuild';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Thriving Providers Project (CO)';
UPDATE public.programs
SET
    latitude = 40.015,
    longitude = -105.2705,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Elevate Boulder';
UPDATE public.programs
SET
    latitude = 40.015,
    longitude = -105.2705,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Thriving Providers Project (CO) — Boulder, CO';
UPDATE public.programs
SET
    latitude = 39.059811,
    longitude = -105.311104,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Harrison 2 - Colorado Springs';
UPDATE public.programs
SET
    latitude = 39.7392,
    longitude = -104.9903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Build With Families';
UPDATE public.programs
SET
    latitude = 39.7392,
    longitude = -104.9903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Denver Basic Income Project';
UPDATE public.programs
SET
    latitude = 39.7392,
    longitude = -104.9903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Bridge Network';
UPDATE public.programs
SET
    latitude = 39.7392,
    longitude = -104.9903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME)';
UPDATE public.programs
SET
    latitude = 39.7392,
    longitude = -104.9903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Healthy Beginnings Project';
UPDATE public.programs
SET
    latitude = 37.5833,
    longitude = -105.8833,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'San Luis Valley, Colorado';
UPDATE public.programs
SET
    latitude = 41.3083,
    longitude = -72.9279,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Elm City Reentry Pilot';
UPDATE public.programs
SET
    latitude = 39.063946,
    longitude = -76.802101,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Let''s Go DMV!';
UPDATE public.programs
SET
    latitude = 38.9072,
    longitude = -77.0369,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Strong Families, Strong Future DC';
UPDATE public.programs
SET
    latitude = 38.9072,
    longitude = -77.0369,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family Goal Fund — Washington DC';
UPDATE public.programs
SET
    latitude = 38.9072,
    longitude = -77.0369,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Mother Up Pilot';
UPDATE public.programs
SET
    latitude = 38.9072,
    longitude = -77.0369,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'My Sister''s Place Cash Transfer Program';
UPDATE public.programs
SET
    latitude = 38.9072,
    longitude = -77.0369,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Thrive East of the River';
UPDATE public.programs
SET
    latitude = 39.7447,
    longitude = -75.5484,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Delaware Healthy Mother & Infant Consortium (DHMIC)';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Eastern Band of Cherokee Indians Casino Revenue Fund';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'EBCI GenWell Program';
UPDATE public.programs
SET
    latitude = 29.6516,
    longitude = -82.3248,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Just Income';
UPDATE public.programs
SET
    latitude = 25.7617,
    longitude = -80.1918,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'GI 305 Community Fund';
UPDATE public.programs
SET
    latitude = 33.749,
    longitude = -84.388,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'I.M.P.A.C.T. (Income Mobility Program for Atlanta Community Transformation)';
UPDATE public.programs
SET
    latitude = 33.749,
    longitude = -84.388,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'In Her Hands - Atlanta''s Old Fourth Ward';
UPDATE public.programs
SET
    latitude = 33.749,
    longitude = -84.388,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'In Her Hands - Atlanta''s Westside Neighborhoods';
UPDATE public.programs
SET
    latitude = 33.749,
    longitude = -84.388,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'In Her Hands - Southwest Georgia (Clay, Randolph, and Terrell Counties)';
UPDATE public.programs
SET
    latitude = 33.749,
    longitude = -84.388,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'In Her Hands - City of College Park';
UPDATE public.programs
SET
    latitude = 42.011539,
    longitude = -93.210526,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Rural Income Maintenance Experiment';
UPDATE public.programs
SET
    latitude = 42.011539,
    longitude = -93.210526,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'UpLift - The Central Iowa Basic Income Pilot';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Champaign County Guaranteed Income Project';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Affording Survival';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Chicago Resilient Communities Pilot';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Dream Keeper Fellowship';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Evanston Equitable Recovery Fund';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family Goal Fund — Chicago, IL';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Cook County Promise Guaranteed Income';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Every Dollar Counts';
UPDATE public.programs
SET
    latitude = 42.0451,
    longitude = -87.6877,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Direct Giving Lab';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Empower Parenting with Resources (EmPwR)';
UPDATE public.programs
SET
    latitude = 41.8781,
    longitude = -87.6298,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Chicago Future Fund';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment)';
UPDATE public.programs
SET
    latitude = 41.5934,
    longitude = -87.3464,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Gary Income Maintenance Experiment';
UPDATE public.programs
SET
    latitude = 41.5934,
    longitude = -87.3464,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Guaranteed Income Validation Effort (GIVE Gary)';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'The Rooted School: The 50 Dollar Study';
UPDATE public.programs
SET
    latitude = 38.2527,
    longitude = -85.7585,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'YALift! (Young Adult Louisville Income For Transformation)';
UPDATE public.programs
SET
    latitude = 29.9511,
    longitude = -90.0715,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Baby''s First Years - Louisiana';
UPDATE public.programs
SET
    latitude = 32.5252,
    longitude = -93.7502,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Shreveport Guaranteed Income';
UPDATE public.programs
SET
    latitude = 31.169546,
    longitude = -91.867805,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Truth & Reconciliation Project''s Guaranteed Monthly Income';
UPDATE public.programs
SET
    latitude = 29.9511,
    longitude = -90.0715,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'New Orleans Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 29.9511,
    longitude = -90.0715,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'The Rooted School: The 50 Dollar Study — New Orleans, LA';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Camp Harbor View Guaranteed Income Pilot';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Community Love Fund';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Pediatric RISE';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Striving Towards Economic Prosperity (STEP)';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Trust and Invest Collaborative';
UPDATE public.programs
SET
    latitude = 42.3736,
    longitude = -71.1097,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Cambridge RISE (Recurring Income for Success and Empowerment)';
UPDATE public.programs
SET
    latitude = 42.3918,
    longitude = -71.0328,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Chelsea Eats';
UPDATE public.programs
SET
    latitude = 39.849426,
    longitude = -86.258278,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Healthy Families MA (HFM) Family Financial Pilot';
UPDATE public.programs
SET
    latitude = 42.3601,
    longitude = -71.0589,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Bridge to Prosperity Cliffs Pilot Program';
UPDATE public.programs
SET
    latitude = 42.4668,
    longitude = -70.9495,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family Health Project';
UPDATE public.programs
SET
    latitude = 42.230171,
    longitude = -71.530106,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Economic Stability/Mobility Initiative';
UPDATE public.programs
SET
    latitude = 39.063946,
    longitude = -76.802101,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Prince George Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 39.063946,
    longitude = -76.802101,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Montgomery County Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 39.2904,
    longitude = -76.6122,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Baltimore Young Families Success Fund';
UPDATE public.programs
SET
    latitude = 44.693947,
    longitude = -69.381927,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Project Home Trust';
UPDATE public.programs
SET
    latitude = 42.2808,
    longitude = -83.743,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Guaranteed Income to Grow Ann Arbor';
UPDATE public.programs
SET
    latitude = 43.326618,
    longitude = -84.536095,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Thriving Families';
UPDATE public.programs
SET
    latitude = 44.9778,
    longitude = -93.265,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Project Solid Ground';
UPDATE public.programs
SET
    latitude = 44.9778,
    longitude = -93.265,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Minneapolis Guaranteed Basic Income Pilot';
UPDATE public.programs
SET
    latitude = 45.694454,
    longitude = -93.900192,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'CollegeBound Boost';
UPDATE public.programs
SET
    latitude = 45.694454,
    longitude = -93.900192,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'International Institute of Minnesota''s Guaranteed Income Program for Refugees';
UPDATE public.programs
SET
    latitude = 45.694454,
    longitude = -93.900192,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'People''s Prosperity Pilot';
UPDATE public.programs
SET
    latitude = 44.9778,
    longitude = -93.265,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Baby''s First Years - Minnesota';
UPDATE public.programs
SET
    latitude = 45.694454,
    longitude = -93.900192,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Rai$e Program';
UPDATE public.programs
SET
    latitude = 32.2988,
    longitude = -90.1848,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Magnolia Mother''s Trust Cohort 4';
UPDATE public.programs
SET
    latitude = 32.2988,
    longitude = -90.1848,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Magnolia Mother''s Trust';
UPDATE public.programs
SET
    latitude = 32.741646,
    longitude = -89.678696,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Warren County, Mississippi';
UPDATE public.programs
SET
    latitude = 46.921925,
    longitude = -110.454353,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'LIFT';
UPDATE public.programs
SET
    latitude = 39.849426,
    longitude = -86.258278,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Returning Citizen Stimulus (RCS) Program';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Project 100+';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Bootstraps';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Growing Strong';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'The Resilience Fund';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Immigrant Families Recovery Program - National';
UPDATE public.programs
SET
    latitude = 35.630066,
    longitude = -79.806419,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Beaufort County, North Carolina';
UPDATE public.programs
SET
    latitude = 35.630066,
    longitude = -79.806419,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Rural Income Maintenance Experiment — Duplic County, NC';
UPDATE public.programs
SET
    latitude = 35.994,
    longitude = -78.8986,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Excel';
UPDATE public.programs
SET
    latitude = 41.12537,
    longitude = -98.268082,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Baby''s First Years - Nebraska';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Jersey Income Maintenance Experiment';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Newark Movement for Economic Equity';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Jersey Income Maintenance Experiment — Paterson, NJ';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Paterson Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Jersey Income Maintenance Experiment — Prassaic, NJ';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Jersey Income Maintenance Experiment — Scranton, NJ';
UPDATE public.programs
SET
    latitude = 40.298904,
    longitude = -74.521011,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Jersey Income Maintenance Experiment — Trenton, NJ';
UPDATE public.programs
SET
    latitude = 35.0844,
    longitude = -106.6504,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Students Experiencing Homelessness Basic Needs Stipend Pilot';
UPDATE public.programs
SET
    latitude = 34.840515,
    longitude = -106.248482,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Albuquerque Public Schools and Las Cruces Public Schools- Students Experiencing Homelessness Pilot';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'New Mexico Guaranteed Basic Income Pilot Project & Study for Immigrant Families';
UPDATE public.programs
SET
    latitude = 31.169546,
    longitude = -91.867805,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Family Prosperity';
UPDATE public.programs
SET
    latitude = 35.687,
    longitude = -105.9378,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Santa Fe Learn, Earn, Achieve Program (SF LEAP)';
UPDATE public.programs
SET
    latitude = 42.165726,
    longitude = -74.948051,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Jubilant Birth';
UPDATE public.programs
SET
    latitude = 43.1566,
    longitude = -77.6088,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Artist Grants Program';
UPDATE public.programs
SET
    latitude = 42.2529,
    longitude = -73.791,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'HudsonUP';
UPDATE public.programs
SET
    latitude = 42.444,
    longitude = -76.5019,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Ithaca Guaranteed Income';
UPDATE public.programs
SET
    latitude = 42.165726,
    longitude = -74.948051,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Level Up Guaranteed Income Pilot';
UPDATE public.programs
SET
    latitude = 42.165726,
    longitude = -74.948051,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Family Goal Fund — New York, NY';
UPDATE public.programs
SET
    latitude = 40.7128,
    longitude = -74.006,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Baby''s First Years - New York';
UPDATE public.programs
SET
    latitude = 42.165726,
    longitude = -74.948051,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Trust Youth Initiative: Direct Cash Transfers to Address Young Adult Homelessness';
UPDATE public.programs
SET
    latitude = 43.1566,
    longitude = -77.6088,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'City of Rochester Guaranteed Basic Income (GBI) Pilot Program';
UPDATE public.programs
SET
    latitude = 43.1566,
    longitude = -77.6088,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Artist Grants';
UPDATE public.programs
SET
    latitude = 42.165726,
    longitude = -74.948051,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Project Resilience';
UPDATE public.programs
SET
    latitude = 40.7128,
    longitude = -74.006,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'CRNY Guaranteed Income for Artists';
UPDATE public.programs
SET
    latitude = 40.388783,
    longitude = -82.764915,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Ohio Mothers Trust';
UPDATE public.programs
SET
    latitude = 39.8064,
    longitude = -83.8872,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'YSEQUITY';
UPDATE public.programs
SET
    latitude = 35.565342,
    longitude = -96.928917,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'UpTogether Tusla';
UPDATE public.programs
SET
    latitude = 32.2988,
    longitude = -90.1848,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Southern Oregon Success';
UPDATE public.programs
SET
    latitude = 44.572021,
    longitude = -122.070938,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Oregon Direct Cash Transfers Plus';
UPDATE public.programs
SET
    latitude = 45.5152,
    longitude = -122.6784,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Black Resilience Fund';
UPDATE public.programs
SET
    latitude = 45.5152,
    longitude = -122.6784,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Path Home Basic Income Guarantee Pilot Project';
UPDATE public.programs
SET
    latitude = 45.5152,
    longitude = -122.6784,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Path Home Cash Transfer Pilot Program';
UPDATE public.programs
SET
    latitude = 44.572021,
    longitude = -122.070938,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Multnomah Mothers'' Trust';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Osage ARP Cash Assistance';
UPDATE public.programs
SET
    latitude = 39.9526,
    longitude = -75.1652,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'A Pilot Study of Cash Transfers to Improve Outcomes in Low-Income Preterm Neonates and Their Families';
UPDATE public.programs
SET
    latitude = 39.9526,
    longitude = -75.1652,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Guaranteed Resources Optimize Wellbeing (GROW)';
UPDATE public.programs
SET
    latitude = 39.9526,
    longitude = -75.1652,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'One Family Philadelphia Guaranteed Income Financial Treatment (GIFTT)';
UPDATE public.programs
SET
    latitude = 39.9526,
    longitude = -75.1652,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Philadelphia Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 41.680893,
    longitude = -71.51178,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Providence Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 34.0007,
    longitude = -81.0348,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'CLIMB (Columbia Life Improvement Monetary Boost)';
UPDATE public.programs
SET
    latitude = 35.747845,
    longitude = -86.692345,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = '37208 Demonstration';
UPDATE public.programs
SET
    latitude = 35.747845,
    longitude = -86.692345,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Black Music Action Coalition x Academy of Country Music Guaranteed Income Program';
UPDATE public.programs
SET
    latitude = 30.2672,
    longitude = -97.7431,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Austin''s Guaranteed Income Pilot Program';
UPDATE public.programs
SET
    latitude = 30.2672,
    longitude = -97.7431,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Central Texas 12-Month Pilot';
UPDATE public.programs
SET
    latitude = 31.054487,
    longitude = -97.563461,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Dallas Targeted Eviction Prevention Program Fund';
UPDATE public.programs
SET
    latitude = 32.7555,
    longitude = -97.3308,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'UpTogether Morningside';
UPDATE public.programs
SET
    latitude = 31.054487,
    longitude = -97.563461,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Houston Equity Fund';
UPDATE public.programs
SET
    latitude = 29.4241,
    longitude = -98.4936,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Rising UpTogether San Antonio';
UPDATE public.programs
SET
    latitude = 29.4241,
    longitude = -98.4936,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'San Antonio Basic Income Pilot';
UPDATE public.programs
SET
    latitude = 40.349457,
    longitude = -88.986137,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'OpenResearch Unconditional Cash Study (previously, Y Combinator Basic Income Experiment) — Texas and Illinois';
UPDATE public.programs
SET
    latitude = 37.769337,
    longitude = -78.169968,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Alexandria Recurring Income for Success and Equity (ARISE)';
UPDATE public.programs
SET
    latitude = 37.769337,
    longitude = -78.169968,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Arlington''s Guarantee';
UPDATE public.programs
SET
    latitude = 37.769337,
    longitude = -78.169968,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Fairfax County Economic Mobility Pilot (FCEMP)';
UPDATE public.programs
SET
    latitude = 37.5407,
    longitude = -77.436,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Richmond Resilience Initiative (RRI)';
UPDATE public.programs
SET
    latitude = 44.045876,
    longitude = -72.710686,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Spectrum Pilots Direct Cash Transfer Program';
UPDATE public.programs
SET
    latitude = 47.400902,
    longitude = -121.490494,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'King County GBI Pilot';
UPDATE public.programs
SET
    latitude = 47.400902,
    longitude = -121.490494,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'South King County Pilot';
UPDATE public.programs
SET
    latitude = 47.400902,
    longitude = -121.490494,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Hummingbird Nest';
UPDATE public.programs
SET
    latitude = 47.400902,
    longitude = -121.490494,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Olympic Community Action Programs GBI Pilot';
UPDATE public.programs
SET
    latitude = 47.6062,
    longitude = -122.3321,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Seattle-Denver Income Maintenance Experiment (SIME/DIME) — Seattle, WA';
UPDATE public.programs
SET
    latitude = 47.2529,
    longitude = -122.4443,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Growing Resilience in Tacoma (GRIT)';
UPDATE public.programs
SET
    latitude = 44.268543,
    longitude = -89.616508,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Madison Guaranteed Income Pilot Program (Madison Forward Fund)';
UPDATE public.programs
SET
    latitude = 38.491226,
    longitude = -80.954453,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Rural Income for Self Empowerment Guaranteed Minimum Income Program (RISE GMI) - Mercer County, West Virginia';
UPDATE public.programs
SET
    latitude = 55.3781,
    longitude = -3.436,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Basic Income for Care Leavers';
UPDATE public.programs
SET
    latitude = 1.3733,
    longitude = 32.2903,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Eight Fort Portal Project';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Novissi';
UPDATE public.programs
SET
    latitude = 40.4637,
    longitude = -3.7492,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'B-MINCOME';
UPDATE public.programs
SET
    latitude = 35.9078,
    longitude = 127.7669,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Basic Income for Farmers';
UPDATE public.programs
SET
    latitude = 35.9078,
    longitude = 127.7669,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Youth Basic Income Program';
UPDATE public.programs
SET
    latitude = 35.9078,
    longitude = 127.7669,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Seoul Stepping Stone Income Project (SSIP)';
UPDATE public.programs
SET
    latitude = 8.4606,
    longitude = -11.7799,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Social Income Sierra Leone';
UPDATE public.programs
SET
    latitude = 52.1326,
    longitude = 5.2913,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Weten wat werkt';
UPDATE public.programs
SET
    latitude = -22.9576,
    longitude = 18.4904,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Basic Income Grant (BIG) Pilot';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Human Development Fund';
UPDATE public.programs
SET
    latitude = 6.4281,
    longitude = -9.4295,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Liberia Basic Income';
UPDATE public.programs
SET
    latitude = -0.0236,
    longitude = 37.9062,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.givedirectly.org/research-on-cash-transfers/']
WHERE name = 'Basic Income Kenya Study';
UPDATE public.programs
SET
    latitude = -0.0236,
    longitude = 37.9062,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html', 'https://www.givedirectly.org/research-on-cash-transfers/']
WHERE name = 'Give Directly';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Maezawa Method Basic Income Social Experiment';
UPDATE public.programs
SET
    latitude = 41.8719,
    longitude = 12.5674,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Reddito di Cittadinanza';
UPDATE public.programs
SET
    latitude = 53.1424,
    longitude = -7.6921,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Basic Income for the Arts';
UPDATE public.programs
SET
    latitude = 32.4279,
    longitude = 53.688,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Targeted Subsidies Reform Act';
UPDATE public.programs
SET
    latitude = 39.8283,
    longitude = -98.5795,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Jamesta Istimewa';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Madhya Pradesh Unconditional Cash Transfers Project';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Shelkui, Maharashtra';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Building Up Lives | Lumpsum Transfers';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Empowering Communities with Unconditional Cash Transfers | Sada, Rajasthan';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Magalir Urimai Thogai Thittam (Women’s Right to Income Scheme)';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Basic Income & Care for Transgender Persons';
UPDATE public.programs
SET
    latitude = 20.5937,
    longitude = 78.9629,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'UBI+';
UPDATE public.programs
SET
    latitude = 51.1657,
    longitude = 10.4515,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'My Basic Income';
UPDATE public.programs
SET
    latitude = 51.1657,
    longitude = 10.4515,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Pilotprojekt Grundeinkommen';
UPDATE public.programs
SET
    latitude = 61.9241,
    longitude = 25.7482,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Finland Basic Income Experiment';
UPDATE public.programs
SET
    latitude = 22.1987,
    longitude = 113.5439,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Wealth Partaking Scheme';
UPDATE public.programs
SET
    latitude = 22.3193,
    longitude = 114.1694,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Scheme $6,000';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'New Leaf Project';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots']
WHERE name = 'Agreements with Young Adults';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME)';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Manitoba Basic Annual Income Experiment (MINCOME) — Winnipeg, MB, Canada';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Ontario Basic Income Pilot';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Ontario Basic Income Pilot — Lindsay, ON, Canada';
UPDATE public.programs
SET
    latitude = 56.1304,
    longitude = -106.3468,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.med.upenn.edu/cgir/research.html']
WHERE name = 'Ontario Basic Income Pilot — Thunder Bay, ON, Canada';
UPDATE public.programs
SET
    latitude = -14.235,
    longitude = -51.9253,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.jainfamilyinstitute.org/research/guaranteed-income-marica-brazil/']
WHERE name = 'Renda Basica de Cidadania (Citizens'' Basic Income Program)';
UPDATE public.programs
SET
    latitude = -14.235,
    longitude = -51.9253,
    sources = ARRAY['https://basicincome.stanford.edu/research/basic-income-experiments/', 'https://guaranteedincome.us/pilots', 'https://www.jainfamilyinstitute.org/research/guaranteed-income-marica-brazil/']
WHERE name = 'Quatinga Velho';