# Caddie IQ — Complete Setup Guide
## From zero to live website in ~30 minutes

---

## What You're Setting Up

| Service | What it does | Cost |
|---------|-------------|------|
| **Supabase** | Database + Login system | Free |
| **Vercel** | Hosts your website | Free |
| **Anthropic** | AI analysis (Claude) | ~$5/mo light use |
| **Namecheap** (optional) | Custom domain like caddieiq.com | ~$12/yr |

---

## STEP 1 — Get Your Anthropic API Key

1. Go to **console.anthropic.com**
2. Sign in (or create account)
3. Click **"API Keys"** in left sidebar
4. Click **"Create Key"** → name it "CaddieIQ"
5. **Copy the key** — it starts with `sk-ant-...`
6. Save it somewhere safe — you only see it once!


---

## STEP 2 — Set Up Supabase (Database + Login)
https://lcedamercezvwpombihf.supabase.co
1. Go to **supabase.com** → click "Start your project" → sign in with GitHub
2. Click **"New Project"**
   - Name: `caddieiq`
   - Database password: create a strong one and save it
   - Region: pick the one closest to you (US East, etc.)
   - Click **"Create new project"** (takes ~2 minutes)

3. **Run the database setup:**
   - In your project, click **"SQL Editor"** in the left sidebar
   - Click **"New query"**
   - Open the file `supabase-setup.sql` from this folder
   - Copy ALL the contents and paste into the SQL editor
   - Click **"Run"** (green button)
   - You should see "Success" — your tables are created!

4. **Enable Email Auth:**
   - In left sidebar: **Authentication** → **Providers**
   - Make sure **"Email"** is enabled (it is by default)
   - Optional: under "Email" settings, you can turn off "Confirm email" 
     while testing so users don't need to confirm their email first

5. **Get your API keys:**
   - In left sidebar: **Project Settings** → **API**
   - Copy **"Project URL"** — looks like `https://abcdefgh.supabase.co`
   - Copy **"anon / public"** key — long string starting with `eyJ...`

---

## STEP 3 — Update index.html With Your Keys

Open `index.html` and find these two lines near the top of the `<script>` section:

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY_HERE';
```

Replace them with your actual values:

```javascript
const SUPABASE_URL = 'https://abcdefghijklmn.supabase.co';  // yours here
const SUPABASE_ANON_KEY = 'eyJhbGc...your-actual-key...';   // yours here
```

Save the file.

---

## STEP 4 — Push to GitHub

Vercel deploys from GitHub, so you need your files there first.

1. Go to **github.com** → sign in → click **"+"** → **"New repository"**
2. Name it `caddieiq` → keep it **Private** → click "Create repository"
3. GitHub will show you commands. You have two options:

**Option A — GitHub Desktop (easier, no terminal):**
- Download **GitHub Desktop** at desktop.github.com
- Click "Add an Existing Repository from your Hard Drive"
- Point it to your `caddieiq` folder
- Click "Publish Repository" → choose your GitHub account → uncheck "Keep this code private" if you want (or keep private)
- Click "Publish Repository"

**Option B — Terminal (if you're comfortable):**
```bash
cd /path/to/your/caddieiq/folder
git init
git add .
git commit -m "Initial Caddie IQ build"
git remote add origin https://github.com/YOUR_USERNAME/caddieiq.git
git push -u origin main
```

---

## STEP 5 — Deploy on Vercel

1. Go to **vercel.com** → click "Sign Up" → **Continue with GitHub**
2. Click **"Add New..."** → **"Project"**
3. Find your `caddieiq` repository → click **"Import"**
4. On the configuration screen:
   - Framework Preset: **Other** (or it may auto-detect)
   - Root Directory: leave as `./`
   - Don't touch Build settings
5. Click **"Environment Variables"** section → add these one at a time:

   | Name | Value |
   |------|-------|
   | `ANTHROPIC_API_KEY` | `sk-ant-your-key-here` |

6. Click **"Deploy"**
7. Wait ~1 minute → Vercel gives you a live URL like `caddieiq.vercel.app` 🎉

---

## STEP 6 (Optional) — Add a Custom Domain

1. Buy a domain at **namecheap.com** (search for `caddieiq.com` or similar, ~$12/yr)
2. In Vercel: your project → **Settings** → **Domains**
3. Click **"Add"** → type your domain → click **"Add"**
4. Vercel shows you DNS records to add
5. Go to Namecheap → **Domain List** → **Manage** → **Advanced DNS**
6. Add the records Vercel showed you
7. Wait 5–30 minutes for DNS to propagate → your site is live on your custom domain!

---

## STEP 7 — Test Everything

1. Go to your Vercel URL
2. Create an account with your email
3. Check your email for a confirmation link (click it)
4. Sign in → you should see the app
5. Go to **Upload Data** → click "Load Demo Data" → click "Analyze with AI Caddie"
6. Wait ~5 seconds → you should see a full AI analysis appear
7. Go to **History** → your analysis should be saved there
8. Open an incognito window → sign in again → your history should still be there ✅

---

## Troubleshooting

**"Error connecting to AI" message:**
- Check that your `ANTHROPIC_API_KEY` was added correctly in Vercel
- Go to Vercel → your project → Settings → Environment Variables → verify it's there
- Redeploy: Vercel → your project → Deployments → click the three dots → Redeploy

**Login not working:**
- Check that your Supabase URL and anon key are correct in `index.html`
- Make sure you ran the SQL setup script successfully
- Check Supabase → Authentication → Users to see if accounts are being created

**History not saving:**
- Go to Supabase → Table Editor → check that the `analyses` table exists
- Check Supabase → Authentication → Policies — make sure RLS policies were created

**Making updates:**
- Edit your files locally
- Push to GitHub (GitHub Desktop: commit → push)
- Vercel auto-deploys every time you push to GitHub — no extra steps needed!

---

## What You Have Now

✅ Live website anyone can visit  
✅ User accounts — each person's data is private  
✅ Cloud database — history saves across all devices  
✅ Secure AI — your API key is never exposed to users  
✅ Auto-deploys — push to GitHub → site updates automatically  

---

## Next Steps (Future Sessions)

- **Trend charts** — visualize your club path and face angle over time
- **Club-by-club breakdown** — see which clubs need the most work  
- **PDF reports** — export a shareable report for your golf instructor  
- **iPhone app** — convert to React Native using this same backend  
