with open('supabase/migrations/00020_ingest_all_unmatched_stanford_experiments.sql', 'r') as f:
    content = f.read()

# Prepend DELETE FROM public.programs WHERE program_id >= 100;
fixed_content = """-- Migration 00020: Ingest all qualified Stanford experiments
DELETE FROM public.programs WHERE program_id >= 100;

""" + content

with open('supabase/migrations/00020_ingest_all_unmatched_stanford_experiments.sql', 'w') as f:
    f.write(fixed_content)

with open('src/supabase/migrations/00020_ingest_all_unmatched_stanford_experiments.sql', 'w') as f:
    f.write(fixed_content)

print("Added clean DELETE FROM public.programs WHERE program_id >= 100 to migration 00020")
