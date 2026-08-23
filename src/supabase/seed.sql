-- =====================================================================
-- UBI Finder — seed.sql
-- Seed data for programs, blog_posts, and community tables.
-- =====================================================================

-- =====================================================================
-- PROGRAMS (58 rows)
-- =====================================================================
INSERT INTO programs
 (program_id, name, organization, description, gender_requirement,
  monthly_amount_usd, currency, available_regions, required_states,
  payment_method, amount_description, max_household_income_usd, eligibility,
  status, website, verified, submitter_email,
  payout_status, application_status, apply_url, sources, internal_status,
  distribution_type, payout_rail, funding_source, state_province, municipalities,
  latitude, longitude)
VALUES
  (1, 'Evanston Guaranteed Income Program 2026', 'City of Evanston',
   'This program provides 102 qualifying Evanston households with $500 per month in unrestricted cash for six months. It targets low-income seniors and families caring for young children, with participants selected by lottery.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Illinois']::text[],
   'standard', '$500 per month for 6 months', NULL,
   '• Resident of Evanston
• Household income at or below 185% of the federal poverty level
• Age 55 or older, or full-time guardian of a child in second grade or younger
• One application per household
• Must not have participated in a previous Evanston guaranteed income program',
   'active', 'https://www.cityofevanston.org/residents/community_resources/guaranteed_income_program_2026.php', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://www.cityofevanston.org/residents/community_resources/guaranteed_income_program_2026.php',
   ARRAY['https://www.cityofevanston.org/residents/community_resources/guaranteed_income_program_2026.php']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'IL', ARRAY['Evanston', 'Cook County']::text[],
   42.0451, -87.6877),

  (2, 'Howard County Guaranteed Basic Income 2', 'Howard County Government and Community Action Council of Howard County',
   'The second Howard County Guaranteed Basic Income program provides participating families with $500 per month in unrestricted cash for 12 months. An additional $500 per month is deposited into savings and released after participants complete financial-literacy requirements.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Maryland']::text[],
   'standard', '$500 per month for 12 months (plus $500 monthly savings deposit)', NULL,
   '• Resident of Howard County
• At least one child age 17 or younger in the household
• Household income between 150% and 300% of the federal poverty level
• Must not receive income-based housing assistance
• Must attend required Community Action Council meetings
• Must complete financial-literacy education',
   'active', 'https://cac-hc.org/gbi2/', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://cac-hc.org/gbi2/',
   ARRAY['https://cac-hc.org/gbi2/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'MD', ARRAY['Howard County', 'Columbia']::text[],
   39.2037, -76.861),

  (3, 'Healthy Mama, Healthy Baby', 'The Neighbors Trust and Puentes de Salud',
   'Healthy Mama, Healthy Baby provides $8,000 in unconditional cash over 18 months to selected prenatal patients in Philadelphia. It focuses primarily on low-income Latina mothers, including patients who cannot obtain health insurance, and distributes the funds through a debit card.',
   'female', 444.44, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$8,000 distributed over 18 months (~$444.44 monthly)', NULL,
   '• Prenatal patient served by Puentes de Salud
• Pregnant
• Selected through the program''s enrollment process
• Priority given to low-income Latina patients and people without health-insurance access',
   'active', 'https://www.neighborstrust.org/program', true, NULL,
   'Ongoing', 'Referral enrollment only', 'https://www.neighborstrust.org/program',
   ARRAY['https://www.neighborstrust.org/program', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'PA', ARRAY['Philadelphia']::text[],
   39.9526, -75.1652),

  (4, 'Philly Joy Bank', 'Philadelphia Department of Public Health and Philadelphia City Fund',
   'The Philly Joy Bank provides pregnant Philadelphia residents with $1,000 per month from the second trimester of pregnancy through the child''s first birthday. The program is designed to improve birth outcomes and address racial and geographic disparities in infant mortality.',
   NULL, 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$1,000 per month during pregnancy and child''s first year', 100000.0,
   '• Age 18 or older
• Between 12 and 24 weeks pregnant at enrollment
• Annual household income below 100000 USD
• Resident of an eligible Philadelphia neighborhood
• Eligible neighborhoods include Nicetown-Tioga, Strawberry Mansion, and the qualifying portion of Cobbs Creek',
   'active', 'https://www.phillyjoybank.org/', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://www.phillyjoybank.org/',
   ARRAY['https://philacityfund.org/programs/philly-joy-bank/', 'https://www.phillyjoybank.org/', 'https://www.phillyjoybank.org/faqs']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'PA', ARRAY['Philadelphia']::text[],
   39.9526, -75.1652),

  (5, 'Rx Kids', 'Michigan State University Rx Kids and GiveDirectly',
   'Rx Kids provides unconditional cash to pregnant mothers and families with infants in participating communities, without an income test. Enrolled families generally receive a $1,500 prenatal payment followed by $500 per month for six to twelve months, depending on the community.',
   'female', 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Michigan']::text[],
   'standard', '$1,500 prenatal grant plus $500 per month for 6 to 12 months', NULL,
   '• Resident of a currently participating community
• At least 16 weeks pregnant or caring for an infant within the local enrollment-age limit
• Child must meet the participating community''s birth-date requirements
• Must verify identity, residence, pregnancy, or birth as applicable
• No income requirement',
   'active', 'https://rxkids.aidkit.org/', true, NULL,
   'Ongoing', 'Accepting applications', 'https://rxkids.aidkit.org/',
   ARRAY['https://rxkids.org/', 'https://rxkids.org/communities/', 'https://rxkids.aidkit.org/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'MI', ARRAY['Flint', 'Genesee County']::text[],
   43.0125, -83.6875),

  (6, 'Preserving Our Diversity', 'City of Santa Monica',
   'Preserving Our Diversity provides monthly cash assistance to low-income, long-term senior renters living in rent-controlled Santa Monica apartments. Benefits vary according to household circumstances, with the maximum for a one-senior household listed at $939 per month.',
   NULL, 939.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California']::text[],
   'standard', 'Up to $939 per month based on household circumstances', NULL,
   '• Age 65 or older
• Resident of Santa Monica
• Must have occupied the current rent-controlled apartment since before January 1, 2010
• Income at or below the applicable very-low-income limit
• Must not already live in subsidized or income-restricted housing
• Income remaining after rent must fall below the program standard',
   'active', 'https://www.santamonica.gov/housing-pod', true, NULL,
   'Ongoing for enrolled participants', 'Accepting waitlist applications', 'https://www.santamonica.gov/housing-pod',
   ARRAY['https://www.santamonica.gov/housing-pod', 'https://www.santamonica.gov/housing-pod-faqs']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'CA', ARRAY['Santa Monica']::text[],
   34.0195, -118.4912),

  (7, 'Supporting Transitional-Aged Youth and Survivors in Achieving Financial Empowerment Los Angeles', 'City of Los Angeles Community Investment for Families Department',
   'STAY SAFE Los Angeles provides unconditional cash to transitional-aged youth and survivors of intimate-partner violence who are connected to designated community organizations. Participants receive a total of $24,000, generally structured as $1,000 per month, with an alternative front-loaded payment option for some participants.',
   NULL, 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California']::text[],
   'standard', '$24,000 total (structured as $1,000 per month)', NULL,
   '• Age 18 or older
• Resident of the City of Los Angeles
• Transitional-aged youth or survivor of intimate-partner violence
• Existing relationship with an approved community-based partner
• Must complete enrollment through a participating partner',
   'active', 'https://communityinvestment.lacity.gov/programs-resources', true, NULL,
   'Ongoing', 'Partner referral only', 'https://communityinvestment.lacity.gov/programs-resources',
   ARRAY['https://communityinvestment.lacity.gov/programs-resources', 'https://cityclerk.lacity.org/onlinedocs/2021/21-0717-S3_rpt_cao_06-04-25.pdf', 'https://lasentinel.net/price-leads-new-stay-safe-guaranteed-income-expansion.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'CA', ARRAY['Los Angeles']::text[],
   34.0522, -118.2437),

  (8, 'Basic Income for the Arts Scheme 2026-2029', 'Government of Ireland Department of Culture, Communications and Sport',
   'Ireland''s new Basic Income for the Arts scheme will provide 2,000 professional artists and creative-arts workers with EUR 325 per week for three years. The program is intended to support sustained artistic practice and generate further evidence about the effects of basic income in the cultural sector.',
   NULL, 1640.0, 'EUR',
   ARRAY['Ireland']::text[],
   ARRAY[]::text[],
   'standard', 'EUR 325 per week for 3 years (~$1,640 USD monthly)', NULL,
   '• Age 18 or older
• Professional practicing artist or creative-arts worker
• Primarily based in the Republic of Ireland
• Must provide evidence of professional artistic practice
• Must meet tax-compliance requirements',
   'upcoming', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-guidelines-for-application/', true, NULL,
   'Planned to begin by the end of 2026 and backdated to September 2026', 'No longer accepting applications', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-guidelines-for-application/',
   ARRAY['https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-guidelines-for-application/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-faq/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/press-releases/minister-odonovan-announces-the-new-basic-income-for-the-arts-scheme/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Leinster', ARRAY['Dublin', 'Nationwide']::text[],
   53.3498, -6.2603),

  (9, 'Rural Basic Income Pilot Programme', 'Republic of Korea Ministry of Agriculture, Food and Rural Affairs',
   'South Korea''s rural basic-income pilot pays residents of ten participating counties KRW 150,000 per month in locally usable currency during 2026 and 2027. The program seeks to address rural depopulation, strengthen household stability, and stimulate local economic activity.',
   NULL, 107.0, 'KRW',
   ARRAY['South Korea']::text[],
   ARRAY['Gyeonggi', 'Gangwon', 'North Chungcheong', 'South Chungcheong', 'North Jeolla', 'South Jeolla', 'North Gyeongsang', 'South Gyeongsang']::text[],
   'standard', 'KRW 150,000 per month in local currency (~$107 USD monthly)', NULL,
   '• Registered resident of one of the ten participating counties
• Must actually reside in the participating county
• Residents with uncertain residence may need to demonstrate presence at least three days per week
• New residents may need to complete a 90-day residence-verification period',
   'active', 'https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG', true, NULL,
   'Ongoing', 'Accepting local applications and residence verification', 'https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG',
   ARRAY['https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Gyeonggi', ARRAY['Participating Counties']::text[],
   37.4138, 127.5183),

  (10, 'ENRA Universal Basic Income Program', 'Republic of the Marshall Islands Ministry of Finance',
   'ENRA distributes quarterly, unconditional payments to eligible Marshallese citizens residing in the Marshall Islands. The long-term program is funded through Compact-related revenue and is expected to continue for approximately two decades, with the listed monthly value representing the equivalent of a roughly $200 quarterly payment.',
   NULL, 66.67, 'USD',
   ARRAY['Marshall Islands']::text[],
   ARRAY[]::text[],
   'standard', 'Equivalent of ~$200 USD quarterly (~$66.67 USD monthly)', NULL,
   '• Marshallese citizen
• Resident of the Republic of the Marshall Islands
• Must enroll and maintain eligibility through the Marshall Islands Social Security Administration
• Must satisfy identity and residency verification requirements',
   'active', 'https://mof.gov.mh/usdm1/enra/', true, NULL,
   'Ongoing quarterly', 'Accepting enrollment through MISSA', 'https://mof.gov.mh/usdm1/enra/',
   ARRAY['https://mof.gov.mh/usdm1/enra/', 'https://mof.gov.mh/usdm1-whitepaper/', 'https://marshallislandsjournal.com/enra-bump-up/', 'https://eastasiaforum.org/2026/01/07/the-price-of-the-marshall-islands-universal-basic-income/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Majuro', ARRAY['Majuro', 'Nationwide']::text[],
   7.1315, 171.1845),

  (11, 'Alaska Permanent Fund Dividend 2026', 'State of Alaska Permanent Fund Dividend Division',
   'The Alaska Permanent Fund Dividend distributes an annual cash payment to qualifying residents from state mineral-revenue investment earnings. The 2026 payment was set at a combined $1,200, including the dividend and energy rebate, which is shown here as a $100 monthly equivalent.',
   NULL, 100.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Alaska']::text[],
   'standard', '$1,200 annual payment (~$100 USD monthly equivalent)', NULL,
   '• Alaska resident throughout calendar year 2025
• Intent to remain an Alaska resident indefinitely
• Must not have claimed residency in another state or country after December 31, 2024
• Must satisfy allowable-absence rules
• Must satisfy applicable criminal-conviction and incarceration restrictions
• Must meet the required physical-presence test',
   'active', 'https://pfd.alaska.gov/', true, NULL,
   'Scheduled for October 2026', 'No longer accepting applications', 'https://pfd.alaska.gov/',
   ARRAY['https://pfd.alaska.gov/', 'https://pfd.alaska.gov/eligibility/eligibility-requirements', 'https://pfd.alaska.gov/application/filing-period', 'https://alaskabeacon.com/2026/05/18/alaska-lawmakers-reach-budget-deal-with-1000-pfd-and-200-energy-rebate-for-residents/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'AK', ARRAY['Statewide']::text[],
   64.2008, -149.4937),

  (12, 'Macao Wealth Partaking Scheme 2026', 'Government of the Macao Special Administrative Region',
   'The Wealth Partaking Scheme distributes an annual cash payment to qualifying Macao residents, with permanent residents receiving MOP 10,000 in 2026. The listed monthly amount is the approximate monthly equivalent of that annual payment, while residents with qualifying absences may submit an exception claim.',
   NULL, 104.0, 'MOP',
   ARRAY['China']::text[],
   ARRAY['Macao Special Administrative Region']::text[],
   'standard', 'MOP 10,000 annual payment (~$104 USD monthly equivalent)', NULL,
   '• Holder of a valid or renewable Macao resident identity card
• Permanent-resident payment requires permanent resident status
• Generally present in Macao for at least 183 days during 2025
• Residents below the 183-day threshold must qualify for an approved exemption',
   'active', 'https://www.planocp.gov.mo/en/request/atleast183_2026', true, NULL,
   '2026 standard distribution completed; approved exception claims continue', 'Automatic for listed residents; residence-exception claims accepted', 'https://www.planocp.gov.mo/en/request/atleast183_2026',
   ARRAY['https://www.planocp.gov.mo/en/about/intro', 'https://www.planocp.gov.mo/en/timetable', 'https://www.planocp.gov.mo/en/faq', 'https://www.planocp.gov.mo/en/request/atleast183_2026']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Macao', ARRAY['Macao SAR']::text[],
   22.1987, 113.5439),

  (13, 'Québec Basic Income Program', 'Government of Québec',
   'Québec''s Basic Income Program provides an enhanced monthly income to people with severe and persistent health-related employment limitations. Eligible Social Solidarity recipients are generally enrolled automatically, and the 2026 base benefit is CAD 1,336 per month before possible adjustments.',
   NULL, 961.0, 'CAD',
   ARRAY['Canada']::text[],
   ARRAY['Quebec']::text[],
   'standard', 'CAD 1,336 per month base benefit (~$961 USD monthly)', NULL,
   '• Recipient of Québec''s Social Solidarity Program
• Severe employment limitations
• Must have had severe employment limitations for at least 66 of the previous 72 months
• Must continue satisfying applicable income and asset rules',
   'active', 'https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program', true, NULL,
   'Ongoing', 'Automatic enrollment', 'https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program',
   ARRAY['https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program', 'https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates-lookup/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'QC', ARRAY['Province-wide']::text[],
   46.8139, -71.208),

  (14, 'Guaranteed Income Supplement', 'Government of Canada',
   'The Guaranteed Income Supplement is a monthly, tax-free payment for low-income seniors who receive the Old Age Security pension. The maximum payment for a single, widowed, or divorced recipient is approximately CAD 1,123.17 per month, although the actual amount depends on income and marital status.',
   NULL, 808.0, 'CAD',
   ARRAY['Canada']::text[],
   ARRAY[]::text[],
   'standard', 'Up to CAD 1,123.17 per month (~$808 USD monthly)', NULL,
   '• Age 65 or older
• Receives or is eligible for the Old Age Security pension
• Annual income below the applicable threshold
• Must satisfy Old Age Security residence requirements
• Must file annual income-tax returns to maintain accurate benefit calculations',
   'active', 'https://www.canada.ca/en/services/benefits/publicpensions/old-age-security/guaranteed-income-supplement.html', true, NULL,
   'Ongoing', 'Automatic enrollment or accepting applications', 'https://www.canada.ca/en/services/benefits/publicpensions/old-age-security/guaranteed-income-supplement.html',
   ARRAY['https://www.canada.ca/en/services/benefits/publicpensions/old-age-security/guaranteed-income-supplement.html', 'https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates-lookup/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'ON', ARRAY['Nationwide']::text[],
   45.4215, -75.6972),

  (15, 'Ingreso Mínimo Vital', 'Government of Spain Social Security Administration',
   'Ingreso Mínimo Vital is a national minimum-income benefit intended to prevent poverty and social exclusion among financially vulnerable individuals and households. In 2026, the guaranteed benchmark for a single adult is EUR 733.60 per month, with the actual payment calculated as the difference between the benchmark and countable household income.',
   NULL, 851.0, 'EUR',
   ARRAY['Spain']::text[],
   ARRAY[]::text[],
   'standard', 'EUR 733.60 per month single-adult benchmark (~$851 USD monthly)', NULL,
   '• Legal and effective residence in Spain
• Generally at least one year of continuous residence, subject to exceptions
• Household income below the applicable guaranteed-income threshold
• Household assets below the applicable limit
• Individual applicants are generally age 23 or older, subject to exceptions
• Must satisfy household-formation and economic-vulnerability rules',
   'active', 'https://imv.seg-social.es/', true, NULL,
   'Ongoing', 'Accepting applications', 'https://imv.seg-social.es/',
   ARRAY['https://www.seg-social.es/wps/portal/wss/internet/Trabajadores/PrestacionesPensionesTrabajadores/65850d68-8d06-4645-bde7-05374ee42ac7', 'https://imv.seg-social.es/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Madrid', ARRAY['Nationwide']::text[],
   40.4168, -3.7038),

  (16, 'Social Relief of Distress Grant', 'South African Social Security Agency',
   'South Africa''s Social Relief of Distress Grant provides ZAR 370 per month to working-age people with insufficient income or financial support. The national benefit has been extended through March 2027 and uses recurring income and identity checks to determine monthly eligibility.',
   NULL, 23.0, 'ZAR',
   ARRAY['South Africa']::text[],
   ARRAY[]::text[],
   'standard', 'ZAR 370 per month (~$23 USD monthly)', NULL,
   '• Age 18 to 59
• South African citizen, permanent resident, refugee, asylum seeker, or qualifying special-permit holder
• Currently residing in South Africa
• Insufficient financial means under the program''s monthly assessment
• Must not receive a disqualifying social grant or other overlapping public support
• Must consent to identity, bank-account, and income verification',
   'active', 'https://srd.sassa.gov.za/', true, NULL,
   'Ongoing through March 2027', 'Accepting applications', 'https://srd.sassa.gov.za/',
   ARRAY['https://srd.sassa.gov.za/', 'https://srd.sassa.gov.za/said', 'https://www.sanews.gov.za/south-africa/public-comment-sought-special-covid-19-srd-amendments', 'https://www.sanews.gov.za/south-africa/social-grants-increase']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Gauteng', ARRAY['Nationwide']::text[],
   -25.7479, 28.2293),

  (17, 'GiveDirectly 12-Year Universal Basic Income Study', 'GiveDirectly',
   'GiveDirectly''s long-term Kenya study provides selected adults with approximately $22.50 per month for 12 years, making it one of the longest-running randomized basic-income experiments. Payments are unconditional and delivered through mobile money to eligible adults in selected rural villages.',
   NULL, 22.5, 'KES',
   ARRAY['Kenya']::text[],
   ARRAY[]::text[],
   'standard', 'Approximately $22.50 USD per month for 12 years', NULL,
   '• Adult resident of a village selected for the long-term treatment group
• Must have been enrolled during the original village census and enrollment period
• Must maintain access to the registered mobile-money payment channel
• No work, spending, or repayment conditions',
   'active', 'https://www.givedirectly.org/ubi', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://www.givedirectly.org/ubi',
   ARRAY['https://www.givedirectly.org/ubi', 'https://www.givedirectly.org/2023-ubi-results']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Siaya', ARRAY['Bondo', 'Ugunja']::text[],
   -0.7821, 35.3416),

  (18, 'Mein Grundeinkommen Basic Income Raffle', 'Mein Grundeinkommen e.V.',
   'Mein Grundeinkommen uses crowdfunding to award unconditional basic incomes through free public raffles. Each winner receives EUR 1,000 per month for one year, and participation is open internationally subject to the organization''s registration and raffle rules.',
   NULL, 1161.0, 'EUR',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'standard', 'EUR 1,000 per month for 1 year (~$1,161 USD monthly)', NULL,
   '• Create a Mein Grundeinkommen account
• Register for or confirm participation in an upcoming raffle
• Comply with the raffle terms and identity-verification requirements
• No income or employment requirement',
   'active', 'https://www.mein-grundeinkommen.de/verlosung', true, NULL,
   'Ongoing', 'Accepting raffle entries', 'https://www.mein-grundeinkommen.de/verlosung',
   ARRAY['https://www.mein-grundeinkommen.de/', 'https://www.mein-grundeinkommen.de/verlosung', 'https://www.mein-grundeinkommen.de/infos/in-english', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Berlin', ARRAY['Berlin', 'Global']::text[],
   52.52, 13.405),

  (19, 'World WLD Airdrop Program', 'World Foundation',
   'World distributes recurring WLD token grants to eligible proof-of-human participants who enrolled in an airdrop cycle before the June 2026 cutoff. Existing cycles continue for up to 12 months, but installment sizes decline over time and vary by verification status and cycle.',
   NULL, 0.59, 'WLD',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'digital', 'Recurring WLD token grants (~$0.59 USD monthly equivalent)', NULL,
   '• Must be located in an eligible jurisdiction
• Must hold an eligible World account
• Must satisfy the applicable proof-of-human verification requirement
• Must have enrolled in an airdrop cycle before June 1, 2026
• Must claim each available installment within the applicable claim period',
   'active', 'https://support.world.org/hc/en-us/articles/30969185598739-Updates-to-the-Airdrop-Program', true, NULL,
   'Ongoing for existing cycles', 'No longer accepting new cycles', 'https://support.world.org/hc/en-us/articles/30969185598739-Updates-to-the-Airdrop-Program',
   ARRAY['https://support.world.org/hc/en-us/articles/30969185598739-Updates-to-the-Airdrop-Program', 'https://whitepaper.world.org/designing-for-scale/2026-03-24', 'https://www.kraken.com/prices/worldcoin']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Global', ARRAY['Global']::text[],
   35.0, -20.0),

  (20, 'Citizen Account Program', 'Government of Saudi Arabia Ministry of Human Resources and Social Development',
   'Saudi Arabia''s Citizen Account Program provides monthly cash support to eligible households to offset the effects of economic reforms and changes in living costs. Payment amounts vary by household income and composition, with a reported average family payment of approximately SAR 1,474 in early 2026.',
   NULL, 393.0, 'SAR',
   ARRAY['Saudi Arabia']::text[],
   ARRAY[]::text[],
   'standard', 'Average SAR 1,474 per month (~$393 USD monthly)', NULL,
   '• Saudi citizen or otherwise within an expressly eligible beneficiary category
• Resident of Saudi Arabia
• Household or independent-individual status must be verified
• Income and assets must fall within the program''s eligibility calculations
• Must disclose household composition and income information
• Must maintain accurate information through the Citizen Account portal',
   'active', 'https://eservices.ca.gov.sa/', true, NULL,
   'Ongoing', 'Accepting registrations', 'https://eservices.ca.gov.sa/',
   ARRAY['https://www.hrsd.gov.sa/en/care-about-you/social-protection', 'https://www.hrsd.gov.sa/en/media-center/news/%D9%85%D9%86%D8%B8%D9%88%D9%85%D8%A9-%D8%A7%D9%84%D9%85%D9%88%D8%A7%D8%B1%D8%AF-%D8%A7%D9%84%D8%A8%D8%B4%D8%B1%D9%8A%D8%A9-%D8%AD%D9%82%D9%82%D8%AA-70-%D9%85%D9%86-%D9%85%D8%B3%D8%AA%D9%87%D8%AF%D9%81%D8%A7%D8%AA%D9%87%D8%A7', 'https://eservices.ca.gov.sa/', 'https://www.middleeastmonitor.com/20260112-9-8-million-saudis-receive-cash-support/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Riyadh', ARRAY['Nationwide']::text[],
   24.7136, 46.6753),

  (21, 'GoodDollar', 'GoodDollar Foundation & GoodDAO',
   'GoodDollar is a decentralized, reserve-backed crypto basic income protocol and DAO. It generates yield through DeFi protocols and distributes daily G$ basic income directly to verified unique humans globally via smart contracts on Celo and Ethereum networks.',
   NULL, 10.0, 'G$',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'digital', 'Daily free G$ claims via GoodWallet (approx. $5–$15 USD/mo)', NULL,
   '• Unique human verification via FaceTec 3D liveness check
• Compatible Web3 wallet (GoodWallet / Celo / Ethereum)
• Claimable once every 24 hours
• No minimum income, location, or citizenship restriction',
   'active', 'https://wallet.gooddollar.org', true, NULL,
   'Ongoing daily', 'Accepting registrations', 'https://wallet.gooddollar.org',
   ARRAY['https://www.gooddollar.org', 'https://dashboard.gooddollar.org', 'https://docs.gooddollar.org']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Global', ARRAY['Global']::text[],
   32.0853, 34.7818),

  (22, 'European Digital Euro Pilot', 'European Central Bank & Eurosystem',
   'The European Digital Euro initiative is the ECB''s official framework and preparatory testing phase exploring a digital euro central bank digital currency (CBDC) to complement cash, strengthen European monetary sovereignty, and enable universal, instant digital payment rails for euro area residents.',
   NULL, 47.0, 'EUR',
   ARRAY['Germany', 'France', 'Spain', 'Italy', 'Ireland', 'Netherlands', 'Belgium', 'Austria', 'Portugal', 'Finland', 'Greece']::text[],
   ARRAY[]::text[],
   'digital', '43 EUR (~$47 USD) testing allowance benchmark', NULL,
   '• Resident of a participating Eurozone member state
• Euro-denominated payment account with a licensed European Payment Service Provider (PSP)
• Identity verification satisfying EU AML/KYC requirements
• Participation subject to ECB pilot cohort selection',
   'upcoming', 'https://www.ecb.europa.eu/paym/digital_euro/', true, NULL,
   'Planned for 2027 testing phase', 'Not open yet / Institutional pilot', 'https://www.ecb.europa.eu/paym/digital_euro/',
   ARRAY['https://www.ecb.europa.eu/paym/digital_euro/', 'https://www.centralbank.ie/consumer-hub/digital-euro']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Hesse', ARRAY['Eurozone']::text[],
   50.1109, 8.6821),

  (23, 'FundLoop', 'FundLoop Network',
   'FundLoop is a monthly networked economy for shared prosperity. Participating software projects pool a recurring percentage of revenue, verified contributors prove personhood via CUBID.me, and each monthly epoch automatically distributes and accounts for claimable Citizen Salary awards.',
   NULL, 25.0, 'USD',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'digital', 'Monthly revenue-share distribution based on contribution & participation', NULL,
   '• Connect CUBID.me to prove uniqueness and personhood without exposing private identity
• Participate in or contribute to one or more participating network projects
• Active account in good standing during the open epoch cycle
• Open to all verified individuals worldwide',
   'active_open', 'https://fundloop-website.vercel.app/en', true, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting registrations', 'https://fundloop-website.vercel.app/en',
   ARRAY['https://fundloop-website.vercel.app/en', 'https://fundloop.org']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'Global', ARRAY['Global']::text[],
   37.7749, -122.4194),

  (24, 'Community Support Initiative', 'Regional Development Council',
   'Quarterly support payments for local residents',
   NULL, 123.0, 'USD',
   ARRAY['Australia', 'New Zealand']::text[],
   ARRAY[]::text[],
   'standard', '123 per month', NULL,
   'Local residents meeting income criteria',
   'active', 'https://example.com/program2', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/program2',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (25, 'Digital Income Project', 'Future Foundation',
   'Monthly digital currency payments for eligible participants',
   NULL, 234.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California', 'New York']::text[],
   'digital', '234 per month', 40000.0,
   'Must be a resident of CA or NY',
   'active', 'https://example.com/digital-income', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/digital-income',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (26, 'Global Basic Income', 'World UBI Initiative',
   'Worldwide basic income program with flexible payment options',
   NULL, 329.0, 'USD',
   ARRAY[]::text[],
   ARRAY[]::text[],
   'both', '345', NULL,
   'Open to all globally',
   'upcoming', 'https://example.com/global-ubi', true, NULL,
   'Planned', 'Not open yet', 'https://example.com/global-ubi',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (27, 'Women''s Empowerment Fund', 'Global Women''s Initiative',
   'Supporting women through monthly basic income',
   'female', 800.0, 'USD',
   ARRAY['United States', 'Canada', 'United Kingdom']::text[],
   ARRAY[]::text[],
   'both', '$800 monthly', 50000.0,
   'Women in eligible countries',
   'active', 'https://example.com/wef', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/wef',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (28, 'Youth Basic Income', 'Future Foundation',
   'Basic income for young adults',
   NULL, 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California', 'New York']::text[],
   'digital', '$1,000 monthly', 30000.0,
   '18-25 year olds in CA or NY',
   'active', 'https://example.com/ybi', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/ybi',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (29, 'Digital Income Project (Duplicate)', 'Future Economy Foundation',
   'A pilot program providing monthly digital currency payments to residents in select urban areas.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California', 'New York']::text[],
   'digital', '$500 monthly in digital currency', NULL,
   NULL,
   'active', 'https://example.com/digital-income', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/digital-income',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (30, 'Community Support Initiative (Duplicate)', 'Regional Development Coalition',
   'Providing basic income to support local community resilience and economic development.',
   NULL, 650.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Michigan', 'Ohio', 'Pennsylvania']::text[],
   'standard', '$650 monthly via direct deposit', NULL,
   NULL,
   'active', 'https://example.com/community-support', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/community-support',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (31, 'Rural Resilience Program', 'Agricultural Futures Institute',
   'Supporting rural communities with monthly income supplements to address economic challenges in agricultural regions.',
   NULL, 450.0, 'USD',
   ARRAY['United States', 'Canada']::text[],
   ARRAY[]::text[],
   'both', '$450 monthly with payment options', NULL,
   NULL,
   'active', 'https://example.com/rural-resilience', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/rural-resilience',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (32, 'Youth Opportunity Fund', 'Next Generation Alliance',
   'Providing financial support to young adults ages 18-24 to pursue education, training, or entrepreneurship.',
   NULL, 800.0, 'USD',
   ARRAY['United Kingdom', 'Canada']::text[],
   ARRAY[]::text[],
   'standard', '$800 monthly stipend', NULL,
   NULL,
   'upcoming', 'https://example.com/youth-opportunity', false, NULL,
   'Planned', 'Not open yet', 'https://example.com/youth-opportunity',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (33, 'asdf', 'asdf',
   'afsd',
   NULL, 12.0, 'USD',
   ARRAY[]::text[],
   ARRAY[]::text[],
   'standard', 'asdf', NULL,
   'asdf',
   'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting applications', 'https://asdf.com',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (34, 'Test 2', 'asdf',
   'asdf',
   NULL, 0.0, 'USD',
   ARRAY[]::text[],
   ARRAY[]::text[],
   'standard', 'asdf', NULL,
   'asdf',
   'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting applications', 'https://asdf.com',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (35, 'Women''s Economic Empowerment Initiative', 'Gender Equity Coalition',
   'Financial support program designed to promote economic independence and entrepreneurship for women.',
   'female', 700.0, 'USD',
   ARRAY['United States', 'Canada', 'United Kingdom']::text[],
   ARRAY[]::text[],
   'standard', '$700 monthly grant', NULL,
   NULL,
   'active', 'https://example.com/womens-empowerment', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/womens-empowerment',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (36, 'Universal Dividend Network', 'Global Commons Foundation',
   'Blockchain-based UBI available worldwide, using cryptocurrency for efficient borderless payments.',
   NULL, 300.0, 'USD',
   ARRAY[]::text[],
   ARRAY[]::text[],
   'digital', 'Equivalent of $300 monthly in cryptocurrency', NULL,
   NULL,
   'active', 'https://example.com/universal-dividend', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/universal-dividend',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (37, 'Senior Security Program', 'Elder Care Alliance',
   'Income supplement for seniors over 65 to help with rising costs of living and healthcare expenses.',
   NULL, 550.0, 'USD',
   ARRAY['United States', 'Canada']::text[],
   ARRAY[]::text[],
   'standard', '$550 monthly payment', NULL,
   NULL,
   'active', 'https://example.com/senior-security', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/senior-security',
   ARRAY[]::text[], 'deleted',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   NULL, ARRAY[]::text[],
   NULL, NULL),

  (38, 'New Brunswick Youth Basic Income Pilot', 'Government of New Brunswick & Social Labs',
   'A regional basic income initiative delivering monthly financial floors to young adults transitioning into the workforce in Moncton and Saint John.',
   NULL, 750.0, 'CAD',
   ARRAY['Canada']::text[],
   ARRAY['NB', 'New Brunswick']::text[],
   'standard', '$1,000 CAD per month', NULL,
   NULL,
   'active', 'https://www2.gnb.ca', true, NULL,
   'Ongoing', 'Open', 'https://www2.gnb.ca/apply',
   ARRAY[]::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'municipal_government',
   'NB', ARRAY['Moncton', 'Saint John']::text[],
   46.0878, -64.7782),

  (39, 'Cook County Promise Guaranteed Income Program — Next Phase', 'Cook County Government, Bureau of Economic Development',
   'The next phase is a successor to Cook County''s 2022–2025 Promise pilot, which paid 3,250 low-to-moderate-income households $500 per month for two years. Cook County has appropriated $7.5 million for fiscal year 2026 and is designing the successor, but its payment amount, participant count, application process, and final eligibility rules have not been announced; the numeric amount is therefore recorded as 0 rather than assuming the prior $500 rate.',
   NULL, 0.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Illinois']::text[],
   'standard', 'Payment amount under design for FY2026', NULL,
   '• Intended for Cook County residents\n• Final income, household, and other eligibility requirements have not been announced\n• Program design is expected to be completed in late 2026',
   'upcoming', 'https://www.cookcountyil.gov/promise', true, NULL,
   'Planned; payment amount not announced', 'Accepting interest form; applications not open', 'https://www.cookcountyil.gov/promise',
   ARRAY['https://www.cookcountyil.gov/promise', 'https://arpa.cookcountyil.gov/promise-guaranteed-income-pilot-program']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'municipal_government',
   'IL', ARRAY['Cook County', 'Chicago']::text[],
   41.8781, -87.6298),

  (40, 'California Guaranteed Income Pilot Program for Older Californians (CASH SJC)', 'California Department of Social Services, Housing Authority of the County of San Joaquin, and GiveDirectly',
   'California''s Guaranteed Income Pilot Program for Older Californians is being implemented in San Joaquin County as CASH SJC by the county housing authority and GiveDirectly, with state funding. Selected seniors will receive $1,000 per month for 12 months with no spending restrictions; applications open August 24, 2026, and the first payment is scheduled for January 20, 2027.',
   NULL, 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California']::text[],
   'standard', '$1,000 per month for 12 months', NULL,
   '• Age 60 or older\n• Resident of San Joaquin County\n• On the Housing Authority of the County of San Joaquin waitlist\n• Household income at or below the housing authority''s applicable limits\n• Not currently receiving payments from another guaranteed income program',
   'upcoming', 'https://cashsjc.aidkit.org/apply', true, NULL,
   'Planned; first payment scheduled for January 20, 2027', 'Not open yet; opens August 24, 2026', 'https://cashsjc.aidkit.org/apply',
   ARRAY['https://www.cdss.ca.gov/inforesources/guaranteed-income-pilot-program/older-californians', 'https://www.cdss.ca.gov/Portals/9/GIPP/2025-intent-award-final.pdf', 'https://www.givedirectly.org/cashsjc']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'state_federal',
   'CA', ARRAY['San Joaquin County', 'Stockton']::text[],
   37.9577, -121.2908),

  (41, 'The Bridge Project', 'The Bridge Project',
   'The Bridge Project provides unrestricted cash to pregnant mothers and their babies to reduce childhood poverty and strengthen maternal and infant stability. Its standard three-year schedule includes a $1,125 prenatal stipend, $750 per month for the child''s first 15 months, and $375 per month for the next 21 months; the numeric field records the initial $750 monthly rate. Open enrollment currently covers Arkansas, selected Maryland ZIP codes, and ARC-designated counties in Kentucky, Ohio, West Virginia, and Tennessee, with Appalachia using an 18-month high-cash/low-cash research design.',
   'female', 750.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Arkansas', 'Maryland', 'Kentucky', 'Ohio', 'West Virginia', 'Tennessee']::text[],
   'standard', '$1,125 prenatal stipend + $750/mo for 15 mos + $375/mo for 21 mos', NULL,
   '• Pregnant mother\n• Arkansas cohort A: Arkansas resident, age 18–22, no more than 27 weeks pregnant, and annual household income of $44,000 or less\n• Arkansas cohort B: Arkansas resident age 18 or older, current or former U.S. Armed Forces member, no more than 27 weeks pregnant, and annual household income under $44,000 excluding specified veterans benefits\n• Maryland: age 18 or older, no more than 27 weeks pregnant, Medicaid eligible, and resident of ZIP code 21225, 21230, 21215, or 21740\n• Appalachia: age 18 or older, no more than 14 weeks pregnant, proof of pregnancy, and resident of an ARC-designated county in Kentucky, Ohio, West Virginia, or Tennessee',
   'active', 'https://www.bridgeproject.org/apply', true, NULL,
   'Ongoing', 'Accepting applications', 'https://www.bridgeproject.org/apply',
   ARRAY['https://www.bridgeproject.org/', 'https://www.bridgeproject.org/apply', 'https://governor.maryland.gov/news/press-releases/governor-moore-announces-partnership-bridge-project']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'philanthropic_grant',
   'Multi-state', ARRAY['Baltimore', 'Appalachia']::text[],
   39.2904, -76.6122),

  (42, 'The Magnolia Mother’s Trust', 'Springboard to Opportunities',
   'The Magnolia Mother’s Trust is a guaranteed-income initiative for extremely low-income Black mothers in Jackson, Mississippi, designed to strengthen family stability while shifting narratives about poverty and deservedness. Its seventh cohort launched May 15, 2026, with about 100 mothers receiving $1,000 per month for 12 months, plus optional peer support, goal-setting, community-building, mental-health, self-care, and whole-family programming.',
   'female', 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Mississippi']::text[],
   'standard', '$1,000 per month for 12 months', NULL,
   '• Black mother\n• Low-income or extremely low-income household\n• Resident of Jackson, Mississippi\n• Resident of federally subsidized housing or another community served by Springboard to Opportunities\n• Selected for the current cohort',
   'active', 'https://springboardto.org/socioeconomic-well-being/magnolia-mothers-trust/', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://springboardto.org/socioeconomic-well-being/magnolia-mothers-trust/',
   ARRAY['https://springboardto.org/socioeconomic-well-being/magnolia-mothers-trust/', 'https://springboardto.org/the-7th-cohort/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'MS', ARRAY['Jackson']::text[],
   32.2988, -90.1848),

  (43, 'UBI4ALL European Basic Income Raffle', 'UBI4ALL, operated by EBI Politische Teilhabe in Europa gemeinnützige UG',
   'UBI4ALL is a donation-funded global raffle that awards one winner a total of €9,600 in unconditional monthly payments, with free participation for people aged 16 or older. The monthly amount depends on the winner''s country-income classification—€160 for 60 months, €200 for 48, €267 for 36, €400 for 24, or €800 for 12—and the numeric USD field uses the €800 tier converted at the European Central Bank''s August 19, 2026 reference rate.',
   NULL, 928.4, 'EUR',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'standard', '€800 per month for 12 months (~$928.40 USD monthly equivalent)', NULL,
   '• Age 16 or older\n• Resident anywhere in the world where participation is legally permitted\n• Register with name, date of birth, and country of residence exactly as shown on official identification\n• Confirm participation for each raffle unless enrolled for automatic entry as a UBI Beaver\n• Previous UBI4ALL winners cannot win again\n• Residents of the immediately preceding winner''s country are excluded from the next raffle',
   'active', 'https://www.ubi4all.org/register', true, NULL,
   'Ongoing; the 10th raffle is funded for August 22, 2026', 'Accepting registrations and raffle confirmations', 'https://www.ubi4all.org/register',
   ARRAY['https://www.ubi4all.org/', 'https://www.ubi4all.org/register', 'https://www.ubi4all.org/terms-and-conditions', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'lottery_raffle', 'direct_deposit', 'community_crowdfund',
   'Berlin', ARRAY['Global']::text[],
   52.52, 13.405),

  (44, 'Guaranteed Income for Artists', 'Springboard for the Arts',
   'Springboard for the Arts'' Guaranteed Income for Artists pilot provides restriction-free cash to artists, culture bearers, and creative workers in Minnesota, with an equity focus on communities with weak or unstable safety nets. The expanded program supports 100 participants—50 in Saint Paul''s Frogtown/Rondo neighborhoods and 50 in Otter Tail County—with $500 per month over a total program period of five years, alongside optional financial, student-loan, and housing counseling.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Minnesota']::text[],
   'standard', '$500 per month for up to 5 years', NULL,
   '• Artist, culture bearer, or creative worker\n• Resident of Saint Paul''s Frogtown/Rondo neighborhoods or Otter Tail County\n• Selected at random from an eligible pool rather than through an open public application\n• Earlier expanded cohorts drew from artists adversely affected by COVID-19 who had received Springboard emergency relief or other services',
   'active', 'https://springboardforthearts.org/programs/guaranteed-income/', true, NULL,
   'Ongoing', 'Not open to the public', 'https://springboardforthearts.org/programs/guaranteed-income/',
   ARRAY['https://springboardforthearts.org/programs/guaranteed-income/', 'https://springboardforthearts.org/wp-content/uploads/2023/02/Press_Release_GMI_2023_SBftA.pdf']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'MN', ARRAY['Saint Paul', 'Otter Tail County']::text[],
   44.9537, -93.09),

  (45, 'Sacramento Creative Growth Fellowship Program', 'City of Sacramento Office of Arts and Culture',
   'The City of Sacramento''s Creative Growth Fellowship provides unrestricted monthly stipends so local artists can pursue and advance their creative careers. Two hundred artists were selected through panel review followed by lottery to receive $850 per month from September 1, 2025, through August 31, 2026, and the city says no second round is currently planned.',
   NULL, 850.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['California']::text[],
   'standard', '$850 per month for 12 months', NULL,
   '• Artist living within the City of Sacramento\n• Works in an eligible discipline such as craft, performing arts, design, film, music, literary arts, or visual arts\n• Submitted an eligible application during the closed application round\n• Selected through independent panel review followed by lottery',
   'active', 'https://www.cityofsacramento.gov/ccs/oac/funding-and-grants/creative-growth-fellowship-program.html', true, NULL,
   'Ongoing through August 31, 2026', 'No longer accepting applications', 'https://www.cityofsacramento.gov/ccs/oac/funding-and-grants/creative-growth-fellowship-program.html',
   ARRAY['https://www.cityofsacramento.gov/ccs/oac/funding-and-grants/creative-growth-fellowship-program.html', 'https://sacramentocityexpress.com/2025/09/05/city-awards-2-04-million-to-200-artists-through-creative-growth-fellowship/']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'municipal_government',
   'CA', ARRAY['Sacramento']::text[],
   38.5816, -121.4944),

  (46, 'Camp Harbor View Guaranteed Income Program', 'Camp Harbor View, in partnership with UpTogether',
   'Camp Harbor View made guaranteed income a permanent family-support offering after a 2021–2023 pilot, partnering with UpTogether to help Boston families just above public-benefit thresholds build stability and pursue personal goals. Its 2024–2026 cohort included 38 Leadership Academy families receiving $652.90 per month for 28 months, plus optional mobility mentoring and biannual convenings; that cohort was scheduled to conclude in July 2026.',
   NULL, 652.9, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Massachusetts']::text[],
   'standard', '$652.90 per month for 28 months', NULL,
   '• Boston family connected to Camp Harbor View\n• Child enrolled in Camp Harbor View''s Leadership Academy\n• Household income below 80% of area median income\n• Generally ineligible for most public benefits\n• Not living in income-based subsidized housing, to avoid benefit losses\n• Selected by Camp Harbor View for the cohort',
   'active', 'https://campharborview.org/family-services/guaranteed-income-program/', true, NULL,
   'Recently completed for the 2024–2026 cohort', 'Not open to the public', 'https://campharborview.org/family-services/guaranteed-income-program/',
   ARRAY['https://campharborview.org/family-services/guaranteed-income-program/', 'https://www.bostonindicators.org/reports/report-detail-pages/dignity-dividend', 'https://www.dotare.io/resources/programs/camp-harbor-view-guaranteed-income-program']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'MA', ARRAY['Boston']::text[],
   42.3601, -71.0589),

  (47, 'PHLHousing+', 'Philadelphia Housing Development Corporation and the City of Philadelphia',
   'PHLHousing+ was a direct-to-tenant cash rental-assistance pilot for 301 low-income Philadelphia families with children, designed as a flexible alternative to a housing voucher. Monthly prepaid-debit-card payments were calculated so housing costs would equal roughly 30% of household income; the post-recertification median was $850, and the nearly four-year program ended in June 2026.',
   NULL, 850.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', 'Median $850 per month flexible housing cash', NULL,
   '• Philadelphia renter household\n• Household income no greater than 50% of area median income at enrollment\n• At least one child age 15 or younger in the household\n• Randomly invited from Philadelphia Housing Authority public-housing or Housing Choice Voucher waitlists\n• Did not own a home at enrollment\n• Was not already receiving ongoing federal rental assistance',
   'closed', 'https://phdcphila.org/phlhousing-plus/', true, NULL,
   'Completed in June 2026', 'No longer accepting applications', 'https://phdcphila.org/phlhousing-plus/',
   ARRAY['https://phdcphila.org/phlhousing-plus/', 'https://www.housinginitiative.org/phlhousing.html', 'https://www.housinginitiative.org/phlhousing-housing-outcomes-at-two-years.html', 'https://pmc.ncbi.nlm.nih.gov/articles/PMC11938205/']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'municipal_government',
   'PA', ARRAY['Philadelphia']::text[],
   39.9526, -75.1652),

  (48, 'One Family Philadelphia Guaranteed Income Financial Treatment Pilot', 'University of Pennsylvania and Humanity Forward Foundation, with Jefferson Health; funded by One Family Foundation',
   'The One Family Philadelphia Guaranteed Income Financial Treatment pilot is a randomized trial testing whether unconditional cash and financial navigation reduce financial toxicity and improve quality of life and treatment adherence for low-income adults with advanced cancer. Participants assigned to the cash arm receive $1,000 per month for 12 months, while Humanity Forward Foundation administers payments and benefits counseling and the University of Pennsylvania recruits participants and evaluates outcomes.',
   NULL, 1000.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$1,000 per month for 12 months', NULL,
   '• Age 18 or older\n• Low-income adult with advanced or recurrent cancer in active treatment\n• Medicaid beneficiary\n• Annual household income at or below 200% of the federal poverty level\n• Receiving care at a participating Philadelphia cancer center\n• Resident of Berks, Bucks, Chester, Delaware, Lancaster, Lehigh, Montgomery, Northampton, or Philadelphia County\n• Consented to the study and randomized to the guaranteed-income intervention arm to receive cash',
   'active', 'https://clinicaltrials.gov/study/NCT06611982', true, NULL,
   'Ongoing; trial is active but not recruiting', 'No longer accepting applications', 'https://clinicaltrials.gov/study/NCT06611982',
   ARRAY['https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects', 'https://pc3i.upenn.edu/our-work/projects/giftt/', 'https://clinicaltrials.gov/study/NCT06611982', 'https://www.federalregister.gov/documents/2023/03/31/2023-06706/guaranteed-income-financial-treatment-trial-giftt']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'PA', ARRAY['Philadelphia', 'Delaware Valley']::text[],
   39.9526, -75.1652),

  (49, 'Guaranteed Income for Survivors of Firearm Violence', 'Philadelphia Department of Public Health and the Philadelphia Hospital-Based Violence Intervention Program Coalition',
   'The Philadelphia pilot tests whether six months of unrestricted cash can help survivors meet immediate needs after a firearm injury and improve well-being and engagement with hospital-based violence intervention services. Its original design enrolled 50 participants from six Level I trauma centers and paid $500 per month; Pennsylvania still listed the project as active in June 2026 even though the original procurement anticipated completion by June 30, 2024.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$500 per month for 6 months', NULL,
   '• Survivor of a firearm injury\n• Already enrolled in a participating Philadelphia hospital-based violence intervention program\n• Recruited through one of six Philadelphia Level I trauma centers\n• Selected for the 50-participant feasibility-study cohort',
   'active', 'https://philacityfund.org/rfp-gbi/', true, NULL,
   'Current payout activity is not publicly clarified; the original design provided $500 monthly for six months, and Pennsylvania still listed the pilot as active in June 2026', 'Not open to the public; participants were recruited through participating hospital-based violence intervention programs', 'https://philacityfund.org/rfp-gbi/',
   ARRAY['https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects', 'https://philacityfund.org/rfp-gbi/', 'https://philacityfund.org/wp-content/uploads/2022/12/RFP-HVIP-GBI-Pilot-2022_final.pdf']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'municipal_government',
   'PA', ARRAY['Philadelphia']::text[],
   39.9526, -75.1652),

  (50, 'Network Economic Support Transfers Pilot Project', 'City of Philadelphia',
   'The Network Economic Support Transfers Pilot Project is a 60-person guaranteed-income pilot in Philadelphia County that began April 1, 2025, and remained on Pennsylvania''s active-pilot registry in June 2026. Public sources do not disclose the transfer amount, payment cadence, duration, detailed target population, or intake method, so the numeric amount is recorded as 0 rather than estimated.',
   NULL, 0.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', 'Transfer amount not publicly disclosed', NULL,
   '• Participant in the 60-person Philadelphia County cohort\n• Detailed eligibility requirements have not been publicly disclosed',
   'active', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects', true, NULL,
   'Ongoing according to Pennsylvania''s active-pilot registry; the transfer amount and payment schedule have not been publicly disclosed', 'No public application route disclosed', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects',
   ARRAY['https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'municipal_government',
   'PA', ARRAY['Philadelphia']::text[],
   39.9526, -75.1652),

  (51, 'Thriving Providers Project — Pittsburgh', 'United Way of Southwestern Pennsylvania, Home Grown, and Trying Together',
   'The Pittsburgh Thriving Providers Project provides direct cash to 25 preselected home-based child care providers in Allegheny County to stabilize their finances and test how provider economic security affects children and communities. Participants receive $250 twice monthly for 18 months beginning in July 2025, with optional tax-preparation, financial-planning, and digital-skills support.',
   NULL, 500.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$250 twice monthly ($500/mo) for 18 months', NULL,
   '• Home-based child care provider\n• Based in an Allegheny County community with limited access to food, child care, and transportation\n• Identified and selected by Trying Together for the 25-provider cohort',
   'active', 'https://unitedwayswpa.org/our-impact/community-change-collaboratives/thriving-providers-project/', true, NULL,
   'Ongoing; $250 is paid twice monthly for 18 months beginning in July 2025', 'Not open to the public; the 25-provider cohort was preselected', 'https://unitedwayswpa.org/our-impact/community-change-collaboratives/thriving-providers-project/',
   ARRAY['https://unitedwayswpa.org/our-impact/community-change-collaboratives/thriving-providers-project/', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'philanthropic_grant',
   'PA', ARRAY['Pittsburgh', 'Allegheny County']::text[],
   40.4406, -79.9959),

  (52, 'Programa de Renda Básica de Cidadania de Maricá', 'Prefeitura de Maricá, Secretaria de Economia Solidária e Empreendedorismo Social',
   'Maricá''s Renda Básica de Cidadania provides monthly local-currency income to low-income municipal residents to strengthen food security, social protection, and the local economy. More than 70,000 residents receive 230 Mumbucas per month, valued at R$230; BRL is used here because the municipal currency is valued one-to-one with the Brazilian real.',
   NULL, 44.2, 'BRL',
   ARRAY['Brazil']::text[],
   ARRAY['Rio de Janeiro']::text[],
   'standard', '230 Mumbucas (~R$230 / $44.20 USD) per month', NULL,
   '• Resident of Maricá\n• Registered in Maricá''s Cadastro Único\n• Cadastro Único record must be current\n• Monthly family income of no more than three Brazilian minimum wages\n• Must pass the municipality''s program-criteria review',
   'active', 'https://rendabasicacidadania.marica.rj.gov.br/', true, NULL,
   'Ongoing; 230 Mumbucas are paid monthly to each beneficiary', 'Accepting first-access screening through municipal CRAS offices; current beneficiaries are undergoing recertification', 'https://rendabasicacidadania.marica.rj.gov.br/',
   ARRAY['https://www.marica.rj.gov.br/noticia/prefeitura-de-marica-segue-com-recadastramento-do-programa-de-renda-basica-de-cidadania/', 'https://rendabasicacidadania.marica.rj.gov.br/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'digital_wallet', 'municipal_government',
   'Rio de Janeiro', ARRAY['Maricá']::text[],
   -22.9194, -42.8186),

  (53, 'Moeda Social Arariboia', 'Prefeitura de Niterói, Secretaria Municipal de Assistência Social e Economia Solidária',
   'Niterói''s permanent Moeda Social Arariboia program supports low-income and vulnerable households while directing spending to participating local businesses. The base benefit is 345 Arariboias, equivalent to R$345, monthly plus R$125 per additional family member up to six members and a R$970 household maximum; BRL is used because the local currency is denominated one-to-one in reais.',
   NULL, 66.29, 'BRL',
   ARRAY['Brazil']::text[],
   ARRAY['Rio de Janeiro']::text[],
   'standard', '345 Arariboias base benefit (~$66.29 USD) per month', NULL,
   '• Resident of Niterói\n• Current Cadastro Único registration\n• Per-capita family income of no more than R$218 under the core low-income rule\n• Selected through municipal social-assistance records\n• Specially included groups can include low-income families with disabled or atypical members and vulnerable older recipients of the Benefício de Prestação Continuada',
   'active', 'https://niteroi.rj.gov.br/arariboia/', true, NULL,
   'Ongoing; benefits are normally reloaded monthly', 'No separate public web application; inclusion is determined from updated Cadastro Único and municipal records', 'https://niteroi.rj.gov.br/arariboia/',
   ARRAY['https://niteroi.rj.gov.br/prefeito-rodrigo-neves-sanciona-reajuste-de-12-da-moeda-arariboia-e-anuncia-abono-natalino-para-50-mil-familias/', 'https://niteroi.rj.gov.br/prefeitura-de-niteroi-antecipa-pagamento-da-moeda-arariboia-em-abril/', 'https://niteroi.rj.gov.br/moeda-social-arariboia-recarga-do-mes-de-maio-foi-feita-nesta-terca-feira-06/', 'https://niteroi.rj.gov.br/assistencia-social-de-niteroi-inicia-entrega-dos-novos-cartoes-da-moeda-arariboia/', 'https://niteroi.rj.gov.br/arariboia/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'municipal_government',
   'Rio de Janeiro', ARRAY['Niterói']::text[],
   -22.8833, -43.1036),

  (54, 'Renda Básica da Cidadania de Saquarema', 'Prefeitura de Saquarema, Secretaria Municipal de Desenvolvimento Social',
   'Saquarema''s Renda Básica da Cidadania uses the local Saquá currency to provide monthly social protection to households experiencing poverty or vulnerability and to stimulate local commerce. From July 1, 2026, 10,277 beneficiaries receive 400 Saquás, equivalent to R$400; BRL is used because Saquá is legally valued one-to-one with the Brazilian real.',
   NULL, 76.86, 'BRL',
   ARRAY['Brazil']::text[],
   ARRAY['Rio de Janeiro']::text[],
   'standard', '400 Saquás (~$76.86 USD) per month', NULL,
   '• Resident of Saquarema for at least five years before registration\n• Registered in Cadastro Único\n• Per-capita family income of no more than one-half of the Brazilian minimum wage\n• Household or family segment experiencing social vulnerability or poverty\n• Generally limited to one recipient per household, with provisions for eligible older people and people with disabilities receiving the Benefício de Prestação Continuada\n• Must not fall within excluded categories such as active or retired public employees or recipients of specified overlapping municipal education benefits',
   'active', 'https://www.saquarema.rj.gov.br/prefeitura-vai-iniciar-recadastramento-da-moeda-social-saqua/', true, NULL,
   'Ongoing; the monthly benefit increased to 400 Saquás on July 1, 2026', 'No longer accepting new applications; the latest published intake notice limited service to recertification of current beneficiaries', 'https://www.saquarema.rj.gov.br/prefeitura-vai-iniciar-recadastramento-da-moeda-social-saqua/',
   ARRAY['https://transparencia.saquarema.rj.gov.br/wp-content/uploads/2026/07/Lei2881_01072026112424.pdf', 'https://transparencia.saquarema.rj.gov.br/wp-content/uploads/2022/02/LO-2189-2022.pdf', 'https://dos.saquarema.rj.gov.br/wp-content/uploads/2022/10/D.O.S.-1014-5-Assinado.pdf', 'https://transparencia.saquarema.rj.gov.br/wp-content/uploads/2023/04/DEC-2486-2023.pdf', 'https://www.saquarema.rj.gov.br/prefeitura-vai-iniciar-recadastramento-da-moeda-social-saqua/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'municipal_government',
   'Rio de Janeiro', ARRAY['Saquarema']::text[],
   -22.92, -42.51),

  (55, 'Gyeonggi Youth Basic Income', 'Gyeonggi Provincial Government, participating municipalities, and the Gyeonggi Future Generation Foundation',
   'Gyeonggi Youth Basic Income supports the social rights, future preparation, and local economic participation of eligible 24-year-old residents without an income or employment test. It pays KRW250,000 per quarter, up to KRW1 million in 2026, through participating municipalities'' local-currency systems; the USD field is the monthly equivalent.',
   NULL, 59.89, 'KRW',
   ARRAY['South Korea']::text[],
   ARRAY['Gyeonggi Province']::text[],
   'standard', 'KRW 250,000 quarterly (~$59.89 USD monthly equivalent)', NULL,
   '• Age 24 during the applicable 2026 application quarter\n• Registered as a Gyeonggi Province resident on the application date\n• At least three consecutive years of residence in Gyeonggi Province or at least ten cumulative years of residence\n• Resident of a participating municipality\n• Residents of Seongnam and Goyang are excluded from the 2026 provincial program',
   'active', 'https://apply.jobaba.net/special/gibon/main.do', true, NULL,
   'Ongoing; KRW250,000 is paid quarterly in local currency', 'Not open yet; the next application window is September 1 through October 2, 2026', 'https://apply.jobaba.net/special/gibon/main.do',
   ARRAY['https://youth.gg.go.kr/gg/intro/youth-policy-housing-test.do?articleNo=8940&mode=view', 'https://apply.jobaba.net/special/gibon/main.do', 'https://gnews.gg.go.kr/news/news_detail.do?number=202603191948215837C094&s_code=C094', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'prepaid_card', 'state_federal',
   'Gyeonggi', ARRAY['Participating Municipalities']::text[],
   37.4138, 127.5183),

  (56, 'Seoul Youth Allowance', 'Seoul Metropolitan Government',
   'Seoul Youth Allowance helps unemployed or short-term-working young adults focus on career exploration and labor-market entry through financial and tailored growth support. Selected participants receive KRW500,000 per month for up to six months, together with mentoring, employment programs, and related services.',
   NULL, 359.33, 'KRW',
   ARRAY['South Korea']::text[],
   ARRAY['Seoul']::text[],
   'standard', 'KRW 500,000 per month for up to 6 months (~$359.33 USD)', NULL,
   '• Age 19 through 34 under the 2026 birth-date rules\n• Registered resident of Seoul at the time of application\n• Graduated from, completed, or withdrawn from the applicant''s final school\n• Unemployed, or employed no more than 30 hours per week, or on a contract lasting no more than three months\n• Household income within the program''s applicable limit, generally no more than 150% of median income\n• Must not belong to an excluded or overlapping-benefit category specified in the application notice',
   'active', 'https://youth.seoul.go.kr/infoData/plcyInfo/view.do?key=2309150002&plcyBizId=V202600005&sprtInfoId=', true, NULL,
   'Ongoing for selected 2026 participants; KRW500,000 is paid monthly for up to six months', 'No longer accepting applications; the second 2026 round closed May 29, 2026', 'https://youth.seoul.go.kr/infoData/plcyInfo/view.do?key=2309150002&plcyBizId=V202600005&sprtInfoId=',
   ARRAY['https://youth.seoul.go.kr/infoData/plcyInfo/view.do?key=2309150002&plcyBizId=V202600005&sprtInfoId=', 'https://news.seoul.go.kr/gov/archives/578136', 'https://mediahub.seoul.go.kr/archives/2018273', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'municipal_government',
   'Seoul', ARRAY['Seoul']::text[],
   37.5665, 126.978),

  (57, 'Rodzina 800+', 'Social Insurance Institution (ZUS), under Poland''s Ministry of Family, Labour and Social Policy',
   'Rodzina 800+ is Poland''s national child-rearing benefit designed to help families meet the costs of raising children. ZUS pays PLN800 per month for each eligible child until age 18 regardless of household income, subject to an electronic application for each annual benefit period.',
   NULL, 214.68, 'PLN',
   ARRAY['Poland']::text[],
   ARRAY[]::text[],
   'standard', 'PLN 800 per month per child (~$214.68 USD)', NULL,
   '• Parent, actual guardian, legal guardian, foster-care provider, or other eligible care institution\n• Eligible child has not yet reached age 18\n• No household-income test\n• Must satisfy applicable Polish residence and legal-status requirements\n• A new electronic application is required for each benefit period',
   'active', 'https://www.gov.pl/web/gov/skorzystaj-z-programu-rodzina-500', true, NULL,
   'Ongoing', 'Accepting electronic applications for the June 2026 through May 2027 benefit period', 'https://www.gov.pl/web/gov/skorzystaj-z-programu-rodzina-500',
   ARRAY['https://www.zus.pl/swiadczenia/swiadczenia-dla-rodzin/swiadczenie-wychowawcze-800-plus', 'https://www.zus.pl/-/mo%C5%BCna-ju%C5%BC-sk%C5%82ada%C4%87-wnioski-o-800-na-nowy-okres-%C5%9Bwiadczeniowy', 'https://www.gov.pl/web/rodzina/rodzina-500-plus', 'https://www.gov.pl/web/gov/skorzystaj-z-programu-rodzina-500', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'state_federal',
   'Mazovia', ARRAY['Nationwide', 'Warsaw']::text[],
   52.2297, 21.0122),

  (58, 'Comingle', 'Comingle, Inc., supported by the Income to Support All Foundation',
   'Comingle is a private mutual-aid basic-income network in which members pledge 7% of their income, pool the funds, and receive an equal weekly payout that offsets their personal pledge. It has no fixed monthly grant: the USD field uses a conservative $130 monthly equivalent of the site''s statement that a zero-income week should yield more than $30, while actual net payments fluctuate.',
   NULL, 130.0, 'USD',
   ARRAY['United States']::text[],
   ARRAY[]::text[],
   'standard', 'Weekly pooled dividend (~$130/mo benchmark)', NULL,
   '• Age 18 or older\n• Resident of the United States\n• Bank account active for at least three months\n• Access to online banking\n• Complete identity verification and connect a bank account through Plaid\n• Agree to pledge 7% of qualifying income\n• No minimum income requirement',
   'active', 'https://www.comingle.us/', true, NULL,
   'Ongoing in private beta; weekly net payments fluctuate with pooled income, membership, and outside subsidies', 'Accepting launch notifications; not accepting new active members', 'https://www.comingle.us/',
   ARRAY['https://www.comingle.us/', 'https://www.comingle.us/faqs']::text[], 'active',
   'guaranteed_recurrent', 'direct_deposit', 'community_crowdfund',
   'CA', ARRAY['Nationwide', 'San Francisco']::text[],
   37.7749, -122.4194)
ON CONFLICT (program_id) DO UPDATE SET
  name = excluded.name,
  organization = excluded.organization,
  description = excluded.description,
  gender_requirement = excluded.gender_requirement,
  monthly_amount_usd = excluded.monthly_amount_usd,
  currency = excluded.currency,
  available_regions = excluded.available_regions,
  required_states = excluded.required_states,
  payment_method = excluded.payment_method,
  amount_description = excluded.amount_description,
  max_household_income_usd = excluded.max_household_income_usd,
  eligibility = excluded.eligibility,
  status = excluded.status,
  website = excluded.website,
  verified = excluded.verified,
  submitter_email = excluded.submitter_email,
  payout_status = excluded.payout_status,
  application_status = excluded.application_status,
  apply_url = excluded.apply_url,
  sources = excluded.sources,
  internal_status = excluded.internal_status,
  distribution_type = excluded.distribution_type,
  payout_rail = excluded.payout_rail,
  funding_source = excluded.funding_source,
  state_province = excluded.state_province,
  municipalities = excluded.municipalities,
  latitude = excluded.latitude,
  longitude = excluded.longitude;



-- =====================================================================
-- BLOG POSTS (10 rows)
-- =====================================================================
INSERT INTO blog_posts
 (title, content, summary, author, posted_date, image_url,
  related_programs, tags)
VALUES
 ('Understanding UBI: A Comprehensive Guide',
  $txt$Universal Basic Income (UBI) is becoming increasingly relevant in our modern economy. This comprehensive guide explains the core principles and benefits of UBI programs.


## What is UBI?


Universal Basic Income is a system where citizens receive a regular, unconditional sum of money from the government, regardless of their employment status or income level.


## Key Benefits


- Poverty Reduction
- Economic Security
- Mental Health Benefits
- Innovation and Entrepreneurship


## Current Implementation


Various programs worldwide are testing different UBI models, each with unique characteristics and lessons learned.$txt$,
  'A detailed exploration of Universal Basic Income, its principles, and its growing importance in modern society.',
  'Sarah Chen', '2023-11-15T10:00:00.000Z',
  'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?auto=format&fit=crop&q=80',
  ARRAY[]::integer[], ARRAY['education', 'overview', 'basics']::text[]),


 ('Digital Currency Integration in UBI Programs',
  $txt$As cryptocurrency adoption grows, some UBI programs are exploring digital currency distribution methods. This post examines the benefits and challenges of implementing crypto-based UBI solutions.


## Advantages


- Lower Transaction Costs
- Faster Distribution
- Enhanced Transparency
- Global Accessibility


## Current Implementations


Several pilot programs are already testing cryptocurrency-based UBI distribution, showing promising results and valuable insights.$txt$,
  'Exploring the intersection of cryptocurrency and Universal Basic Income programs.',
  'Michael Rodriguez', '2023-11-10T14:30:00.000Z',
  'https://images.unsplash.com/photo-1518546305927-5a555bb7020d?auto=format&fit=crop&q=80',
  ARRAY[]::integer[], ARRAY['cryptocurrency', 'technology', 'innovation']::text[]),


 ('Impact Study: First Year Results',
  $txt$Recent studies show significant positive outcomes from UBI programs worldwide. This post analyzes the first-year results from various implementations.


## Key Findings


- Improved Mental Health
- Increased Employment
- Better Education Outcomes
- Reduced Healthcare Costs


## Methodology


The study followed participants across multiple programs, tracking various social and economic indicators.$txt$,
  'Analysis of first-year results from multiple UBI programs shows promising outcomes.',
  'Dr. Emily Watson', '2023-11-05T09:15:00Z',
  'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&q=80',
  ARRAY[]::integer[], ARRAY['research', 'results', 'analysis']::text[]),


 ('Impact Study: First Year Results',
  $txt$Recent studies show significant positive outcomes from UBI programs worldwide. This post analyzes the first-year results from various implementations.


## Key Findings


- Improved Mental Health
- Increased Employment
- Better Education Outcomes
- Reduced Healthcare Costs


## Methodology


The study followed participants across multiple programs, tracking various social and economic indicators.$txt$,
  'Analysis of first-year results from multiple UBI programs shows promising outcomes.',
  'Dr. Emily Watson', '2023-11-05T09:15:00Z',
  'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&q=80',
  ARRAY[]::integer[], ARRAY['research', 'results', 'analysis']::text[]),


 ('Digital UBI Pilot Program Launches in Stockholm',
  $txt$A new UBI pilot program has launched in Stockholm, Sweden, utilizing a unique digital currency distribution method. 200 residents will receive monthly payments equivalent to $500 USD via a custom blockchain platform.


## Program Details


- **Duration**: 24 months
- **Payment**: $500 USD equivalent in digital currency
- **Participants**: 200 randomly selected residents
- **Special Focus**: Digital financial literacy


## Expected Outcomes


Researchers will be tracking spending patterns, financial literacy improvements, and general wellbeing metrics throughout the study period.$txt$,
  'Stockholm launches innovative UBI pilot using blockchain technology to distribute monthly payments.',
  'Lars Svensson', '2023-10-25T16:45:00.000Z',
  'https://images.unsplash.com/photo-1509356843151-3e7d96241e11?auto=format&fit=crop&q=80',
  ARRAY[]::integer[], ARRAY['pilot', 'digital currency', 'europe']::text[]),


 ('Community-First Approach: Rural UBI Success Story',
  $txt$The Rural Prosperity Initiative has released its first-year results, showing remarkable improvements in community wellbeing across participating villages.


## Key Findings


- 32% reduction in food insecurity
- 45% increase in local business revenue
- 28% improvement in reported mental health metrics
- 15% increase in children's school attendance


## Implementation Model


The program's success is attributed to its community-centered design, which incorporated local leaders in the distribution and education processes.$txt$,
  'Rural UBI program shows impressive first-year results with significant improvements in multiple wellbeing metrics.',
  'Maria Johnson', '2023-10-18T11:20:00.000Z',
  'https://images.unsplash.com/photo-1464082354059-27db6ce50048?auto=format&fit=crop&q=80',
  ARRAY[2]::integer[], ARRAY['rural', 'success story', 'community']::text[]),


 ('New Universal Basic Income Pilot Launches in Chicago',
  $txt$# Chicago Launches New UBI Program


The city of Chicago has officially launched its Universal Basic Income pilot program, joining several other major cities across the United States in testing this innovative approach to reducing poverty.


The program, which will provide $500 monthly payments to 5,000 eligible residents for 12 months, aims to address economic inequality and provide financial stability to low-income families.


## Program Details


Participants must meet the following criteria:
- Chicago residency
- Household income below 300% of the federal poverty level
- Experienced economic hardship due to COVID-19


The payments come with no restrictions, allowing recipients to use the funds as they see fit, whether for housing, food, education, or other expenses.


## Expected Outcomes


Researchers will track various outcomes, including:
- Financial stability
- Mental and physical health
- Employment status
- Educational advancement


This data will be crucial in determining the effectiveness of UBI as a policy tool for addressing poverty and inequality.


## How to Apply


Applications will open next month through the city's website. Eligible residents are encouraged to apply early as spots are limited.$txt$,
  'Chicago becomes the latest city to introduce a UBI pilot program, offering monthly payments to 5,000 eligible residents.',
  'Maria Rodriguez', '2023-10-18T10:00:00Z',
  'https://images.unsplash.com/photo-1494522855154-9297ac14b55f?q=80&w=1470&auto=format&fit=crop',
  ARRAY[1, 3]::integer[], ARRAY['pilot program', 'chicago', 'policy']::text[]),


 ('Policy Update: New Federal UBI Framework Announced',
  $txt$The government has announced a new federal framework for Universal Basic Income programs, setting national standards while allowing for regional customization.


## Framework Highlights


- Minimum payment guidelines
- Data collection standards
- Funding mechanisms
- State implementation flexibility


## Timeline


The framework will be implemented in phases over the next three years, beginning with pilot programs in select states.$txt$,
  'A new federal framework aims to standardize UBI implementation while maintaining regional flexibility.',
  'Robert Chen', '2023-10-10T09:00:00.000Z',
  'https://images.unsplash.com/photo-1541872703-74c5e44368f9?auto=format&fit=crop&q=80',
  ARRAY[3, 4]::integer[], ARRAY['policy', 'government', 'regulation']::text[]),


 ('Cryptocurrency UBI Projects See Record Growth',
  $txt$# Cryptocurrency UBI Projects Gaining Momentum


As traditional Universal Basic Income programs continue to be tested in cities and countries worldwide, a parallel movement is growing in the cryptocurrency space.


Blockchain-based UBI initiatives, which leverage digital currencies to distribute regular payments to participants, have seen record growth in both users and funding over the past six months.


## Leading Projects


### GoodDollar


One of the most established crypto UBI projects, GoodDollar has now distributed digital currency to over 300,000 people across 181 countries. The project uses a reserve-backed approach where supporters stake cryptocurrency to generate yield, which is then distributed to users daily.


### Circles UBI


This innovative project creates a local cryptocurrency for communities, with each user receiving a regular basic income in the form of newly minted Circles tokens. The value is maintained through a web of trust between users who verify each other.


## Advantages of Crypto UBI


- **Global reach**: Anyone with internet access can participate, regardless of location
- **Reduced administrative costs**: Automated distribution through smart contracts
- **Financial inclusion**: Provides banking-like services to the unbanked
- **Transparency**: All transactions are visible on the blockchain


## Challenges


Despite the growth, crypto UBI projects face significant challenges, including:


- Volatility of cryptocurrency values
- Technical barriers to entry for many potential users
- Regulatory uncertainty in many jurisdictions
- Limited merchant acceptance of the distributed tokens


## Future Outlook


Experts predict continued growth in this sector as blockchain technology matures and becomes more accessible. The integration of these projects with traditional financial systems will be a key factor in their long-term success and impact.$txt$,
  'Blockchain-based Universal Basic Income initiatives are gaining momentum as technology continues to evolve.',
  'Alex Chen', '2023-10-05T14:30:00Z',
  'https://images.unsplash.com/photo-1639762681057-408e52192e55?q=80&w=1332&auto=format&fit=crop',
  ARRAY[2, 5]::integer[], ARRAY['cryptocurrency', 'blockchain', 'digital currency']::text[]),


 ('Research Shows Positive Mental Health Impact of UBI',
  $txt$# UBI Shows Significant Mental Health Benefits, Study Finds


A comprehensive new study has found that Universal Basic Income programs have a substantial positive impact on recipients' mental health, adding to the growing body of evidence supporting the benefits of guaranteed income policies.


The research, conducted across multiple UBI pilot programs in North America, tracked participants for 18 months and found a 35% reduction in anxiety and depression symptoms compared to control groups.


## Key Findings


The study revealed several important mental health improvements among UBI recipients:


- **Reduced financial stress**: Participants reported significantly lower levels of worry about meeting basic needs
- **Improved sleep quality**: Regular, predictable income led to better sleep patterns
- **Enhanced sense of dignity**: Recipients felt greater autonomy and less stigma compared to traditional welfare programs
- **Increased optimism**: Participants were more likely to make long-term plans and express hope for the future


## Expert Analysis


Dr. Lauren Williams, the study's lead author and professor of public health at Stanford University, emphasized the significance of these findings:


"The mental health benefits we observed were consistent across demographic groups and appeared to be directly linked to the unconditional nature of the payments. When people know they have a reliable income floor, the psychological impact is profound."


Dr. Williams noted that the mental health improvements often preceded other positive outcomes, such as increased workforce participation or educational enrollment.


"Better mental health seems to be a prerequisite for many of the other positive life changes we hope to see from economic interventions," she explained.


## Policy Implications


These findings suggest that UBI programs could have significant public health benefits beyond their economic impact. Mental health conditions cost the U.S. economy an estimated $300 billion annually in lost productivity and healthcare costs.


The researchers recommend that policymakers consider these mental health effects when evaluating the full cost-benefit analysis of UBI and similar guaranteed income programs.$txt$,
  'New study reveals that regular unconditional payments significantly reduce anxiety and depression among recipients.',
  'Dr. James Wilson', '2023-09-22T09:15:00Z',
  'https://images.unsplash.com/photo-1474418397713-7ede21d49118?q=80&w=1453&auto=format&fit=crop',
  ARRAY[1, 4, 7]::integer[], ARRAY['research', 'mental health', 'wellbeing']::text[]);


-- =====================================================================
-- END OF SEED
-- =====================================================================

INSERT INTO public.community_discussions (title, author_name, content, category, tags, created_at)
VALUES 
('What''s your experience with the Alaska Permanent Fund?', 'Sarah Johnson', 'I''ve been receiving dividends from the Alaska Permanent Fund for several years. Curious to hear about others'' experiences and how you''ve used the funds.', 'program_experience', ARRAY['alaska', 'dividend', 'permanent_fund'], '2024-04-15 14:32:00'),
('UBI pilot program launching in my city!', 'Michael Chen', 'Just found out that my city is launching a UBI pilot program that will provide $500/month to 100 residents. Applications open next month. Anyone else heard about this?', 'news', ARRAY['pilot', 'local', 'application'], '2024-04-22 09:15:00'),
('Crypto-based UBI vs Fiat UBI', 'Elena Rodriguez', 'I''ve been looking into protocols like GoodDollar and Proof of Humanity. How do you think these compare to traditional government-funded fiat UBI programs?', 'digital_ubi', ARRAY['crypto', 'gooddollar', 'comparison'], '2024-04-25 11:20:00');

INSERT INTO public.community_announcements (title, content, is_pinned, created_at)
VALUES 
('New UBI Discussion Policy', 'To maintain a productive community, we''ve updated our discussion guidelines. Please review them before posting.', true, '2024-04-25 10:00:00'),
('UBI Finder Community AMA Series', 'Join us next week for our first Ask Me Anything session with the founders of several prominent UBI pilot programs.', false, '2024-04-20 15:30:00');
