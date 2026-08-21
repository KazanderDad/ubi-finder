-- Migration 00011: Support Donations Table for project contributions

CREATE TABLE IF NOT EXISTS public.support_donations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    amount_usd NUMERIC NOT NULL,
    donor_name TEXT,
    donor_email TEXT,
    payment_method TEXT DEFAULT 'unspecified',
    status TEXT DEFAULT 'pledged',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.support_donations ENABLE ROW LEVEL SECURITY;

-- Allow public inserts for donations
CREATE POLICY "Allow public insert to support_donations"
ON public.support_donations
FOR INSERT
TO public
WITH CHECK (true);

-- Allow users to view their own donations
CREATE POLICY "Allow users to select own support_donations"
ON public.support_donations
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- Allow service_role / admins to view all
CREATE POLICY "Allow admin to select all support_donations"
ON public.support_donations
FOR ALL
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.users
        WHERE users.id = auth.uid() AND users.role = 'admin'
    )
);
