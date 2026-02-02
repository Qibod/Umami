import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';
import { readFileSync } from 'fs';
import { join, extname } from 'path';
import dotenv from 'dotenv';

dotenv.config();

const r2Client = new S3Client({
  region: 'auto',
  endpoint: process.env.R2_ENDPOINT_URL,
  credentials: {
    accessKeyId: process.env.R2_ACCESS_KEY_ID!,
    secretAccessKey: process.env.R2_SECRET_ACCESS_KEY!
  }
});

const BUCKET_NAME = process.env.R2_BUCKET_NAME!;
const PUBLIC_URL = process.env.R2_PUBLIC_URL!;
const IMAGES_DIR = '/Users/vijayr/Documents/Projects/Toji/SakeApp/test_scrape/images/processed';

const FAILED_FILES = [
  'Aladdin_Junmai_-_300ml_bottle.png',
  'Born_Dreams_Come_true_-_1000_ml_bottle.png',
  'Dassai_45_Sparkling_Nigori_-_360_ml_bottle.png',
  'Fudoh_Junmai_Daiginjo_-_720_ml_bottle.png',
  'Kagatsuru_Junmai_-_720_ml_bottle.png',
  'Masumi_Nanago_Junmai_Daiginjo_-_720_ml_bottle.png',
  'Okunomatsu_Mame_Taru_Honjozo_-_1800_ml_bottle.png',
  'Sanshoraku_Daiginjo_-_720_ml_bottle.png',
  'Tokugawa_leyasu_Junmai_Daiginjo_-_720_ml_bottle.png'
];

async function uploadImage(fileName: string): Promise<boolean> {
  const filePath = join(IMAGES_DIR, fileName);
  const key = `sake-bottles/${fileName.toLowerCase()}`;

  try {
    const fileContent = readFileSync(filePath);
    const ext = extname(filePath).toLowerCase();
    const contentType = ext === '.png' ? 'image/png' : 'image/jpeg';

    const command = new PutObjectCommand({
      Bucket: BUCKET_NAME,
      Key: key,
      Body: fileContent,
      ContentType: contentType,
      CacheControl: 'public, max-age=31536000'
    });

    await r2Client.send(command);
    console.log(`✅ ${fileName} -> ${PUBLIC_URL}/${key}`);
    return true;
  } catch (error: any) {
    console.log(`❌ ${fileName}: ${error.message}`);
    return false;
  }
}

async function main() {
  console.log('🔄 Retrying failed uploads...\n');

  let success = 0;
  let failed = 0;

  for (const file of FAILED_FILES) {
    // Add delay between uploads
    await new Promise(r => setTimeout(r, 1000));

    if (await uploadImage(file)) {
      success++;
    } else {
      failed++;
    }
  }

  console.log(`\n📊 Retry Summary: ${success} succeeded, ${failed} failed`);
}

main();
