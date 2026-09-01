import { getLocalAdminClient, removeAcceptanceUser } from "./support/local-supabase.js";

export default async function globalTeardown() {
  await removeAcceptanceUser(getLocalAdminClient());
}
