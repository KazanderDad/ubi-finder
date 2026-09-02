import { createClient } from "@supabase/supabase-js";

export const acceptanceUser = {
  email: "acceptance.ubi-finder@example.test",
  password: "LocalAcceptance123!",
  name: "Acceptance Tester",
};

export function getLocalAdminClient() {
  const url = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
  const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

  if (!url || !serviceRoleKey) {
    throw new Error(
      "Local acceptance requires VITE_SUPABASE_URL (or SUPABASE_URL) and SUPABASE_SERVICE_ROLE_KEY from the allocated Supabase runtime.",
    );
  }

  const parsed = new URL(url);
  if (!["localhost", "127.0.0.1"].includes(parsed.hostname)) {
    throw new Error(`Refusing to seed a non-local Supabase runtime: ${parsed.origin}`);
  }

  return createClient(url, serviceRoleKey, {
    auth: { autoRefreshToken: false, persistSession: false },
  });
}

export async function findAcceptanceUser(admin) {
  const { data, error } = await admin.auth.admin.listUsers({ perPage: 1000 });
  if (error) throw error;
  return data.users.find((user) => user.email === acceptanceUser.email) || null;
}

export async function removeAcceptanceUser(admin) {
  const existing = await findAcceptanceUser(admin);
  if (!existing) return;
  const { error } = await admin.auth.admin.deleteUser(existing.id);
  if (error) throw error;
}
