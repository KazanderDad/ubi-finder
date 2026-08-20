import { createClient } from '@supabase/supabase-js';

// Detect if we are running in the browser and whether it's local development
const isBrowser = typeof window !== 'undefined';
const isLocalhost = isBrowser && (
  window.location.hostname === 'localhost' ||
  window.location.hostname === '127.0.0.1' ||
  window.location.hostname.endsWith('.local')
);

const envUrl = import.meta.env.VITE_SUPABASE_URL;
const envKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

// Default production remote project
const CLOUD_SUPABASE_URL = 'https://oinubdnkqnifeaaejmjl.supabase.co';

// Prevent public HTTPS deployments (e.g. Vercel) from attempting to connect to 127.0.0.1 / localhost,
// which triggers the macOS / Chrome "Access other apps and services on this device" Local Network permission dialog.
let resolvedUrl = envUrl;
if (isBrowser && !isLocalhost && (!envUrl || envUrl.includes('127.0.0.1') || envUrl.includes('localhost'))) {
  resolvedUrl = CLOUD_SUPABASE_URL;
} else if (!resolvedUrl) {
  resolvedUrl = isLocalhost ? 'http://127.0.0.1:54321' : CLOUD_SUPABASE_URL;
}

const resolvedKey = envKey || 'sb_publishable_placeholder';

export const supabase = createClient(resolvedUrl, resolvedKey);
