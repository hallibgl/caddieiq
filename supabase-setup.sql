-- ============================================================
-- CADDIE IQ — Supabase Database Setup
-- Run this entire file in: Supabase Dashboard > SQL Editor
-- ============================================================

-- 1. PROFILES TABLE
--    Stores each user's handicap and shot goal
CREATE TABLE IF NOT EXISTS profiles (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id     UUID REFERENCES auth.users NOT NULL UNIQUE,
  handicap    TEXT,
  goal        TEXT,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. ANALYSES TABLE
--    Stores every AI analysis — shot diagnoses, CSV sessions, roadmap advice
CREATE TABLE IF NOT EXISTS analyses (
  id                UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id           UUID REFERENCES auth.users NOT NULL,
  title             TEXT NOT NULL,
  subtitle          TEXT,
  content           TEXT NOT NULL,          -- The full AI response
  session_type      TEXT DEFAULT 'manual',  -- 'upload' | 'shot_analyzer' | 'roadmap'
  raw_data          JSONB,                  -- Original CSV data (optional)
  handicap_at_time  TEXT,                   -- Their handicap when analysis was run
  created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- 3. ROW LEVEL SECURITY (RLS)
--    This is critical — ensures users can ONLY see their own data

ALTER TABLE profiles  ENABLE ROW LEVEL SECURITY;
ALTER TABLE analyses  ENABLE ROW LEVEL SECURITY;

-- Profiles: users can only read/write their own profile
CREATE POLICY "Users can view their own profile"
  ON profiles FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = user_id);

-- Analyses: users can only read/write/delete their own analyses
CREATE POLICY "Users can view their own analyses"
  ON analyses FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own analyses"
  ON analyses FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own analyses"
  ON analyses FOR DELETE
  USING (auth.uid() = user_id);

-- 4. PERFORMANCE INDEXES
CREATE INDEX IF NOT EXISTS analyses_user_id_idx     ON analyses(user_id);
CREATE INDEX IF NOT EXISTS analyses_created_at_idx  ON analyses(created_at DESC);
CREATE INDEX IF NOT EXISTS profiles_user_id_idx     ON profiles(user_id);

-- ============================================================
-- DONE! Your database is ready.
-- Next: add your Supabase URL and anon key to index.html
-- ============================================================
