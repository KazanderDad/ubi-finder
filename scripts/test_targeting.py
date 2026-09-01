import re

def parse_targeting(type_target, details):
    combined = f"{type_target or ''} {details or ''}".lower()
    
    min_age = None
    max_age = None
    gender = None
    max_income = None
    
    # Check explicit age patterns first
    range_match = re.search(r'ages?\s*([0-9]{1,2})\s*(?:-|to|–)\s*([0-9]{1,2})', combined)
    older_match = re.search(r'([0-9]{1,2})\s*(?:years?(?:\s*of\s*age)?|\s*yrs?)\s*(?:and|or)\s*(?:older|above|\+)', combined)
    younger_match = re.search(r'under\s*(?:age\s*)?([0-9]{1,2})|([0-9]{1,2})\s*(?:years?(?:\s*of\s*age)?|\s*yrs?)\s*(?:and|or)\s*(?:younger|under)', combined)
    
    if range_match:
        min_age = int(range_match.group(1))
        max_age = int(range_match.group(2))
    elif older_match:
        min_age = int(older_match.group(1))
    elif younger_match:
        val = younger_match.group(1) or younger_match.group(2)
        if val:
            max_age = int(val)
            
    # Keywords fallback
    if min_age is None and max_age is None:
        if 'senior' in combined or 'elderly' in combined or 'older adult' in combined:
            min_age = 60
        elif 'youth' in combined or 'young adult' in combined or 'tay' in combined:
            min_age = 18
            max_age = 24
        elif 'baby' in combined or 'infant' in combined or 'pregnant' in combined or 'maternal' in combined:
            min_age = 18
            max_age = 45

    # Gender
    if re.search(r'\b(female|women|mothers?|pregnant|birthing|maternal)\b', combined):
        gender = 'female'
    elif re.search(r'\b(male|fathers?)\b', combined):
        gender = 'male'
        
    # Income
    if 'fpl' in combined or 'poverty' in combined:
        fpl_match = re.search(r'([0-9]{2,3})%\s*(?:of\s*)?fpl', combined)
        if fpl_match:
            pct = int(fpl_match.group(1))
            max_income = round(15060 * (pct / 100.0) * 2.0)
        else:
            max_income = 40000
    elif 'ami' in combined:
        ami_match = re.search(r'([0-9]{2,3})%\s*(?:of\s*)?ami', combined)
        if ami_match:
            pct = int(ami_match.group(1))
            max_income = round(80000 * (pct / 100.0))
        else:
            max_income = 50000

    return min_age, max_age, gender, max_income

print("Embrace Mothers:", parse_targeting("Individuals", "18 years or older, female identifying as single head of a family with children in the household under 18 years of age"))
