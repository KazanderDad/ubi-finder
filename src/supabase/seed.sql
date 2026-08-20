-- =====================================================================
-- UBI Finder — seed.sql
-- Seed data for the `programs`, `blog_posts`, and community tables.
-- Includes active verified programs, plus legacy records marked with internal_status.
-- =====================================================================

-- =====================================================================
-- PROGRAMS (37 rows: 23 Active, 14 Deleted Mock Placeholders)
-- =====================================================================
INSERT INTO programs
 (program_id, name, organization, description, gender_requirement,
  monthly_amount_usd, currency, available_regions, required_states,
  payment_method, amount_description, max_household_income_usd, eligibility,
  status, website, verified, submitter_email,
  payout_status, application_status, apply_url, sources, internal_status)
VALUES
  (1, 'Evanston Guaranteed Income Program 2026', 'City of Evanston',
   'This program provides 102 qualifying Evanston households with $500 per month in unrestricted cash for six months. It targets low-income seniors and families caring for young children, with participants selected by lottery.',
   NULL, 500.00, 'USD',
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
   ARRAY['https://www.cityofevanston.org/residents/community_resources/guaranteed_income_program_2026.php']::text[], 'active'),

  (2, 'Howard County Guaranteed Basic Income 2', 'Howard County Government and Community Action Council of Howard County',
   'The second Howard County Guaranteed Basic Income program provides participating families with $500 per month in unrestricted cash for 12 months. An additional $500 per month is deposited into savings and released after participants complete financial-literacy requirements.',
   NULL, 500.00, 'USD',
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
   ARRAY['https://cac-hc.org/gbi2/']::text[], 'active'),

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
   ARRAY['https://www.neighborstrust.org/program', 'https://www.pa.gov/agencies/dhs/resources/for-residents/guaranteed-income-pilot-projects']::text[], 'active'),

  (4, 'Philly Joy Bank', 'Philadelphia Department of Public Health and Philadelphia City Fund',
   'The Philly Joy Bank provides pregnant Philadelphia residents with $1,000 per month from the second trimester of pregnancy through the child''s first birthday. The program is designed to improve birth outcomes and address racial and geographic disparities in infant mortality.',
   NULL, 1000.00, 'USD',
   ARRAY['United States']::text[],
   ARRAY['Pennsylvania']::text[],
   'standard', '$1,000 per month during pregnancy and child''s first year', 100000.00,
   '• Age 18 or older
• Between 12 and 24 weeks pregnant at enrollment
• Annual household income below 100000 USD
• Resident of an eligible Philadelphia neighborhood
• Eligible neighborhoods include Nicetown-Tioga, Strawberry Mansion, and the qualifying portion of Cobbs Creek',
   'active', 'https://www.phillyjoybank.org/', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://www.phillyjoybank.org/',
   ARRAY['https://philacityfund.org/programs/philly-joy-bank/', 'https://www.phillyjoybank.org/', 'https://www.phillyjoybank.org/faqs']::text[], 'active'),

  (5, 'Rx Kids', 'Michigan State University Rx Kids and GiveDirectly',
   'Rx Kids provides unconditional cash to pregnant mothers and families with infants in participating communities, without an income test. Enrolled families generally receive a $1,500 prenatal payment followed by $500 per month for six to twelve months, depending on the community.',
   'female', 500.00, 'USD',
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
   ARRAY['https://rxkids.org/', 'https://rxkids.org/communities/', 'https://rxkids.aidkit.org/']::text[], 'active'),

  (6, 'Preserving Our Diversity', 'City of Santa Monica',
   'Preserving Our Diversity provides monthly cash assistance to low-income, long-term senior renters living in rent-controlled Santa Monica apartments. Benefits vary according to household circumstances, with the maximum for a one-senior household listed at $939 per month.',
   NULL, 939.00, 'USD',
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
   ARRAY['https://www.santamonica.gov/housing-pod', 'https://www.santamonica.gov/housing-pod-faqs']::text[], 'active'),

  (7, 'Supporting Transitional-Aged Youth and Survivors in Achieving Financial Empowerment Los Angeles', 'City of Los Angeles Community Investment for Families Department',
   'STAY SAFE Los Angeles provides unconditional cash to transitional-aged youth and survivors of intimate-partner violence who are connected to designated community organizations. Participants receive a total of $24,000, generally structured as $1,000 per month, with an alternative front-loaded payment option for some participants.',
   NULL, 1000.00, 'USD',
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
   ARRAY['https://communityinvestment.lacity.gov/programs-resources', 'https://cityclerk.lacity.org/onlinedocs/2021/21-0717-S3_rpt_cao_06-04-25.pdf', 'https://lasentinel.net/price-leads-new-stay-safe-guaranteed-income-expansion.html']::text[], 'active'),

  (8, 'Basic Income for the Arts Scheme 2026-2029', 'Government of Ireland Department of Culture, Communications and Sport',
   'Ireland''s new Basic Income for the Arts scheme will provide 2,000 professional artists and creative-arts workers with EUR 325 per week for three years. The program is intended to support sustained artistic practice and generate further evidence about the effects of basic income in the cultural sector.',
   NULL, 1640.00, 'EUR',
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
   ARRAY['https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-guidelines-for-application/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/publications/basic-income-for-the-arts-scheme-2026-2029-faq/', 'https://www.gov.ie/en/department-of-culture-communications-and-sport/press-releases/minister-odonovan-announces-the-new-basic-income-for-the-arts-scheme/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active'),

  (9, 'Rural Basic Income Pilot Programme', 'Republic of Korea Ministry of Agriculture, Food and Rural Affairs',
   'South Korea''s rural basic-income pilot pays residents of ten participating counties KRW 150,000 per month in locally usable currency during 2026 and 2027. The program seeks to address rural depopulation, strengthen household stability, and stimulate local economic activity.',
   NULL, 107.00, 'KRW',
   ARRAY['South Korea']::text[],
   ARRAY['Gyeonggi', 'Gangwon', 'North Chungcheong', 'South Chungcheong', 'North Jeolla', 'South Jeolla', 'North Gyeongsang', 'South Gyeongsang']::text[],
   'standard', 'KRW 150,000 per month in local currency (~$107 USD monthly)', NULL,
   '• Registered resident of one of the ten participating counties
• Must actually reside in the participating county
• Residents with uncertain residence may need to demonstrate presence at least three days per week
• New residents may need to complete a 90-day residence-verification period',
   'active', 'https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG', true, NULL,
   'Ongoing', 'Accepting local applications and residence verification', 'https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG',
   ARRAY['https://www.mafra.go.kr/english/756/subview.do?enc=Zm5jdDF8QEB8JTJGYmJzJTJGZW5nbGlzaCUyRjI1JTJGNTc3MjIzJTJGYXJ0Y2xWaWV3LmRvJTNG']::text[], 'active'),

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
   ARRAY['https://mof.gov.mh/usdm1/enra/', 'https://mof.gov.mh/usdm1-whitepaper/', 'https://marshallislandsjournal.com/enra-bump-up/', 'https://eastasiaforum.org/2026/01/07/the-price-of-the-marshall-islands-universal-basic-income/']::text[], 'active'),

  (11, 'Alaska Permanent Fund Dividend 2026', 'State of Alaska Permanent Fund Dividend Division',
   'The Alaska Permanent Fund Dividend distributes an annual cash payment to qualifying residents from state mineral-revenue investment earnings. The 2026 payment was set at a combined $1,200, including the dividend and energy rebate, which is shown here as a $100 monthly equivalent.',
   NULL, 100.00, 'USD',
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
   ARRAY['https://pfd.alaska.gov/', 'https://pfd.alaska.gov/eligibility/eligibility-requirements', 'https://pfd.alaska.gov/application/filing-period', 'https://alaskabeacon.com/2026/05/18/alaska-lawmakers-reach-budget-deal-with-1000-pfd-and-200-energy-rebate-for-residents/']::text[], 'active'),

  (12, 'Macao Wealth Partaking Scheme 2026', 'Government of the Macao Special Administrative Region',
   'The Wealth Partaking Scheme distributes an annual cash payment to qualifying Macao residents, with permanent residents receiving MOP 10,000 in 2026. The listed monthly amount is the approximate monthly equivalent of that annual payment, while residents with qualifying absences may submit an exception claim.',
   NULL, 104.00, 'MOP',
   ARRAY['China']::text[],
   ARRAY['Macao Special Administrative Region']::text[],
   'standard', 'MOP 10,000 annual payment (~$104 USD monthly equivalent)', NULL,
   '• Holder of a valid or renewable Macao resident identity card
• Permanent-resident payment requires permanent resident status
• Generally present in Macao for at least 183 days during 2025
• Residents below the 183-day threshold must qualify for an approved exemption',
   'active', 'https://www.planocp.gov.mo/en/request/atleast183_2026', true, NULL,
   '2026 standard distribution completed; approved exception claims continue', 'Automatic for listed residents; residence-exception claims accepted', 'https://www.planocp.gov.mo/en/request/atleast183_2026',
   ARRAY['https://www.planocp.gov.mo/en/about/intro', 'https://www.planocp.gov.mo/en/timetable', 'https://www.planocp.gov.mo/en/faq', 'https://www.planocp.gov.mo/en/request/atleast183_2026']::text[], 'active'),

  (13, 'Québec Basic Income Program', 'Government of Québec',
   'Québec''s Basic Income Program provides an enhanced monthly income to people with severe and persistent health-related employment limitations. Eligible Social Solidarity recipients are generally enrolled automatically, and the 2026 base benefit is CAD 1,336 per month before possible adjustments.',
   NULL, 961.00, 'CAD',
   ARRAY['Canada']::text[],
   ARRAY['Quebec']::text[],
   'standard', 'CAD 1,336 per month base benefit (~$961 USD monthly)', NULL,
   '• Recipient of Québec''s Social Solidarity Program
• Severe employment limitations
• Must have had severe employment limitations for at least 66 of the previous 72 months
• Must continue satisfying applicable income and asset rules',
   'active', 'https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program', true, NULL,
   'Ongoing', 'Automatic enrollment', 'https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program',
   ARRAY['https://www.quebec.ca/en/family-and-support-for-individuals/social-assistance-social-solidarity/basic-income-program', 'https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates-lookup/']::text[], 'active'),

  (14, 'Guaranteed Income Supplement', 'Government of Canada',
   'The Guaranteed Income Supplement is a monthly, tax-free payment for low-income seniors who receive the Old Age Security pension. The maximum payment for a single, widowed, or divorced recipient is approximately CAD 1,123.17 per month, although the actual amount depends on income and marital status.',
   NULL, 808.00, 'CAD',
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
   ARRAY['https://www.canada.ca/en/services/benefits/publicpensions/old-age-security/guaranteed-income-supplement.html', 'https://www.bankofcanada.ca/rates/exchange/daily-exchange-rates-lookup/']::text[], 'active'),

  (15, 'Ingreso Mínimo Vital', 'Government of Spain Social Security Administration',
   'Ingreso Mínimo Vital is a national minimum-income benefit intended to prevent poverty and social exclusion among financially vulnerable individuals and households. In 2026, the guaranteed benchmark for a single adult is EUR 733.60 per month, with the actual payment calculated as the difference between the benchmark and countable household income.',
   NULL, 851.00, 'EUR',
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
   ARRAY['https://www.seg-social.es/wps/portal/wss/internet/Trabajadores/PrestacionesPensionesTrabajadores/65850d68-8d06-4645-bde7-05374ee42ac7', 'https://imv.seg-social.es/', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active'),

  (16, 'Social Relief of Distress Grant', 'South African Social Security Agency',
   'South Africa''s Social Relief of Distress Grant provides ZAR 370 per month to working-age people with insufficient income or financial support. The national benefit has been extended through March 2027 and uses recurring income and identity checks to determine monthly eligibility.',
   NULL, 23.00, 'ZAR',
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
   ARRAY['https://srd.sassa.gov.za/', 'https://srd.sassa.gov.za/said', 'https://www.sanews.gov.za/south-africa/public-comment-sought-special-covid-19-srd-amendments', 'https://www.sanews.gov.za/south-africa/social-grants-increase']::text[], 'active'),

  (17, 'GiveDirectly 12-Year Universal Basic Income Study', 'GiveDirectly',
   'GiveDirectly''s long-term Kenya study provides selected adults with approximately $22.50 per month for 12 years, making it one of the longest-running randomized basic-income experiments. Payments are unconditional and delivered through mobile money to eligible adults in selected rural villages.',
   NULL, 22.50, 'KES',
   ARRAY['Kenya']::text[],
   ARRAY[]::text[],
   'standard', 'Approximately $22.50 USD per month for 12 years', NULL,
   '• Adult resident of a village selected for the long-term treatment group
• Must have been enrolled during the original village census and enrollment period
• Must maintain access to the registered mobile-money payment channel
• No work, spending, or repayment conditions',
   'active', 'https://www.givedirectly.org/ubi', true, NULL,
   'Ongoing', 'No longer accepting applications', 'https://www.givedirectly.org/ubi',
   ARRAY['https://www.givedirectly.org/ubi', 'https://www.givedirectly.org/2023-ubi-results']::text[], 'active'),

  (18, 'Mein Grundeinkommen Basic Income Raffle', 'Mein Grundeinkommen e.V.',
   'Mein Grundeinkommen uses crowdfunding to award unconditional basic incomes through free public raffles. Each winner receives EUR 1,000 per month for one year, and participation is open internationally subject to the organization''s registration and raffle rules.',
   NULL, 1161.00, 'EUR',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'standard', 'EUR 1,000 per month for 1 year (~$1,161 USD monthly)', NULL,
   '• Create a Mein Grundeinkommen account
• Register for or confirm participation in an upcoming raffle
• Comply with the raffle terms and identity-verification requirements
• No income or employment requirement',
   'active', 'https://www.mein-grundeinkommen.de/verlosung', true, NULL,
   'Ongoing', 'Accepting raffle entries', 'https://www.mein-grundeinkommen.de/verlosung',
   ARRAY['https://www.mein-grundeinkommen.de/', 'https://www.mein-grundeinkommen.de/verlosung', 'https://www.mein-grundeinkommen.de/infos/in-english', 'https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-usd.en.html']::text[], 'active'),

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
   ARRAY['https://support.world.org/hc/en-us/articles/30969185598739-Updates-to-the-Airdrop-Program', 'https://whitepaper.world.org/designing-for-scale/2026-03-24', 'https://www.kraken.com/prices/worldcoin']::text[], 'active'),

  (20, 'Citizen Account Program', 'Government of Saudi Arabia Ministry of Human Resources and Social Development',
   'Saudi Arabia''s Citizen Account Program provides monthly cash support to eligible households to offset the effects of economic reforms and changes in living costs. Payment amounts vary by household income and composition, with a reported average family payment of approximately SAR 1,474 in early 2026.',
   NULL, 393.00, 'SAR',
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
   ARRAY['https://www.hrsd.gov.sa/en/care-about-you/social-protection', 'https://www.hrsd.gov.sa/en/media-center/news/%D9%85%D9%86%D8%B8%D9%88%D9%85%D8%A9-%D8%A7%D9%84%D9%85%D9%88%D8%A7%D8%B1%D8%AF-%D8%A7%D9%84%D8%A8%D8%B4%D8%B1%D9%8A%D8%A9-%D8%AD%D9%82%D9%82%D8%AA-70-%D9%85%D9%86-%D9%85%D8%B3%D8%AA%D9%87%D8%AF%D9%81%D8%A7%D8%AA%D9%87%D8%A7', 'https://eservices.ca.gov.sa/', 'https://www.middleeastmonitor.com/20260112-9-8-million-saudis-receive-cash-support/']::text[], 'active'),

  (21, 'GoodDollar', 'GoodDollar Foundation & GoodDAO',
   'GoodDollar is a decentralized, reserve-backed crypto basic income protocol and DAO. It generates yield through DeFi protocols and distributes daily G$ basic income directly to verified unique humans globally via smart contracts on Celo and Ethereum networks.',
   NULL, 10.00, 'G$',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'digital', 'Daily free G$ claims via GoodWallet (approx. $5–$15 USD/mo)', NULL,
   '• Unique human verification via FaceTec 3D liveness check
• Compatible Web3 wallet (GoodWallet / Celo / Ethereum)
• Claimable once every 24 hours
• No minimum income, location, or citizenship restriction',
   'active', 'https://wallet.gooddollar.org', true, NULL,
   'Ongoing daily', 'Accepting registrations', 'https://wallet.gooddollar.org',
   ARRAY['https://www.gooddollar.org', 'https://dashboard.gooddollar.org', 'https://docs.gooddollar.org']::text[], 'active'),

  (22, 'European Digital Euro Pilot', 'European Central Bank & Eurosystem',
   'The European Digital Euro initiative is the ECB''s official framework and preparatory testing phase exploring a digital euro central bank digital currency (CBDC) to complement cash, strengthen European monetary sovereignty, and enable universal, instant digital payment rails for euro area residents.',
   NULL, 47.00, 'EUR',
   ARRAY['Germany', 'France', 'Spain', 'Italy', 'Ireland', 'Netherlands', 'Belgium', 'Austria', 'Portugal', 'Finland', 'Greece']::text[],
   ARRAY[]::text[],
   'digital', '43 EUR (~$47 USD) testing allowance benchmark', NULL,
   '• Resident of a participating Eurozone member state
• Euro-denominated payment account with a licensed European Payment Service Provider (PSP)
• Identity verification satisfying EU AML/KYC requirements
• Participation subject to ECB pilot cohort selection',
   'upcoming', 'https://www.ecb.europa.eu/paym/digital_euro/', true, NULL,
   'Planned for 2027 testing phase', 'Not open yet / Institutional pilot', 'https://www.ecb.europa.eu/paym/digital_euro/',
   ARRAY['https://www.ecb.europa.eu/paym/digital_euro/', 'https://www.centralbank.ie/consumer-hub/digital-euro']::text[], 'active'),

  (23, 'FundLoop', 'FundLoop Network',
   'FundLoop is a monthly networked economy for shared prosperity. Participating software projects pool a recurring percentage of revenue, verified contributors prove personhood via CUBID.me, and each monthly epoch automatically distributes and accounts for claimable Citizen Salary awards.',
   NULL, 25.00, 'USD',
   ARRAY['Global']::text[],
   ARRAY[]::text[],
   'digital', 'Monthly revenue-share distribution based on contribution & participation', NULL,
   '• Connect CUBID.me to prove uniqueness and personhood without exposing private identity
• Participate in or contribute to one or more participating network projects
• Active account in good standing during the open epoch cycle
• Open to all verified individuals worldwide',
   'active_open', 'https://fundloop-website.vercel.app/en', true, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting registrations', 'https://fundloop-website.vercel.app/en',
   ARRAY['https://fundloop-website.vercel.app/en', 'https://fundloop.org']::text[], 'active'),

  -- 14 Legacy Mock Placeholders (Marked Deleted)
  (24, 'Community Support Initiative', 'Regional Development Council', 'Quarterly support payments for local residents', NULL,
   123.00, 'USD', ARRAY['Australia', 'New Zealand']::text[], ARRAY[]::text[], 'standard', '123 per month', NULL,
   'Local residents meeting income criteria', 'active', 'https://example.com/program2', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/program2', ARRAY[]::text[], 'deleted'),

  (25, 'Digital Income Project', 'Future Foundation', 'Monthly digital currency payments for eligible participants', NULL,
   234.00, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[], 'digital', '234 per month', 40000.00,
   'Must be a resident of CA or NY', 'active', 'https://example.com/digital-income', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/digital-income', ARRAY[]::text[], 'deleted'),

  (26, 'Global Basic Income', 'World UBI Initiative', 'Worldwide basic income program with flexible payment options', NULL,
   329.00, 'USD', ARRAY[]::text[], ARRAY[]::text[], 'both', '345', NULL,
   'Open to all globally', 'upcoming', 'https://example.com/global-ubi', true, NULL,
   'Planned', 'Not open yet', 'https://example.com/global-ubi', ARRAY[]::text[], 'deleted'),

  (27, 'Women''s Empowerment Fund', 'Global Women''s Initiative', 'Supporting women through monthly basic income', 'female',
   800.00, 'USD', ARRAY['United States', 'Canada', 'United Kingdom']::text[], ARRAY[]::text[], 'both', '$800 monthly', 50000.00,
   'Women in eligible countries', 'active', 'https://example.com/wef', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/wef', ARRAY[]::text[], 'deleted'),

  (28, 'Youth Basic Income', 'Future Foundation', 'Basic income for young adults', NULL,
   1000.00, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[], 'digital', '$1,000 monthly', 30000.00,
   '18-25 year olds in CA or NY', 'active', 'https://example.com/ybi', true, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/ybi', ARRAY[]::text[], 'deleted'),

  (29, 'Digital Income Project (Duplicate)', 'Future Economy Foundation', 'A pilot program providing monthly digital currency payments to residents in select urban areas.', NULL,
   500.00, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[], 'digital', '$500 monthly in digital currency', NULL,
   NULL, 'active', 'https://example.com/digital-income', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/digital-income', ARRAY[]::text[], 'deleted'),

  (30, 'Community Support Initiative (Duplicate)', 'Regional Development Coalition', 'Providing basic income to support local community resilience and economic development.', NULL,
   650.00, 'USD', ARRAY['United States']::text[], ARRAY['Michigan', 'Ohio', 'Pennsylvania']::text[], 'standard', '$650 monthly via direct deposit', NULL,
   NULL, 'active', 'https://example.com/community-support', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/community-support', ARRAY[]::text[], 'deleted'),

  (31, 'Rural Resilience Program', 'Agricultural Futures Institute', 'Supporting rural communities with monthly income supplements to address economic challenges in agricultural regions.', NULL,
   450.00, 'USD', ARRAY['United States', 'Canada']::text[], ARRAY[]::text[], 'both', '$450 monthly with payment options', NULL,
   NULL, 'active', 'https://example.com/rural-resilience', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/rural-resilience', ARRAY[]::text[], 'deleted'),

  (32, 'Youth Opportunity Fund', 'Next Generation Alliance', 'Providing financial support to young adults ages 18-24 to pursue education, training, or entrepreneurship.', NULL,
   800.00, 'USD', ARRAY['United Kingdom', 'Canada']::text[], ARRAY[]::text[], 'standard', '$800 monthly stipend', NULL,
   NULL, 'upcoming', 'https://example.com/youth-opportunity', false, NULL,
   'Planned', 'Not open yet', 'https://example.com/youth-opportunity', ARRAY[]::text[], 'deleted'),

  (33, 'asdf', 'asdf', 'afsd', NULL,
   12.00, 'USD', ARRAY[]::text[], ARRAY[]::text[], 'standard', 'asdf', NULL,
   'asdf', 'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting applications', 'https://asdf.com', ARRAY[]::text[], 'deleted'),

  (34, 'Test 2', 'asdf', 'asdf', NULL,
   0.00, 'USD', ARRAY[]::text[], ARRAY[]::text[], 'standard', 'asdf', NULL,
   'asdf', 'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com',
   'Ongoing', 'Accepting applications', 'https://asdf.com', ARRAY[]::text[], 'deleted'),

  (35, 'Women''s Economic Empowerment Initiative', 'Gender Equity Coalition', 'Financial support program designed to promote economic independence and entrepreneurship for women.', 'female',
   700.00, 'USD', ARRAY['United States', 'Canada', 'United Kingdom']::text[], ARRAY[]::text[], 'standard', '$700 monthly grant', NULL,
   NULL, 'active', 'https://example.com/womens-empowerment', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/womens-empowerment', ARRAY[]::text[], 'deleted'),

  (36, 'Universal Dividend Network', 'Global Commons Foundation', 'Blockchain-based UBI available worldwide, using cryptocurrency for efficient borderless payments.', NULL,
   300.00, 'USD', ARRAY[]::text[], ARRAY[]::text[], 'digital', 'Equivalent of $300 monthly in cryptocurrency', NULL,
   NULL, 'active', 'https://example.com/universal-dividend', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/universal-dividend', ARRAY[]::text[], 'deleted'),

  (37, 'Senior Security Program', 'Elder Care Alliance', 'Income supplement for seniors over 65 to help with rising costs of living and healthcare expenses.', NULL,
   550.00, 'USD', ARRAY['United States', 'Canada']::text[], ARRAY[]::text[], 'standard', '$550 monthly payment', NULL,
   NULL, 'active', 'https://example.com/senior-security', false, NULL,
   'Ongoing', 'Accepting applications', 'https://example.com/senior-security', ARRAY[]::text[], 'deleted')
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
  internal_status = excluded.internal_status;



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
