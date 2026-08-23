-- Migration: 00003_community.sql
-- Purpose: Add tables for community discussions and announcements.

CREATE TABLE IF NOT EXISTS public.community_discussions (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title text NOT NULL,
    author_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,
    author_name text NOT NULL,
    content text NOT NULL,
    category text,
    tags text[] DEFAULT array[]::text[],
    likes integer DEFAULT 0,
    replies integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.community_announcements (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    title text NOT NULL,
    content text NOT NULL,
    is_pinned boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now()
);

-- RLS
ALTER TABLE public.community_discussions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.community_announcements ENABLE ROW LEVEL SECURITY;

-- Policies for Discussions
CREATE POLICY "Discussions are viewable by everyone" 
ON public.community_discussions FOR SELECT USING (true);

CREATE POLICY "Authenticated users can insert discussions" 
ON public.community_discussions FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = author_id);

-- Policies for Announcements
CREATE POLICY "Announcements are viewable by everyone" 
ON public.community_announcements FOR SELECT USING (true);
