# Cloudflare R2 Image Loading - Troubleshooting

## Problem

Images are returning **500 Internal Server Error** when accessed via:
```
https://sakeapp.r2.dev/sake-bottles/hakkaisan_sparkling_nigori_-_360_ml_bottle.png
```

## Root Cause

The R2 bucket `sakeapp` is **not configured for public access** via the custom domain `sakeapp.r2.dev`.

## Solution: Enable Public Access

### Option 1: Enable Public Access via R2.dev Domain (Recommended for Testing)

1. **Go to Cloudflare Dashboard**:
   - Login to https://dash.cloudflare.com
   - Navigate to **R2** from the left sidebar
   - Click on your bucket: **sakeapp**

2. **Enable Public Access**:
   - Click on **Settings** tab
   - Scroll to **Public access**
   - Click **Allow Access** under "R2.dev subdomain"
   - This will enable: `https://pub-xxxxx.r2.dev`

3. **Get the Public URL**:
   - Copy the public URL (format: `https://pub-xxxxx.r2.dev`)
   - It will look like: `https://pub-4573eff47c2af7be9887db8557cd0802.r2.dev`

4. **Update Your .env File**:
   ```bash
   # Change this:
   R2_PUBLIC_URL=https://sakeapp.r2.dev

   # To this (use the pub- URL from Cloudflare):
   R2_PUBLIC_URL=https://pub-4573eff47c2af7be9887db8557cd0802.r2.dev
   ```

5. **Update Database**:
   ```bash
   cd /Users/vijayr/Documents/Projects/umami-backend
   npm run dev

   # In another terminal:
   curl -X POST http://localhost:3000/api/admin/update-image-urls
   ```

### Option 2: Custom Domain (For Production)

If you want to use `sakeapp.r2.dev`:

1. **Go to R2 Bucket Settings**
2. Click **Connect Domain**
3. Enter your custom domain: `sakeapp.r2.dev`
4. Add the required DNS records to your Cloudflare DNS settings
5. Wait for DNS propagation (can take up to 24 hours)

## Quick Fix for Now

### Step 1: Check if Public Access is Enabled

```bash
curl -I "https://pub-4573eff47c2af7be9887db8557cd0802.r2.dev/sake-bottles/hakkaisan_sparkling_nigori_-_360_ml_bottle.png"
```

Expected response:
```
HTTP/2 200
content-type: image/png
```

If you get a 403 or 500 error, public access is NOT enabled.

### Step 2: Test with Actual Uploaded Images

Check if images were actually uploaded:

```bash
# List what's in the bucket
npx ts-node scripts/list-r2-objects.ts
```

### Step 3: Verify Image URLs in Database

```bash
# Check what URLs are in the database
curl http://localhost:3000/api/sake?limit=1 | jq '.data[0].image_url'
```

## Temporary Workaround: Use Placeholder Images

While fixing R2 access, you can use placeholder images:

1. **Update APIService.swift** to use placeholders:
```swift
// In toSake() function, replace:
imageURL: imageUrl,

// With:
imageURL: imageUrl.isEmpty ? "https://via.placeholder.com/400x600?text=Sake" : imageUrl,
```

This will show placeholder images until R2 is properly configured.

## Expected Result

Once fixed, you should be able to access images like:
```bash
curl -I "https://pub-xxxxx.r2.dev/sake-bottles/hakkaisan_sparkling_nigori_-_360_ml_bottle.png"

# Should return:
HTTP/2 200
content-type: image/png
content-length: 45678
```

## Next Steps

1. Enable public access in Cloudflare R2 dashboard
2. Get the actual public URL (pub-xxxxx.r2.dev)
3. Update R2_PUBLIC_URL in .env
4. Restart backend server
5. Rebuild iOS app
6. Images should load!
