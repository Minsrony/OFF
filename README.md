# OFF

> Nothing needs you for the next 60 seconds.

A tiny digital escape for a full head. One tap takes you somewhere calm, satisfying or a bit silly. Put thoughts down in a box. Close the day.

- **OFF**: a random micro-escape (16 of them: night sky, zen sand, bubble wrap, a potato, a duck, a sleepy dragon, fireflies, a campfire and more)
- **Put it down**: drop what's on your mind into **My Box**. No dates, priorities or scores.
- **I'm done**: a closing ritual for the end of the day.

Everything runs in the browser. There is no backend, no account and no tracking. What you put in My Box stays in your browser's local storage. Sounds are generated live, so there are no audio files.

OFF is a relaxation and decompression tool. It is not medical care or therapy.

## Deploy to Vercel

This is a static site: a single `index.html` with no build step.

1. In Vercel choose **Add New > Project** and import this repository.
2. Set **Framework Preset** to **Other**.
3. Leave **Build Command** and **Output Directory** empty, and keep the root directory as `./`.
4. Click **Deploy**.

Every push to the default branch redeploys automatically.

## Run locally

```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

The page loads React 18.3.1 from cdnjs and two fonts from Google Fonts, so it needs an internet connection the first time it loads.
