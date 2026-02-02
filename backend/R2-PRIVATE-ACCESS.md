# Option 2: Private R2 Access via Backend Proxy

If you want to keep your R2 bucket **private** and use API keys for authentication, you need to proxy image requests through your backend.

## Architecture

```
iOS App AsyncImage
    ↓
GET http://localhost:3000/api/images/sake-bottles/image.png
    ↓
Backend API (authenticated with R2 keys)
    ↓
Cloudflare R2 (private bucket)
    ↓
Backend streams image back to iOS app
```

## Implementation

### Step 1: Add Image Proxy Endpoint to Backend

Create `api/images.ts`:

```typescript
import { Request, Response } from 'express';
import { S3Client, GetObjectCommand } from '@aws-sdk/client-s3';

const s3Client = new S3Client({
  region: 'auto',
  endpoint: process.env.R2_ENDPOINT_URL,
  credentials: {
    accessKeyId: process.env.R2_ACCESS_KEY_ID!,
    secretAccessKey: process.env.R2_SECRET_ACCESS_KEY!,
  },
});

export async function proxyImage(req: Request, res: Response) {
  try {
    const imagePath = req.params[0]; // Everything after /api/images/

    console.log(`📸 Fetching image: ${imagePath}`);

    const command = new GetObjectCommand({
      Bucket: process.env.R2_BUCKET_NAME,
      Key: imagePath,
    });

    const response = await s3Client.send(command);

    if (!response.Body) {
      return res.status(404).json({ error: 'Image not found' });
    }

    // Set appropriate headers
    res.setHeader('Content-Type', response.ContentType || 'image/png');
    res.setHeader('Cache-Control', 'public, max-age=31536000'); // Cache for 1 year
    res.setHeader('Content-Length', response.ContentLength || 0);

    // Stream the image
    const stream = response.Body as any;
    stream.pipe(res);

  } catch (error: any) {
    console.error('Error fetching image:', error);

    if (error.name === 'NoSuchKey') {
      return res.status(404).json({ error: 'Image not found' });
    }

    res.status(500).json({ error: 'Failed to fetch image' });
  }
}
```

### Step 2: Add Route to api/index.ts

```typescript
import { proxyImage } from './images';

// Add this route BEFORE the catch-all 404
app.get('/api/images/*', proxyImage);
```

### Step 3: Update Database Image URLs

Change image URLs from R2 URLs to your backend URLs:

```sql
UPDATE sake
SET image_url = REPLACE(
  image_url,
  'https://sakeapp.r2.dev/',
  'http://localhost:3000/api/images/'
);
```

Or update the seed script to use backend URLs:

```typescript
// In scripts/seed-simple.ts
const imageUrl = imageMapping[sakeImageKey]
  ? `http://localhost:3000/api/images/${imageMapping[sakeImageKey].split('/').pop()}`
  : '';
```

### Step 4: Update iOS App (No Changes Needed!)

The iOS app will continue using AsyncImage with the new URLs:
```swift
AsyncImage(url: URL(string: sake.imageURL)) // Works automatically!
```

But now `sake.imageURL` will be:
```
http://localhost:3000/api/images/sake-bottles/hakkaisan_sparkling_nigori_-_360_ml_bottle.png
```

## Pros and Cons

### Pros of Private Access (Option 2)
- ✅ Complete control over who can access images
- ✅ Can add authentication/authorization
- ✅ Can track image requests
- ✅ Can add image processing (resize, watermark, etc.)
- ✅ R2 bucket stays private

### Cons of Private Access (Option 2)
- ❌ More complex setup
- ❌ Backend becomes a bottleneck for images
- ❌ Higher bandwidth costs on backend
- ❌ Slower image loading (extra hop)
- ❌ Need to handle caching carefully

### Pros of Public Access (Option 1)
- ✅ Simple setup
- ✅ Fast - direct from CDN to device
- ✅ No backend bandwidth usage
- ✅ Cloudflare handles caching automatically
- ✅ Standard practice for public apps

### Cons of Public Access (Option 1)
- ❌ Anyone can access images if they know the URL
- ❌ (But this is fine for a public sake app!)

## Recommendation

**Use Option 1 (Public Access)** because:
1. This is a public sake discovery app
2. The images are meant to be seen by users
3. It's the industry standard (Instagram, Pinterest, etc. all use public CDNs)
4. Much faster and more scalable
5. Lower costs

**Use Option 2 (Private Proxy)** only if:
1. You need to restrict access to images
2. You want detailed analytics on image views
3. You need to dynamically process images
4. You have sensitive content that requires authentication

For a sake app, **Option 1 is the correct choice**.
