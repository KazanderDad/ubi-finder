import json
import re

with open('data/qualified_stanford_programs.json', 'r', encoding='utf-8') as f:
    programs = json.load(f)

from scripts.geocode_and_enrich_all import CITY_COORDINATES, STATE_COORDINATES

COUNTRY_COORDINATES = {
    'Canada': (56.1304, -106.3468),
    'Brazil': (-14.2350, -51.9253),
    'Kenya': (-0.0236, 37.9062),
    'India': (20.5937, 78.9629),
    'South Korea': (35.9078, 127.7669),
    'Germany': (51.1657, 10.4515),
    'Netherlands': (52.1326, 5.2913),
    'Finland': (61.9241, 25.7482),
    'Spain': (40.4637, -3.7492),
    'Italy': (41.8719, 12.5674),
    'Ireland': (53.1424, -7.6921),
    'France': (46.2276, 2.2137),
    'Iran': (32.4279, 53.6880),
    'Sierra Leone': (8.4606, -11.7799),
    'Hong Kong': (22.3193, 114.1694),
    'Namibia': (-22.9576, 18.4904),
    'United Kingdom': (55.3781, -3.4360),
    'Uganda': (1.3733, 32.2903),
    'Liberia': (6.4281, -9.4295),
    'Mexico': (23.6345, -102.5528),
    'Colombia': (4.5709, -74.2973),
    'Global': (0.0, 0.0)
}

sql_lines = []
sql_lines.append("-- Migration 00021: Geocode and Enrich all Stanford Basic Income Lab Programs with Coordinates, Sources & Web Metadata\n")

for p in programs:
    name_esc = p['name'].replace("'", "''")
    
    # 1. Coordinate Resolution
    lat, lng = None, None
    for m in p['municipalities']:
        for city, coords in CITY_COORDINATES.items():
            if city.lower() in m.lower():
                lat, lng = coords
                break
        if lat:
            break
            
    if not lat:
        for s in p['required_states']:
            if s in STATE_COORDINATES:
                lat, lng = STATE_COORDINATES[s]
                break
                
    if not lat:
        for r in p['available_regions']:
            if r in COUNTRY_COORDINATES:
                lat, lng = COUNTRY_COORDINATES[r]
                break
                
    if not lat:
        lat, lng = (39.8283, -98.5795) # Center of US default
        
    # 2. Source URLs & Citations
    sources = [
        "https://basicincome.stanford.edu/research/basic-income-experiments/",
        "https://guaranteedincome.us/pilots"
    ]
    
    if p['is_rct']:
        sources.append("https://www.med.upenn.edu/cgir/research.html")
    if 'Brazil' in p['available_regions']:
        sources.append("https://www.jainfamilyinstitute.org/research/guaranteed-income-marica-brazil/")
    if 'Kenya' in p['available_regions']:
        sources.append("https://www.givedirectly.org/research-on-cash-transfers/")
        
    sources_sql = "ARRAY[" + ", ".join(f"'{s}'" for s in sources) + "]"
    
    sql = f"""
UPDATE public.programs
SET
    latitude = {lat},
    longitude = {lng},
    sources = {sources_sql}
WHERE name = '{name_esc}';
"""
    sql_lines.append(sql.strip())

output_sql = "\n".join(sql_lines)

with open('supabase/migrations/00021_enrich_stanford_programs_with_research_and_geo.sql', 'w', encoding='utf-8') as f:
    f.write(output_sql)

with open('src/supabase/migrations/00021_enrich_stanford_programs_with_research_and_geo.sql', 'w', encoding='utf-8') as f:
    f.write(output_sql)

print(f"Generated enrichment migration 00021 with {len(programs)} program updates!")
