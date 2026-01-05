# Product Requirements Document: Sake Discovery App

**Version:** 1.0  
**Last Updated:** December 30, 2025  
**Document Owner:** Product Team  
**Status:** Final - Ready for Development

---

## Executive Summary

A premium mobile application for iOS that revolutionizes sake discovery through intelligent recommendations, visual bottle recognition, and a curated database of sake ratings and reviews. The app combines sophisticated technology with an elegantly minimal design philosophy to serve both sake enthusiasts and curious newcomers.

---

## Product Vision

To become the definitive mobile companion for sake enthusiasts worldwide by providing instant access to comprehensive sake information, personalized recommendations, and seamless bottle recognition—all wrapped in an interface that exemplifies simplicity and sophistication.

---

## Target Audience

### Primary Markets
- **English-Speaking Markets**: United States, United Kingdom, Australia, Canada
- **Japanese Market**: Japan (domestic sake enthusiasts and professionals)
- **Bilingual Users**: Japanese expatriates, international travelers, sake importers/distributors

### Primary Users
- **Sake Enthusiasts** (Ages 25-45): Regular consumers seeking to deepen their knowledge and discover new varieties
- **Restaurant Diners** (Ages 28-55): Individuals wanting to make informed sake selections when dining out
- **Collectors & Connoisseurs** (Ages 35-65): Serious sake aficionados building personal collections

### Secondary Users
- **Hospitality Professionals**: Sommeliers and restaurant staff seeking quick reference information
- **Travelers**: International visitors to Japan or sake-producing regions
- **Gift Buyers**: People purchasing sake as gifts who need guidance

---

## Core Features

### 1. Sake Database & Discovery

#### 1.1 Comprehensive Sake Catalog
- **Database Size**: Minimum 5,000+ sake entries at launch, growing to 15,000+ within year one
- **Bilingual Content**: All sake information available in both English and Japanese
- **Information Per Entry**:
  - Name (Japanese kanji/kana and English/romanized)
  - Brewery/Producer (both Japanese and English names)
  - Region of origin (Japanese prefecture names with English translations)
  - Sake classification (Junmai, Ginjo, Daiginjo, etc.)
  - Rice variety (Yamada Nishiki, Gohyakumangoku, etc.)
  - Polish ratio (seimaibuai)
  - Alcohol content
  - Flavor profile (dry/sweet scale, umami, acidity, body)
  - Serving temperature recommendations
  - Average price range
  - Availability information

#### 1.2 Rating System
- **Aggregate Rating**: 0-5 star system with half-star increments
- **Rating Dimensions**:
  - Overall quality
  - Value for money
  - Aroma
  - Taste
  - Finish
- **Expert vs. Community Ratings**: Display both professional sommelier ratings and community averages
- **Rating Count**: Display total number of ratings for transparency

#### 1.3 Search Functionality
- **Bilingual Text Search**:
  - Search by sake name (Japanese kanji, hiragana, katakana, or English romanization)
  - Intelligent language detection and transliteration
  - Search by brewery (supports both Japanese and English names)
  - Search by region (e.g., "Niigata" or "新潟")
  - Search by rice variety (e.g., "Yamada Nishiki" or "山田錦")
- **Advanced Filters**:
  - Sake type/classification
  - Price range (< $30, $30-60, $60-100, $100+)
  - Alcohol content range
  - Polish ratio
  - Flavor profile (dry to sweet slider)
  - Availability (in stock, rare, seasonal)
  - User rating threshold
- **Sort Options**:
  - Highest rated
  - Most reviewed
  - Price: Low to High
  - Price: High to Low
  - Alphabetical
  - Newest additions
  - Trending (based on recent search/view activity)

#### 1.4 Smart Recommendations

**Personalization Engine**
- **Onboarding Quiz**: 8-10 question interactive quiz to establish initial taste profile (fully localized)
  - Language selection (first question, defaults to device language)
  - Preferred sweetness level
  - Aromatic intensity preference
  - Food pairing contexts (culturally adapted: sushi/kaiseki for Japanese, various cuisines for English)
  - Price sensitivity (shown in appropriate currency: ¥ or $)
  - Adventure level (traditional vs. experimental)
  - Regional preference awareness

**Recommendation Types**:
- **Daily Discovery**: One carefully curated sake recommendation per day
- **Similar to This**: Recommendations based on currently viewed sake
- **Based on Your Ratings**: Collaborative filtering based on user's rating history
- **Food Pairing Recommendations**: Sake suggestions based on cuisine/dish selection
- **Trending in Your Profile**: Popular choices among users with similar preferences
- **Seasonal Suggestions**: Recommendations aligned with current season

**Food Pairing System**:
- **Cuisine Categories**:
  - Japanese (Sushi, Sashimi, Tempura, Yakitori, Ramen, etc.)
  - Asian (Chinese, Korean, Thai, Vietnamese)
  - Western (Italian, French, American)
  - Fusion
- **Specific Dish Pairing**: Search by specific dishes (e.g., "uni", "wagyu", "foie gras")
- **Flavor Matching Algorithm**: Match sake characteristics to food flavor profiles
- **Chef/Sommelier Curated Pairings**: Professional pairing recommendations

---

### 2. Visual Bottle Recognition

#### 2.1 Photo Capture & Recognition
- **Camera Interface**:
  - Full-screen camera view with minimal UI overlay
  - Grid lines for alignment assistance
  - Focus indicator
  - Flash toggle
  - Front/rear camera switch
  - UI labels in user's selected language
- **Recognition Technology**:
  - Computer vision ML model trained specifically on Japanese sake bottle labels
  - Handles both traditional vertical Japanese text and horizontal layouts
  - Recognizes kanji, hiragana, and katakana on labels
  - Target: 90%+ recognition accuracy on database sake
  - Recognition time: < 3 seconds
  - Works in varied lighting conditions
  - Handles partial label visibility (minimum 60% of label visible)
  - Optimized for both clear bottles and ceramic bottles (tokkuri)

#### 2.2 Photo Upload from Gallery
- Allow users to upload existing photos of sake bottles
- Same recognition pipeline as camera capture

#### 2.3 Recognition Results Display
**Immediate Feedback**:
- Visual confirmation animation (green border pulse around recognized label)
- Match confidence score (displayed subtly)
- Option to verify or suggest corrections if confidence < 80%

**Information Panel** (slides up from bottom):
- Sake name and brewery
- Hero image of bottle (professional product photography)
- Star rating with review count
- Quick stats card:
  - Classification
  - Region
  - Price range
  - Flavor profile indicators
- **Quick Actions**:
  - Add to wishlist
  - Rate this sake
  - View full details
  - Find where to buy
  - Share

#### 2.4 Recognition Failure Handling
- Graceful fallback: "We couldn't recognize this bottle"
- Options presented:
  - Manual search suggestion
  - "Request Addition" - user can submit photo and details for database inclusion
  - Browse similar sake by visible characteristics
- Learning loop: Failed recognition images flagged for model retraining

---

### 3. Review & Rating System

#### 3.1 User Reviews
- **Review Components**:
  - Star rating (required, 1-5 stars)
  - Written review (optional, 50-1000 characters, in user's preferred language)
  - Language indicator badge (EN/JP) for each review
  - Optional translation toggle for reviews in other language
  - Tasting location (restaurant, home, brewery)
  - Serving temperature (chilled, room temperature, warmed)
  - Food pairing notes
  - Photos (up to 3 images)
  - Date tasted

#### 3.2 Review Display
- Display reviews in user's selected language first, then other language
- "Translate" button for reviews in alternate language (machine translation with disclaimer)
- Sort by: Most helpful, Newest, Highest rating, Lowest rating, Language
- Filter by: User type (verified purchase, enthusiast, professional), Language (English/Japanese/All)
- Display helpful vote count
- Flag inappropriate content option (available in both languages)
- Professional reviews highlighted with badge (sommeliers, 利き酒師)

#### 3.3 Personal Tasting Journal
- Private section where users can log tasting notes
- Sortable and filterable by date, rating, location
- Export functionality (PDF, CSV)
- Statistics dashboard (total sake tasted, favorite classifications, spending trends)

---

### 4. User Profile & Personalization

#### 4.1 Profile Information
- Display name and avatar
- Language preference setting (English/Japanese with auto-detect)
- Taste profile summary
- Total sake rated/reviewed
- Member since date
- Badges/achievements (localized names, e.g., "Regional Explorer" / "地域探検家", "Ginjo Connoisseur" / "吟醸通")

#### 4.2 Collections & Lists
- **Wishlist**: Sake to try in the future
- **Favorites**: Highest-rated personal selections
- **My Cellar**: Current collection tracking
- **Custom Lists**: User-created lists with custom names (e.g., "Gift Ideas", "Summer Sake")

#### 4.3 Taste Profile
- Visual representation of preferences (radar chart showing sweetness, acidity, body, etc.)
- Favorite classifications breakdown
- Most explored regions
- Editable preferences

---

## Design Principles

### Apple-Inspired Design Philosophy

#### Visual Design
- **Minimalism**: Maximum information with minimum visual elements
- **White Space**: Generous padding and margins for breathing room
- **Typography**: 
  - English: San Francisco as primary typeface
  - Japanese: System default (Hiragino Sans or SF Pro JP) for optimal readability
  - Clear hierarchy with three weight levels maximum
  - Large, readable text (minimum 16pt for body)
  - Proper line height for both Latin and Japanese characters (1.5-1.7x)
  - Support for mixed English-Japanese text in single lines
- **Color Palette**:
  - Primary: Clean whites and deep blacks
  - Accent: Subtle warm gray (#F5F5F0) for cards and backgrounds
  - Highlight: Refined sake blue (#2E5077) for interactive elements
  - Supporting: Earthy tones for flavor profile indicators (sake rice beige, koji gold, cedar brown)

#### Motion & Animation
- **Subtle Transitions**: 0.3-0.4 second easing for all UI transitions
- **Purposeful Motion**: Animations guide attention, not decorate
- **Physics-Based**: Spring animations with natural momentum
- **Feedback**: Haptic feedback for key interactions (photo capture, favoriting, rating)

#### Layout & Structure
- **Edge-to-Edge Content**: Full-bleed images where appropriate
- **Card-Based UI**: Rounded corner cards (12px radius) with subtle shadows
- **Bottom-Oriented Navigation**: Key actions within thumb reach
- **Floating Action Button**: Camera/scan floating button on browse screens
- **Pull-to-Refresh**: Natural gesture for updating content

#### User Interface Components

**Navigation**:
- Tab bar with 4-5 primary sections (Discover, Camera, Collection, Profile)
- Large titles that condense on scroll
- Modal presentations for detail views (swipe down to dismiss)

**Sake Cards**:
- Hero image (3:4 aspect ratio)
- Sake name in bold
- Brewery in lighter weight below
- Star rating with small review count
- Quick classification badge
- Price indicator ($ - $$$$)

**Detail Views**:
- Large hero image at top (parallax scroll effect)
- Content organized in clear sections with dividers
- Collapsible sections for detailed information
- Persistent action bar at bottom

**Camera Interface**:
- Full-screen with minimal chrome
- Shutter button: Large, centered bottom, white ring
- Recognition feedback: Animated overlay with haptic
- Results: Sheet slides up smoothly from bottom

---

## Technical Requirements

### Platform
- **iOS**: Minimum iOS 16.0, optimized for iOS 17+
- **Devices**: iPhone 12 and newer (iPhone SE 3rd gen+)
- **Orientation**: Portrait only for initial release
- **Languages**: English and Japanese (full localization at launch)

### Performance
- **Launch Time**: < 2 seconds cold start
- **Search Response**: < 500ms for text search
- **Image Recognition**: < 3 seconds from capture to result
- **Smooth Scrolling**: 60 FPS maintained on all scrollable content
- **Image Loading**: Progressive loading with blur-up effect

### Data & Storage
- **Local Caching**: Cache frequently accessed data and images
- **Offline Mode**: 
  - Access previously viewed sake
  - Browse personal collection
  - View cached content
  - Queue ratings/reviews for sync when online
- **Data Sync**: Background sync when app launches and user takes action
- **Storage**: Estimate 100-200MB app size, additional cached data up to 500MB

### API & Backend
- RESTful API with JSON responses
- Authentication: OAuth 2.0
- Image upload: Max 10MB per image
- CDN for image delivery
- Real-time sync for ratings/reviews
- Push notifications capability for personalized recommendations

### Machine Learning
- **On-Device ML**: Core ML model for image recognition
- **Model Size**: < 50MB
- **Model Updates**: Over-the-air updates quarterly
- **Privacy**: All image processing happens on-device before cloud comparison

### Accessibility
- VoiceOver support throughout (English and Japanese)
- Dynamic Type support (all text scales)
- High contrast mode support
- Minimum touch targets: 44x44pt
- Screen reader optimized labels
- Keyboard navigation support

### Internationalization & Localization
- **Launch Languages**: English and Japanese (full feature parity)
- **Language Detection**: Automatic based on device settings with manual override in app
- **Right-to-Left Support**: Not required for initial launch (English and Japanese are LTR)
- **Localization Requirements**:
  - All UI text and labels in both languages
  - Date and number formatting per locale (e.g., Japanese era dates supported)
  - Currency display: USD ($) for English, JPY (¥) for Japanese
  - Region-specific content where applicable
  - Cultural adaptation of terminology (e.g., "sommelier" vs "利き酒師")
- **Content Localization**:
  - Sake names: Display original Japanese with romanization/translation
  - Reviews: Display in original language with translation option
  - Food pairings: Culturally appropriate dish names and categories
  - Educational content: Fully translated and culturally adapted
- **Technical Implementation**:
  - iOS Localizable.strings for all UI text
  - Server-side content localization via API
  - Image assets with text: Separate versions per language where needed
  - App Store presence: Separate listings optimized for each market
- **Translation Quality**:
  - Professional translation services (no machine translation for UI)
  - Native speaker review for cultural appropriateness
  - Sake-specific terminology validated by experts
  - Consistent glossary across all content

### Privacy & Security
- No data collection without explicit consent
- Photos: Only temporary processing, not stored without permission
- User ratings/reviews: Opt-in to public display
- Location: Optional, only for restaurant recommendations
- Data encryption: At rest and in transit
- GDPR and CCPA compliant
- Clear privacy policy and terms of service

---

## User Flows

### Primary User Flow: Discover Sake by Photo

1. User opens app
2. Taps camera icon (tab bar or floating action button)
3. Camera interface opens
4. User points camera at sake bottle
5. App auto-detects and highlights bottle
6. User taps capture or recognition happens automatically
7. Recognition animation plays (1 second)
8. Results sheet slides up with sake information
9. User can:
   - View full details
   - Add rating/review
   - Save to wishlist
   - Share with friends
   - Find where to buy

### Secondary User Flow: Browse and Discover

1. User opens app to Discover tab
2. Sees personalized daily recommendation
3. Scrolls to browse curated lists (Trending, Highly Rated, etc.)
4. Uses search bar or filter button
5. Selects sake from results
6. Views detailed information
7. Reads reviews
8. Adds to wishlist or rates if previously tried

### Tertiary User Flow: Food Pairing

1. User navigating to Discovery tab
2. Taps "Pair with Food" button
3. Selects cuisine type or searches specific dish
4. Views recommended sake with pairing notes
5. Taps sake for full details
6. Saves recommendation or completes rating

---

## Success Metrics

### User Engagement
- Daily Active Users (DAU) / Monthly Active Users (MAU) ratio: Target 30%
- Average session length: Target 5+ minutes
- Sessions per week per user: Target 3+
- Photo recognition uses per user per month: Target 4+

### Content Interaction
- Rating/review submission rate: Target 15% of users
- Wishlist additions per user: Target 10+ items
- Search queries per session: Target 2+
- Food pairing feature usage: Target 40% of active users monthly

### Retention
- Day 1 retention: Target 60%
- Day 7 retention: Target 40%
- Day 30 retention: Target 25%

### Satisfaction
- App Store rating: Target 4.5+ stars
- Recognition accuracy satisfaction: Target 85%+ positive feedback
- Net Promoter Score: Target 40+

### Business Metrics
- Time from download to first recognition: Target < 5 minutes
- Conversion to premium features (if implemented): Target 5-8%
- User-generated content submissions: Target 20% of users contribute

---

## Future Enhancements (Post-Launch)

### Phase 2 (3-6 months post-launch)
- Social features: Follow friends, share tasting notes
- Brewery profiles and stories
- Augmented reality bottle visualization
- Apple Watch companion app
- Widget for iOS home screen (daily recommendation)

### Phase 3 (6-12 months post-launch)
- iPad optimization
- Sake events and tastings calendar
- Direct purchase integration (where legally permitted)
- Virtual sommelier chat assistant
- Sake education modules and certifications

### Phase 4 (12+ months)
- International expansion (additional languages)
- Android version
- Premium subscription tier with exclusive content
- Brewery partnerships and exclusive access
- Community features and forums

---

## Competitive Analysis

### Key Competitors
- **Wine discovery apps**: Strong photo recognition and community reviews
- **Delectable** (wine): Clean UI, professional focus
- **Sake-specific apps**: Limited features, outdated design

### Competitive Advantages
- **Best-in-class bottle recognition** specifically trained for sake
- **Superior design language** inspired by Apple's design principles
- **Deep food pairing intelligence** beyond simple suggestions
- **Comprehensive sake-specific data** (polish ratios, rice varieties, etc.)
- **Personalized recommendation engine** that learns user preferences

### Differentiation Strategy
- Position as premium, design-forward alternative
- Focus on education alongside discovery
- Build trust through accuracy and curation
- Create seamless, delightful user experience that becomes essential tool

---

## Monetization Strategy (Future Consideration)

### Free Tier
- Full access to database
- Basic search and filters
- Photo recognition (with daily limit)
- Basic recommendations
- Standard reviews

### Premium Subscription ($4.99/month or $39.99/year)
- Unlimited photo recognition
- Advanced filters and search
- Personalized sommelier recommendations
- Ad-free experience
- Offline access to full database
- Export tasting journal
- Early access to new features
- Exclusive educational content

### Alternative Revenue Streams
- Affiliate links for sake purchases
- Sponsored sake recommendations (clearly labeled)
- Premium brewery partnerships
- Event ticketing commission

---

## Content Strategy

### Bilingual Content Approach

#### Database Content Priority
1. **Essential Information** (must be bilingual at launch):
   - Sake names (original Japanese + romanization/English name if exists)
   - Brewery names (Japanese + English)
   - Regions (Japanese prefecture + English translation)
   - Classifications (Japanese terms + English explanations)
   - Tasting notes (professionally translated)

2. **User-Generated Content**:
   - Reviews remain in original language submitted
   - Translation toggle available for cross-language reading
   - Users can set language preference for content submission

3. **Editorial Content**:
   - Educational articles fully translated by professionals
   - Seasonal recommendations adapted for each market
   - Food pairing suggestions culturally relevant to each market

#### Regional Content Differences

**Japanese Market Focus**:
- Emphasis on regional Japanese sake (by prefecture)
- Local brewery stories and heritage
- Traditional serving styles and vessels
- Seasonal sake calendar (hiyaoroshi, shiboritate, etc.)
- Integration with Japanese food culture

**English Market Focus**:
- Introduction to sake fundamentals
- International availability information
- Western food pairing guidance
- Price comparisons in USD
- Import brands and distributors
- Sake education for newcomers

#### Content Quality Standards
- All translations reviewed by native speakers with sake knowledge
- Technical terminology consistency maintained across languages
- Cultural sensitivity review for both markets
- Regular content audits to ensure translation accuracy
- Community reporting system for translation errors

---

## Risk Assessment & Mitigation

### Technical Risks
**Risk**: Image recognition accuracy below user expectations  
**Mitigation**: Extensive training dataset, continuous model improvement, clear confidence indicators

**Risk**: Performance issues with large database  
**Mitigation**: Efficient data indexing, aggressive caching, lazy loading, CDN for images

**Risk**: Japanese character encoding issues or display problems  
**Mitigation**: Comprehensive Unicode testing, device testing across iOS versions, QA by native speakers

### Business Risks
**Risk**: Insufficient sake database at launch  
**Mitigation**: Partner with sake importers and distributors for data, community contribution system

**Risk**: Low user engagement  
**Mitigation**: Strong onboarding, push notifications for personalized recommendations, gamification elements

**Risk**: Translation quality concerns or cultural misunderstandings  
**Mitigation**: Professional translation services, native speaker review, cultural consultants, community feedback system

**Risk**: Uneven adoption between English and Japanese markets  
**Mitigation**: Tailored marketing strategies per region, localized influencer partnerships, region-specific features if needed

### Legal/Compliance Risks
**Risk**: Age verification for alcohol-related app  
**Mitigation**: Age gate on first launch, clear 21+/legal drinking age messaging, App Store compliance

**Risk**: User-generated content moderation  
**Mitigation**: Automated content filtering, user reporting system, moderation team, clear community guidelines

---

## Launch Strategy

### Pre-Launch (2-3 months before)
- Beta testing with sake enthusiasts community in both English and Japanese markets (TestFlight)
- Partnership outreach to sake breweries and importers in Japan and internationally
- Content creation for database (target 5,000+ entries with full bilingual content)
- Press outreach to food and tech publications in US, UK, and Japan
- Translation and localization QA by native speakers

### Launch
- **Simultaneous Launch**: Release in English and Japanese App Stores on same day
- **Primary Markets**: United States, Japan, United Kingdom, Australia, Canada
- App Store optimization (ASO) for both languages
  - English keywords: sake, japanese rice wine, sake ratings, sake recommendations
  - Japanese keywords: 日本酒, sake, 日本酒アプリ, おすすめ日本酒, 日本酒評価
- Influencer partnerships:
  - English markets: Sake sommeliers, food bloggers, Asian cuisine specialists
  - Japanese market: Sake brewers, izakaya owners, culinary influencers (利き酒師)
- PR campaign highlighting unique features in both markets
- Localized social media campaigns (English and Japanese accounts)
- Regional targeting in Apple Search Ads

### Post-Launch (First 90 Days)
- Monitor analytics and user feedback closely
- Rapid iteration on pain points
- Community building activities
- Content expansion (target 10,000+ entries)
- Feature refinement based on usage patterns

---

## Development Milestones

### Phase 1: Foundation (Months 1-2)
- Core database architecture (bilingual schema design)
- Basic UI framework and design system
- Internationalization setup (i18n framework, string externalization)
- User authentication system
- Search and browse functionality (multilingual search engine)
- Initial content translation (500+ sake entries in both languages)

### Phase 2: Intelligence (Months 3-4)
- Image recognition model development and training (Japanese label recognition)
- Recommendation engine implementation
- Food pairing system (localized food categories)
- Rating and review system (multilingual support)
- Content expansion (3,000+ sake entries completed)
- UI translation completion (all strings in English and Japanese)

### Phase 3: Polish (Month 5)
- UI/UX refinement for both languages
- Performance optimization
- Animations and transitions
- Accessibility improvements (VoiceOver in both languages)
- Cultural adaptation review (native speaker feedback)
- Final content translation (5,000+ entries target)

### Phase 4: Testing & Launch (Month 6)
- Beta testing (English and Japanese user groups)
- Localization QA and bug fixes
- Stability testing across locales
- App Store submission (both English and Japanese stores)
- Marketing preparation (localized materials)
- Simultaneous launch in target markets

---

## Appendices

### A. Sake Classification Primer
Brief overview of sake types (Junmai, Ginjo, Daiginjo, Honjozo, etc.) for development team context

### B. Technical Stack Recommendations
- iOS: SwiftUI for UI, Core ML for image recognition
- Backend: Node.js or Python (FastAPI)
- Database: PostgreSQL with full-text search
- Image Storage: AWS S3 or Cloudflare R2
- CDN: Cloudflare or CloudFront
- Analytics: Mixpanel or Amplitude
- Crash Reporting: Sentry or Firebase Crashlytics

### C. Design Asset Requirements
- App icon (1024x1024px)
- Launch screen
- Tab bar icons (active and inactive states)
- Empty states illustrations
- Onboarding screens (3-4 screens)
- App Store screenshots (all device sizes)

### D. Localization Requirements

**Launch Languages**: English and Japanese (full feature parity)

**Post-Launch Expansion (Phase 2)**: Simplified Chinese, Korean, French

**Localization Scope for Launch**:

1. **User Interface**
   - All buttons, labels, menus, error messages
   - Onboarding flow (fully localized)
   - Settings and preferences screens
   - Empty states and placeholder text
   - Push notification templates

2. **Content**
   - Sake database entries (bilingual from day 1)
   - Category names and classifications
   - Food pairing descriptions
   - Educational content and tips
   - FAQ and help documentation

3. **Marketing Materials**
   - App Store listings (title, subtitle, description, keywords)
   - Screenshots (text overlays localized)
   - App preview videos (separate versions or subtitles)
   - In-app promotional content

4. **Special Considerations**
   - **Japanese Text Layout**: Proper spacing for kanji/kana mixed with romaji
   - **Name Display**: Japanese preference for family name first (configurable)
   - **Formal vs. Casual**: Appropriate politeness level (丁寧語) for Japanese UI
   - **Units**: Metric for Japanese market, imperial/metric toggle for English
   - **Sake Terminology**: 
     - Keep Japanese terms with explanations (e.g., "Junmai 純米")
     - Glossary available in app for English speakers
     - Avoid over-translation of technical sake terms
   - **Cultural Adaptation**:
     - Color meanings (e.g., red = celebration in both cultures)
     - Icon selection (culturally neutral or adapted)
     - Example sake and food pairings relevant to each market

5. **Translation Workflow**
   - Professional translation agency with food/beverage expertise
   - Localization testing by native speakers in target markets
   - Continuous localization process for new content
   - Community contribution option for user-generated translations (with review)

6. **Technical Implementation**
   - Xcode .strings files for UI text
   - Locale-aware date, time, number formatting
   - Proper Unicode support for all Japanese characters
   - Testing on devices set to each locale
   - String length accommodation (Japanese can be 30-50% shorter than English)

---

## Document Approval

**Product Manager**: _______________  Date: _______

**Engineering Lead**: _______________  Date: _______

**Design Lead**: _______________  Date: _______

**Business Owner**: _______________  Date: _______

---

*End of Document*