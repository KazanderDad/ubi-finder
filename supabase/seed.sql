-- =====================================================================
-- UBI Finder — seed.sql
-- Seed data for the `programs` and `blog_posts` tables.
-- Captured from the live Base44 app data on 2026-08-19.
--
-- Assumptions:
--   * Table/column names match supabase/migrations/00001_init.sql.
--     If your migration uses different names, adjust accordingly.
--   * Array columns (available_regions, required_states, related_programs,
--     tags) are TEXT[]. If your schema uses JSONB, replace ARRAY[...]::text[]
--     with '["..."]'::jsonb.
--   * Built-in columns (id, created_date, updated_date, created_by_id) are
--     omitted and left to default, except where noted.
--   * `currency` defaults to 'USD' where the source record had none.
--   * `gender_requirement`, `max_household_income_usd`, `eligibility`,
--     `submitter_email` may be NULL.
--   * Long text fields use dollar-quoting ($txt$ ... $txt$) to preserve
--     newlines and quotes verbatim.
-- =====================================================================


-- =====================================================================
-- PROGRAMS (17 rows)
-- =====================================================================
INSERT INTO programs
 (program_id, name, organization, description, gender_requirement,
  monthly_amount_usd, currency, available_regions, required_states,
  payment_method, amount_description, max_household_income_usd, eligibility,
  status, website, verified, submitter_email)
VALUES
 (1, 'GoodDollar', 'Good DAO', 'Daily small digital currency payments for everyone', NULL,
  10, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'digital', 'A few GoodDollars every day if you claim, corresponding to a few cents.', NULL,
  'Open to anyone with an Ethereum-compatible account',
  'active', 'https://example.com/program1', true, NULL),


 (2, 'Community Support Initiative', 'Regional Development Council', 'Quarterly support payments for local residents', NULL,
  123, 'USD', ARRAY['Australia', 'New Zealand']::text[], ARRAY[]::text[],
  'standard', '123 per month', NULL,
  'Local residents meeting income criteria',
  'active', 'https://example.com/program2', true, NULL),


 (3, 'Digital Income Project', 'Future Foundation', 'Monthly digital currency payments for eligible participants', NULL,
  234, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[],
  'digital', '234 per month', 40000,
  'Must be a resident of CA or NY',
  'active', 'https://example.com/digital-income', true, NULL),


 (4, 'Global Basic Income', 'World UBI Initiative', 'Worldwide basic income program with flexible payment options', NULL,
  329, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'both', '345', NULL,
  'Open to all globally',
  'upcoming', 'https://example.com/global-ubi', true, NULL),


 (5, 'European Digital Euro Pilot', 'EU Digital Currency Initiative', 'Digital Euro basic income pilot program', NULL,
  43, 'EUR', ARRAY['Germany', 'France', 'Spain', 'Italy', 'Ireland']::text[], ARRAY[]::text[],
  'digital', '43 per month', 45000,
  'EU residents only',
  'active', 'https://example.com/eu-digital', true, NULL),


 (6, 'Women''s Empowerment Fund', 'Global Women''s Initiative', 'Supporting women through monthly basic income', 'female',
  800, 'USD', ARRAY['United States', 'Canada', 'United Kingdom']::text[], ARRAY[]::text[],
  'both', '$800 monthly', 50000,
  'Women in eligible countries',
  'active', 'https://example.com/wef', true, NULL),


 (7, 'Youth Basic Income', 'Future Foundation', 'Basic income for young adults', NULL,
  1000, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[],
  'digital', '$1,000 monthly', 30000,
  '18-25 year olds in CA or NY',
  'active', 'https://example.com/ybi', true, NULL),


 (8, 'Digital Income Project', 'Future Economy Foundation', 'A pilot program providing monthly digital currency payments to residents in select urban areas.', NULL,
  500, 'USD', ARRAY['United States']::text[], ARRAY['California', 'New York']::text[],
  'digital', '$500 monthly in digital currency', NULL,
  NULL,
  'active', 'https://example.com/digital-income', false, NULL),


 (9, 'Community Support Initiative', 'Regional Development Coalition', 'Providing basic income to support local community resilience and economic development.', NULL,
  650, 'USD', ARRAY['United States']::text[], ARRAY['Michigan', 'Ohio', 'Pennsylvania']::text[],
  'standard', '$650 monthly via direct deposit', NULL,
  NULL,
  'active', 'https://example.com/community-support', false, NULL),


 (10, 'Rural Resilience Program', 'Agricultural Futures Institute', 'Supporting rural communities with monthly income supplements to address economic challenges in agricultural regions.', NULL,
  450, 'USD', ARRAY['United States', 'Canada']::text[], ARRAY[]::text[],
  'both', '$450 monthly with payment options', NULL,
  NULL,
  'active', 'https://example.com/rural-resilience', false, NULL),


 (11, 'Youth Opportunity Fund', 'Next Generation Alliance', 'Providing financial support to young adults ages 18-24 to pursue education, training, or entrepreneurship.', NULL,
  800, 'USD', ARRAY['United Kingdom', 'Canada']::text[], ARRAY[]::text[],
  'standard', '$800 monthly stipend', NULL,
  NULL,
  'upcoming', 'https://example.com/youth-opportunity', false, NULL),


 (12, 'asdf', 'asdf', 'afsd', NULL,
  12, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'standard', 'asdf', NULL,
  'asdf',
  'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com'),


 (13, 'FundLoop - Get Citizen Salary for just participating.', 'FundLoop',
  $txt$Projects share 1% of their revenue to the FundLoop pool, and they share anonymized user info - simple zero-knowledge identifiers about their active users in good standing.


FundLoop runs monthly quadratically weighted algorithms to balance and distribute the funds to everyone who participated in two or more projects.


Users get Citizen Salary streamed to their accounts as an airdrop. As simple as that.$txt$,
  NULL, 10, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'digital', 'Daily stream of money, adjusted monthly.', NULL,
  'This program is open to all humans everywhere on the globe. All you need is a FundLoop account, and use two or more of the participating projects at least monthly.',
  'active_open', 'https://fundloop.org', false, 'kazanderdad@gmail.com'),


 (14, 'Test 2', 'asdf', 'asdf', NULL,
  0, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'standard', 'asdf', NULL,
  'asdf',
  'active_open', 'https://asdf.com', false, 'kazanderdad@gmail.com'),


 (15, 'Women''s Economic Empowerment Initiative', 'Gender Equity Coalition', 'Financial support program designed to promote economic independence and entrepreneurship for women.', 'female',
  700, 'USD', ARRAY['United States', 'Canada', 'United Kingdom']::text[], ARRAY[]::text[],
  'standard', '$700 monthly grant', NULL,
  NULL,
  'active', 'https://example.com/womens-empowerment', false, NULL),


 (16, 'Universal Dividend Network', 'Global Commons Foundation', 'Blockchain-based UBI available worldwide, using cryptocurrency for efficient borderless payments.', NULL,
  300, 'USD', ARRAY[]::text[], ARRAY[]::text[],
  'digital', 'Equivalent of $300 monthly in cryptocurrency', NULL,
  NULL,
  'active', 'https://example.com/universal-dividend', false, NULL),


 (17, 'Senior Security Program', 'Elder Care Alliance', 'Income supplement for seniors over 65 to help with rising costs of living and healthcare expenses.', NULL,
  550, 'USD', ARRAY['United States', 'Canada']::text[], ARRAY[]::text[],
  'standard', '$550 monthly payment', NULL,
  NULL,
  'active', 'https://example.com/senior-security', false, NULL);




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
