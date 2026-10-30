# OFF

> Nothing needs you for the next 60 seconds.

A tiny digital escape for a full head. One tap takes you somewhere calm, satisfying or a bit silly. Put thoughts down in a box. Close the day.

- **OFF**: a random micro-escape (24 of them: night sky, zen sand, bubble wrap, a potato, a duck, a sleepy dragon, fireflies, a campfire and more, plus eight gentle games: a block tower, a plinko of small pleasures, connect-the-stars, noughts and crosses against a very slow sloth, memory pairs, dot to dot, an arrow maze and gentle falling blocks)
- **Put it down**: drop what's on your mind into **My Box**. No dates, priorities or scores.
- **I'm done**: a closing ritual for the end of the day.

There is no account to create and nothing is tracked. My Box works offline from the browser's local storage, and is also saved to a private table in Supabase under an anonymous session, so each browser can only ever see its own items. Sounds are generated live, so there are no audio files.

OFF is a relaxation and decompression tool. It is not medical care or therapy.

## Deploy to Vercel

This is a static site: a single `index.html` with no build step.

1. In Vercel choose **Add New > Project** and import this repository.
2. Set **Framework Preset** to **Other**.
3. Leave **Build Command** and **Output Directory** empty, and keep the root directory as `./`.
4. Click **Deploy**.

Every push to the default branch redeploys automatically.

## Offline

After the first visit the whole app works with no connection: the page, React, the fonts, every escape and every game are saved by a service worker (`sw.js`). It can also be installed to a phone's home screen (`manifest.webmanifest`).

- The page is fetched fresh whenever you are online, and the saved copy is used when you are not.
- Supabase requests are never cached. Changes made to My Box offline are queued and sent when the connection returns.
- To ship a change that must reach everyone at once, bump `CACHE` in `sw.js`.

## Supabase (My Box storage)

The app talks to Supabase from the browser using the project URL and **publishable** key in the script (`SB_URL` and `SB_KEY`). Those are safe to publish; access is controlled by row-level security, not by hiding the key.

- Schema: `supabase/migrations/20261030000000_off_box_items.sql` creates `public.off_box_items` with policies that let a session read and write only its own rows.
- **Authentication > Sign In / Providers > Allow anonymous sign-ins must be switched on.** Without it the app still works, but My Box stays in local storage only.
- Anonymous users appear in Authentication > Users. Consider enabling CAPTCHA or rate limits for anonymous sign-ins if the site gets public traffic.
- An anonymous identity lives in the browser. Clearing site data starts a new, empty box.

## Run locally

```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

The page loads React 18.3.1 from cdnjs and two fonts from Google Fonts, so it needs an internet connection the first time it loads.
