-- Migration 00010: Geocode all active programs with accurate coordinates and municipalities

UPDATE programs SET
  latitude = '42.0451',
  longitude = '-87.6877',
  municipalities = ARRAY['Evanston']::text[]
WHERE program_id = 1;

UPDATE programs SET
  latitude = '39.2037',
  longitude = '-76.8610',
  municipalities = ARRAY['Howard County', 'Columbia']::text[]
WHERE program_id = 2;

UPDATE programs SET
  latitude = '39.9526',
  longitude = '-75.1652',
  municipalities = ARRAY['Philadelphia']::text[]
WHERE program_id = 3;

UPDATE programs SET
  latitude = '39.9800',
  longitude = '-75.1500',
  municipalities = ARRAY['Philadelphia']::text[]
WHERE program_id = 4;

UPDATE programs SET
  latitude = '43.0125',
  longitude = '-83.6875',
  municipalities = ARRAY['Flint', 'Kalamazoo']::text[]
WHERE program_id = 5;

UPDATE programs SET
  latitude = '34.0195',
  longitude = '-118.4912',
  municipalities = ARRAY['Santa Monica']::text[]
WHERE program_id = 6;

UPDATE programs SET
  latitude = '34.0522',
  longitude = '-118.2437',
  municipalities = ARRAY['Los Angeles']::text[]
WHERE program_id = 7;

UPDATE programs SET
  latitude = '53.3498',
  longitude = '-6.2603',
  municipalities = ARRAY['Dublin', 'Nationwide Ireland']::text[]
WHERE program_id = 8;

UPDATE programs SET
  latitude = '37.4138',
  longitude = '127.5183',
  municipalities = ARRAY['Gyeonggi', 'Gangwon', 'Rural Districts']::text[]
WHERE program_id = 9;

UPDATE programs SET
  latitude = '7.1315',
  longitude = '171.1845',
  municipalities = ARRAY['Majuro', 'Ebeye', 'Outer Islands']::text[]
WHERE program_id = 10;

UPDATE programs SET
  latitude = '61.2181',
  longitude = '-149.9003',
  municipalities = ARRAY['Statewide Alaska', 'Anchorage']::text[]
WHERE program_id = 11;

UPDATE programs SET
  latitude = '22.1987',
  longitude = '113.5439',
  municipalities = ARRAY['Macao']::text[]
WHERE program_id = 12;

UPDATE programs SET
  latitude = '46.8139',
  longitude = '-71.2080',
  municipalities = ARRAY['Quebec City', 'Montreal']::text[]
WHERE program_id = 13;

UPDATE programs SET
  latitude = '45.4215',
  longitude = '-75.6972',
  municipalities = ARRAY['Canada Nationwide', 'Ottawa']::text[]
WHERE program_id = 14;

UPDATE programs SET
  latitude = '40.4168',
  longitude = '-3.7038',
  municipalities = ARRAY['Spain Nationwide', 'Madrid']::text[]
WHERE program_id = 15;

UPDATE programs SET
  latitude = '-25.7479',
  longitude = '28.2293',
  municipalities = ARRAY['South Africa Nationwide', 'Johannesburg']::text[]
WHERE program_id = 16;

UPDATE programs SET
  latitude = '-0.7821',
  longitude = '35.3416',
  municipalities = ARRAY['Bomet', 'Siaya']::text[]
WHERE program_id = 17;

UPDATE programs SET
  latitude = '52.5200',
  longitude = '13.4050',
  municipalities = ARRAY['Berlin', 'Worldwide']::text[]
WHERE program_id = 18;

UPDATE programs SET
  latitude = '37.7749',
  longitude = '-122.4194',
  municipalities = ARRAY['Global / Web3']::text[]
WHERE program_id = 19;

UPDATE programs SET
  latitude = '24.7136',
  longitude = '46.6753',
  municipalities = ARRAY['Saudi Arabia Nationwide', 'Riyadh']::text[]
WHERE program_id = 20;

UPDATE programs SET
  latitude = '32.0853',
  longitude = '34.7818',
  municipalities = ARRAY['Global Protocol', 'Tel Aviv']::text[]
WHERE program_id = 21;

UPDATE programs SET
  latitude = '50.1109',
  longitude = '8.6821',
  municipalities = ARRAY['Eurozone Countries', 'Frankfurt']::text[]
WHERE program_id = 22;

UPDATE programs SET
  latitude = '46.2044',
  longitude = '6.1432',
  municipalities = ARRAY['Global Protocol', 'Geneva']::text[]
WHERE program_id = 23;

UPDATE programs SET
  latitude = '46.0878',
  longitude = '-64.7782',
  municipalities = ARRAY['Moncton', 'Saint John']::text[]
WHERE program_id = 38;
