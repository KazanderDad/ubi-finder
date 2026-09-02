import { supabase } from '@/lib/supabaseClient';

const STORAGE_KEY = 'ubi_supporter_points_v1';

// Point weights
export const POINT_WEIGHTS = {
  PROGRAM_DETAILS_VIEW: 10,
  MAP_VIEW: 20,
  SEARCH_QUERY: 2
};

// Standard Thresholds
export const BASE_THRESHOLDS = {
  SOFT: 40, // 4th program view (40 pts) or 2nd map view (40 pts)
  HARD: 70  // 7th program view (70 pts) or 4th map view (80 pts)
};

// Halved Thresholds for shared IP
export const HALVED_THRESHOLDS = {
  SOFT: 20, // 2nd program view (20 pts) or 1st map view (20 pts)
  HARD: 35  // 4th program view (40 pts) or 2nd map view (40 pts)
};

let cachedIpHash = null;

// Get or generate client IP identifier
export async function getClientIpHash() {
  if (cachedIpHash) return cachedIpHash;
  
  try {
    const stored = localStorage.getItem('ubi_client_ip_hash');
    if (stored) {
      cachedIpHash = stored;
      return stored;
    }

    const res = await fetch('https://api.ipify.org?format=json', { signal: AbortSignal.timeout(2000) });
    if (res.ok) {
      const data = await res.json();
      if (data.ip) {
        // Simple fast non-reversible hash for privacy
        let hash = 0;
        const str = data.ip + '_ubi_salt';
        for (let i = 0; i < str.length; i++) {
          hash = ((hash << 5) - hash) + str.charCodeAt(i);
          hash |= 0;
        }
        cachedIpHash = 'ip_' + Math.abs(hash).toString(36);
        localStorage.setItem('ubi_client_ip_hash', cachedIpHash);
        return cachedIpHash;
      }
    }
  } catch (err) {
    // Fallback to stable client-generated UUID
  }

  let fallback = localStorage.getItem('ubi_client_anon_id');
  if (!fallback) {
    fallback = 'anon_' + Math.random().toString(36).substring(2, 12);
    localStorage.setItem('ubi_client_anon_id', fallback);
  }
  cachedIpHash = fallback;
  return fallback;
}

// Read local state
export function getLocalSupporterState() {
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    if (raw) {
      return JSON.parse(raw);
    }
  } catch (e) {
    // Ignore parse error
  }
  return {
    points: 0,
    programViews: 0,
    mapViews: 0,
    searchQueries: 0,
    encouragementShown: false,
    hasDonated: false,
    totalDonatedUsd: 0,
    isIpHalved: false
  };
}

// Save local state
export function saveLocalSupporterState(state) {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
    window.dispatchEvent(new Event('ubi_supporter_state_changed'));
  } catch (e) {
    // Ignore
  }
}

// Compute supporter tier / category
export function getSupporterCategory(user = null) {
  const local = getLocalSupporterState();
  if (!local.hasDonated && (!local.totalDonatedUsd || local.totalDonatedUsd <= 0)) {
    return {
      category: 'Member',
      badgeClass: 'text-gray-500 bg-gray-100 border-gray-200',
      isSupporter: false,
      amount: 0
    };
  }

  const amount = Number(local.totalDonatedUsd || 0);

  if (amount >= 500) {
    return {
      category: 'Patron',
      badgeClass: 'text-amber-900 bg-amber-100 border-amber-300 font-bold',
      isSupporter: true,
      amount
    };
  } else if (amount >= 50) {
    return {
      category: 'Champion',
      badgeClass: 'text-emerald-900 bg-emerald-100 border-emerald-300 font-bold',
      isSupporter: true,
      amount
    };
  } else if (amount >= 5) {
    return {
      category: 'Supporter',
      badgeClass: 'text-teal-900 bg-teal-100 border-teal-300 font-bold',
      isSupporter: true,
      amount
    };
  } else {
    return {
      category: 'Member+',
      badgeClass: 'text-blue-900 bg-blue-100 border-blue-300 font-bold',
      isSupporter: true,
      amount
    };
  }
}

// Check if IP is shared with another high-usage account
export async function checkIsIpHalved(ipHash, userId) {
  try {
    if (!supabase) return false;
    // Check if any other user record on same IP crossed hard threshold
    const { data } = await supabase
      .from('user_usage_points')
      .select('points_total, user_id')
      .eq('ip_hash', ipHash)
      .gte('points_total', BASE_THRESHOLDS.HARD);

    if (data && data.length > 0) {
      // If there exists a record for a different user on this IP that crossed threshold
      const otherUserGated = data.some(d => d.user_id !== userId);
      return otherUserGated;
    }
  } catch (e) {
    // Graceful fallback
  }
  return false;
}

// Evaluate status
export async function getSupporterStatus(user = null) {
  const local = getLocalSupporterState();
  const ipHash = await getClientIpHash();
  const userId = user?.id || null;

  let isIpHalved = local.isIpHalved;
  if (!isIpHalved && ipHash) {
    isIpHalved = await checkIsIpHalved(ipHash, userId);
    if (isIpHalved !== local.isIpHalved) {
      local.isIpHalved = isIpHalved;
      saveLocalSupporterState(local);
    }
  }

  const softThreshold = isIpHalved ? HALVED_THRESHOLDS.SOFT : BASE_THRESHOLDS.SOFT;
  const hardThreshold = isIpHalved ? HALVED_THRESHOLDS.HARD : BASE_THRESHOLDS.HARD;

  const isGated = !local.hasDonated && local.points >= hardThreshold;
  const shouldEncourage = !local.hasDonated && !local.encouragementShown && local.points >= softThreshold && !isGated;

  return {
    points: local.points,
    programViews: local.programViews,
    mapViews: local.mapViews,
    searchQueries: local.searchQueries,
    encouragementShown: local.encouragementShown,
    hasDonated: local.hasDonated,
    totalDonatedUsd: local.totalDonatedUsd,
    isIpHalved,
    softThreshold,
    hardThreshold,
    isGated,
    shouldEncourage
  };
}

// Record usage action
export async function recordUsageAction(actionType, user = null) {
  const pointsToAdd = POINT_WEIGHTS[actionType] || 0;
  if (pointsToAdd === 0) return await getSupporterStatus(user);

  const local = getLocalSupporterState();
  local.points += pointsToAdd;

  if (actionType === 'PROGRAM_DETAILS_VIEW') local.programViews += 1;
  else if (actionType === 'MAP_VIEW') local.mapViews += 1;
  else if (actionType === 'SEARCH_QUERY') local.searchQueries += 1;

  saveLocalSupporterState(local);

  const ipHash = await getClientIpHash();
  const userId = user?.id || null;

  // Sync with Supabase asynchronously
  if (supabase) {
    (async () => {
      try {
        await supabase.from('user_usage_points').upsert({
          user_id: userId,
          ip_hash: ipHash,
          points_total: local.points,
          program_views_count: local.programViews,
          map_views_count: local.mapViews,
          search_queries_count: local.searchQueries,
          encouragement_shown: local.encouragementShown,
          has_donated: local.hasDonated,
          total_donated_usd: local.totalDonatedUsd,
          last_action_at: new Date().toISOString(),
          updated_at: new Date().toISOString()
        }, { onConflict: 'user_id,ip_hash' });
      } catch (err) {
        // Silently tolerate sync errors
      }
    })();
  }

  return await getSupporterStatus(user);
}

// Mark encouragement as shown
export async function markEncouragementDismissed(user = null) {
  const local = getLocalSupporterState();
  local.encouragementShown = true;
  saveLocalSupporterState(local);

  const ipHash = await getClientIpHash();
  if (supabase) {
    try {
      await supabase.from('user_usage_points').upsert({
        user_id: user?.id || null,
        ip_hash: ipHash,
        encouragement_shown: true,
        updated_at: new Date().toISOString()
      }, { onConflict: 'user_id,ip_hash' });
    } catch (e) {
      // Ignore
    }
  }
}

// Record successful donation and unlock permanently
export async function recordSuccessfulDonation(amountUsd, stripeSessionId = null, user = null) {
  const local = getLocalSupporterState();
  local.hasDonated = true;
  local.totalDonatedUsd = (local.totalDonatedUsd || 0) + Number(amountUsd || 0);
  saveLocalSupporterState(local);

  const ipHash = await getClientIpHash();
  const userId = user?.id || null;
  const userEmail = user?.email || null;

  if (supabase) {
    try {
      // Record donation
      await supabase.from('donations').insert({
        user_id: userId,
        user_email: userEmail,
        ip_hash: ipHash,
        stripe_session_id: stripeSessionId,
        amount_usd: Number(amountUsd || 0),
        status: 'completed'
      });

      // Update points state
      await supabase.from('user_usage_points').upsert({
        user_id: userId,
        ip_hash: ipHash,
        has_donated: true,
        total_donated_usd: local.totalDonatedUsd,
        updated_at: new Date().toISOString()
      }, { onConflict: 'user_id,ip_hash' });
    } catch (e) {
      console.error('Error syncing donation to Supabase:', e);
    }
  }

  return local;
}
