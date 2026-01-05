# Umami - Sake Discovery App

A premium iOS application for sake enthusiasts, built with SwiftUI and following Apple's design principles for discovering and exploring Japanese sake.

## Project Overview

Umami is a sake discovery app that helps users explore, rate, and learn about Japanese sake. The app features bottle recognition, personalized recommendations, brewery information, and food pairing suggestions.

## Features Implemented

### ✅ Authentication & Onboarding

1. **Splash Screen** - Beautiful loading screen with animated logo
   - Gradient background (burgundy to sake blue)
   - App name in English and Japanese (旨味)
   - Smooth animations
   - 2-second loading time

2. **Authentication Page** - Multi-provider sign-in
   - Language selector at top (English/Japanese toggle)
   - Sign in with Email
   - Sign in with Apple
   - Sign in with Google
   - Continue as Guest option
   - Terms and Privacy notice
   - Fully localized in both languages

### ✅ Language Support

- **Bilingual Interface** - Full English and Japanese localization
  - Language toggle button on all main pages
  - Instant language switching without app restart
  - Localized UI strings for all screens
  - Persistent language preference
  - Tab bar labels in selected language
  - Search placeholders and section headers localized

### ✅ Core Pages

1. **Home Page** - Curated sake collections with horizontal scrolling
   - Language toggle button
   - Search bar (localized placeholder)
   - Best offers section with discount badges
   - Bestsellers in Japan
   - Price drops
   - Highly rated sake
   - All text localized

2. **Shop Page** - Browse all sake with advanced filtering
   - Language toggle in header
   - Sort options (highest rated, price, newest, trending)
   - Advanced filters:
     - Sake type (Junmai, Ginjo, Daiginjo, etc.)
     - Rating threshold
     - Price range
     - Prefecture
     - Rice variety
   - List view with sake cards
   - 22,000+ sake database (simulated with dummy data)
   - Localized filter labels

3. **Camera Page** - Bottle recognition (UI placeholder)
   - Full-screen camera interface
   - Viewfinder with alignment guide
   - Gallery picker option
   - Recognition animation
   - Ready for ML integration
   - Localized instructions

4. **My Sake Page** - Personal collection and taste profile
   - Language toggle button
   - Latest scanned sake
   - Taste profile visualization
   - Statistics (sake tried, favorites, wishlist)
   - Collections (Wishlist, Favorites, My Cellar)
   - Rating prompts
   - All labels localized

5. **More Page** - Additional features and settings
   - User profile section
   - Sake Breweries explorer
   - Food & Sake pairing search
   - Settings and support
   - Localized menu items

### ✅ Additional Features

- **Sake Detail View** - Comprehensive sake information page
  - Accessible by tapping any sake card
  - Hero image with gradient background
  - Rating and reviews section
  - Flavor profile visualization with bars
  - Serving temperature recommendations
  - Food pairing suggestions
  - Add to cart and bookmark actions
  - Back navigation to previous screen

- **Navigation** - Seamless user flow
  - Tap any sake card to see full details
  - Works from Home page, Shop page, and My Sake page
  - Smooth push/pop navigation
  - Maintains navigation stack

- **Sake Breweries** - Explore Japanese sake producers
  - Beautiful card layout with hero images
  - Prefecture and region information
  - Brewery descriptions

- **Food Pairing** - Discover sake for your meal
  - Search by dish
  - Recent pairings
  - Alphabetical categorization
  - Recommended sake for each dish

- **App State Management** - Smart app flow
  - Splash screen on first launch
  - Automatic authentication check
  - Persistent login state
  - Smooth transitions between phases

## Design System

### Color Palette
- **Primary**: Deep burgundy/sake red (#8B1538)
- **Secondary**: Sake blue (#2E5077)
- **Accent**: Gold (#D4AF37)
- **Star Rating**: Orange (#FF6B35)
- **Backgrounds**: White, warm gray (#F5F5F0)

### Typography
- San Francisco system font
- Clear hierarchy with 3 weight levels
- Large, readable text (minimum 16pt for body)
- Proper line height (1.5-1.7x)

### Components
- Card-based UI with 12px rounded corners
- Subtle shadows for depth
- Bottom tab navigation with circular camera button
- Smooth 0.3-0.4s transitions
- Pull-to-refresh support

## Project Structure

```
Umami/
├── Models/
│   ├── Sake.swift           # Sake data model
│   ├── Brewery.swift        # Brewery data model
│   ├── Review.swift         # Review and tasting notes
│   ├── FoodPairing.swift    # Food pairing data
│   └── UserProfile.swift    # User profile and preferences
├── Views/
│   ├── SplashView.swift         # Splash/loading screen
│   ├── AuthenticationView.swift # Sign in/sign up page
│   ├── MainTabView.swift        # Main tab navigation
│   ├── HomeView.swift           # Home page
│   ├── ShopView.swift           # Shop with filters
│   ├── CameraView.swift         # Camera interface
│   ├── MySakeView.swift         # Personal collection
│   ├── MoreView.swift           # More menu
│   └── SakeDetailView.swift     # Sake detail page
├── Components/
│   ├── SakeCard.swift       # Reusable sake card components
│   └── LanguageToggle.swift # Language switcher button
├── Utilities/
│   ├── LanguageManager.swift # Localization manager
│   └── AppState.swift        # App state management
├── Theme/
│   └── AppTheme.swift       # Design system (colors, typography, spacing)
├── Data/
│   └── SampleData.swift     # Dummy data for development
└── UmamiApp.swift          # App entry point
```

## Data Models

### Sake
- Name (Japanese and English)
- Brewery information
- Prefecture/Region
- Classification (Junmai, Ginjo, Daiginjo, etc.)
- Rice variety
- Polish ratio (seimaibuai)
- Alcohol content
- Flavor profile (sweetness, acidity, body, umami, aroma)
- Rating and review count
- Price and availability

### Brewery
- Name (Japanese and English)
- Location (prefecture, region)
- Establishment year
- Description
- Number of sake produced
- Total ratings

### Food Pairing
- Dish name (English and Japanese)
- Category (Sushi, Tempura, Ramen, etc.)
- Recommended sake
- Pairing description

## Dummy Data

The app includes sample data for 6 sake bottles, 3 breweries, and 4 food pairings to demonstrate functionality:

**Featured Sake**:
1. Dassai 23 - Ultra-premium junmai daiginjo
2. Kubota Manju - Elegant Niigata sake
3. Kokuryu Jungin - Clean and crisp
4. Dassai 39 - Entry-level premium
5. Hakkaisan Junmai Ginjo - Light Niigata style
6. Juyondai Honmaru - Highly sought-after

## Building and Running

### Requirements
- Xcode 16.0 or later
- iOS 16.0 or later
- macOS Sequoia or later

### Build Instructions
1. Open `Umami.xcodeproj` in Xcode
2. Select iPhone simulator (iPhone 17 or later recommended)
3. Press Cmd+R to build and run

Or via command line:
```bash
xcodebuild -project Umami.xcodeproj -scheme Umami -destination 'platform=iOS Simulator,name=iPhone 17' build
```

## Next Steps - Backend Integration

### To Connect to Backend:

1. **Replace Dummy Data**
   - Update `SampleData.swift` to fetch from API
   - Implement data persistence with SwiftData or Core Data

2. **Image Recognition**
   - Integrate Core ML model in `CameraView.swift`
   - Connect to backend API for bottle recognition
   - Handle recognition results

3. **User Authentication**
   - Add login/signup flow
   - Implement OAuth 2.0
   - Store authentication tokens

4. **API Integration**
   - Create API service layer
   - Implement endpoints:
     - GET /sake (with filters)
     - GET /sake/:id
     - GET /breweries
     - GET /food-pairings
     - POST /reviews
     - POST /recognize (image upload)

5. **Real-time Features**
   - User ratings and reviews sync
   - Wishlist and favorites cloud sync
   - Push notifications

## PRD Reference

Full Product Requirements Document is available at: `Umami_prd.md`

Key features from PRD:
- ✅ Comprehensive sake database
- ✅ Visual bottle recognition (UI ready)
- ✅ Review & rating system (structure ready)
- ✅ User profile & personalization
- ✅ Food pairing system
- ✅ Apple-inspired design
- ✅ Bilingual support (structure ready)

## Design Inspiration

The app features an elegant, minimalist design tailored for sake-specific features and Japanese aesthetic.

## Notes

- All UI is built with SwiftUI
- No external dependencies required
- Ready for internationalization (English/Japanese)
- Optimized for iPhone (portrait mode)
- Follows iOS Human Interface Guidelines
- Accessibility support built-in

---

**Created**: January 5, 2026
**Version**: 1.0.0
**Platform**: iOS 16.0+
**Framework**: SwiftUI
