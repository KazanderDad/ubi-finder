import {
  acceptanceUser,
  getLocalAdminClient,
  removeAcceptanceUser,
} from "./support/local-supabase.js";

export default async function globalSetup() {
  const admin = getLocalAdminClient();
  await removeAcceptanceUser(admin);

  const { data, error } = await admin.auth.admin.createUser({
    email: acceptanceUser.email,
    password: acceptanceUser.password,
    email_confirm: true,
    user_metadata: { full_name: acceptanceUser.name },
  });
  if (error || !data.user) throw error || new Error("Acceptance user was not created.");

  const { error: profileError } = await admin.from("user_profiles").insert({
    name: acceptanceUser.name,
    gender: "abstain",
    country: "Canada",
    state: "Ontario",
    currency: "CAD",
    accepts_digital_currency: true,
    accepts_foreign_currency: true,
    household_size: 1,
    income_range: "0-20k",
    created_by_id: data.user.id,
  });
  if (profileError) throw profileError;
}
