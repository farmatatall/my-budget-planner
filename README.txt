# My Budget Planner · 2026–2027

A Neapolitan-colour personal money planner, installable as a Progressive Web App (PWA).

## Included
- Paycheck planner and budget allocations
- Monthly and weekly budget views
- Transaction tracker
- Accounts and cash tracking
- Bills and recurring expenses
- School / tuition planning
- Savings goals and emergency fund
- Debt tracker and payment history
- 40-slot wishlist with item and price
- Monthly reflections, notes and backup / restore
- Optional private cloud sync through Supabase

## Publish the website
This repository is public. In the repository, open **Settings → Pages** and choose **GitHub Actions** as the Source. The workflow in `.github/workflows/deploy.yml` publishes the website when changes are pushed to `main`. If Pages is not enabled yet, this one-time setting must be completed by the repository owner.

## Install on a phone
Open the published HTTPS site in Safari on iPhone and choose **Share → Add to Home Screen**. On Android, open it in Chrome and choose **Install app / Add to Home screen**. This is a PWA, not a native App Store app.

## Privacy
This repository and the published GitHub Pages site are public. Anyone can view the website source and default settings. The planner's ordinary entries are stored in the browser on the device where they are entered unless optional cloud sync is configured. Do not enter bank passwords, full card numbers, or other highly sensitive information. Do not commit JSON backups, bank statements, or personal financial records to this repository.

Optional cloud sync is not active until a Supabase project is configured. Cloud sync uses Supabase Auth and a `planner_data` table protected by Row Level Security. If the planner user is under 18, a parent or guardian should review and manage any third-party account or service required, in accordance with that service's current terms. Never put a Supabase secret/service-role key in this public repository or in the browser app; use only the publishable key with the supplied RLS policies.

## Cloud sync setup
1. A parent/guardian reviews the provider's current terms and manages the Supabase project/account if appropriate.
2. In Supabase SQL Editor, run `supabase-setup.sql`.
3. Copy the Project URL and publishable key from the Supabase project settings.
4. Open the planner → Settings & Backup → Private Cloud Sync. Enter the URL and publishable key, then save.
5. Sign in under the account managed with the parent/guardian and choose whether to create the first cloud copy from this device or load an existing copy.
6. Repeat on the second device with the same project URL, publishable key and authorized account. Choose **Load Cloud Copy** if the cloud already contains the planner you want to keep.

## Sync notes
- Local browser saving continues to work without cloud sync.
- After sign-in and selecting a source copy, changes are uploaded after a short delay and realtime updates can reach the other signed-in device.
- Simultaneous edits can overwrite newer data; avoid editing the same planner on both devices at the same time and keep regular private JSON backups.
- Free-tier limits and inactivity policies can change. Check current terms and limits before relying on cloud sync as the only copy.
