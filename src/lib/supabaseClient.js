import { createClient } from '@supabase/supabase-js';

const envUrl = import.meta.env.VITE_SUPABASE_URL;
const envKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!envUrl || !envKey) {
  throw new Error(
    'Supabase configuration is incomplete. Set VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY for the selected Vite mode.',
  );
}

export const supabase = createClient(envUrl, envKey);
