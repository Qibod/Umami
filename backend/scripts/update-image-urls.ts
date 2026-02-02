import { createClient } from '@supabase/supabase-js';
import * as dotenv from 'dotenv';

dotenv.config();

const supabase = createClient(
  process.env.SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

async function updateImageUrls() {
  try {
    console.log('🔄 Updating image URLs in database...');
    console.log(`Old URL: https://sakeapp.r2.dev`);
    console.log(`New URL: ${process.env.R2_PUBLIC_URL}`);

    // Update sake table
    const { data: sakeData, error: sakeError } = await supabase
      .from('sake')
      .select('id, image_url')
      .like('image_url', '%sakeapp.r2.dev%');

    if (sakeError) {
      throw sakeError;
    }

    console.log(`\n📊 Found ${sakeData?.length || 0} sake records to update`);

    if (sakeData && sakeData.length > 0) {
      for (const sake of sakeData) {
        const newUrl = sake.image_url.replace(
          'https://sakeapp.r2.dev',
          process.env.R2_PUBLIC_URL!
        );

        const { error: updateError } = await supabase
          .from('sake')
          .update({ image_url: newUrl })
          .eq('id', sake.id);

        if (updateError) {
          console.error(`❌ Error updating ${sake.id}:`, updateError);
        } else {
          console.log(`✅ Updated: ${sake.id}`);
        }
      }
    }

    // Update breweries table (if they have images)
    const { data: breweryData, error: breweryError } = await supabase
      .from('breweries')
      .select('id, image_url')
      .not('image_url', 'is', null)
      .like('image_url', '%sakeapp.r2.dev%');

    if (!breweryError && breweryData && breweryData.length > 0) {
      console.log(`\n📊 Found ${breweryData.length} brewery records to update`);

      for (const brewery of breweryData) {
        const newUrl = brewery.image_url.replace(
          'https://sakeapp.r2.dev',
          process.env.R2_PUBLIC_URL!
        );

        const { error: updateError } = await supabase
          .from('breweries')
          .update({ image_url: newUrl })
          .eq('id', brewery.id);

        if (updateError) {
          console.error(`❌ Error updating brewery ${brewery.id}:`, updateError);
        } else {
          console.log(`✅ Updated brewery: ${brewery.id}`);
        }
      }
    }

    console.log('\n✨ Image URLs updated successfully!');

    // Verify the update
    const { data: verifyData } = await supabase
      .from('sake')
      .select('image_url')
      .limit(3);

    console.log('\n📸 Sample updated URLs:');
    verifyData?.forEach((sake, i) => {
      console.log(`${i + 1}. ${sake.image_url}`);
    });

  } catch (error) {
    console.error('Error updating image URLs:', error);
    process.exit(1);
  }
}

updateImageUrls();
