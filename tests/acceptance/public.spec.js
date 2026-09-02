import { expect, test } from "@playwright/test";

test("public home, catalog, and detail pages use local fixtures", async ({ page }) => {
  await page.goto("/");
  await expect(page.getByRole("heading", { name: "Find Income Support Programs" })).toBeVisible();

  await page.goto("/Programs");
  await expect(page.getByRole("heading", { name: "Global UBI Programs Directory" })).toBeVisible();
  await expect(page.getByText("Available Programs", { exact: true })).toBeVisible();
  const firstProgram = page.locator("h3.text-xl").first();
  await expect(firstProgram).toBeVisible();
  const programName = (await firstProgram.textContent())?.trim();
  expect(programName).toBeTruthy();
  await firstProgram.click();
  await expect(page).toHaveURL(/\/program-details$/);
  await expect(page.getByText(programName, { exact: true }).first()).toBeVisible();
});

test("eligibility answers persist across a reload", async ({ page }) => {
  await page.goto("/");
  await page.getByText("Select your country").click();
  await page.getByRole("option", { name: "Germany" }).click();
  await page.getByRole("button", { name: /Continue to Step 2/ }).click();
  await page.getByText("Select gender").click();
  await page.getByRole("option", { name: "Prefer not to disclose" }).click();
  await page.getByText("Select income range").click();
  await page.getByRole("option", { name: "$0 – $20,000" }).click();

  await page.reload();
  await expect(page.getByText("2. Household & Income")).toHaveClass(/text-green-700/);
  const pendingProfile = await page.evaluate(() => JSON.parse(localStorage.getItem("pendingProfile") || "{}"));
  expect(pendingProfile).toMatchObject({
    country: "Germany",
    gender: "abstain",
    income_range: "0-20k",
  });
});
