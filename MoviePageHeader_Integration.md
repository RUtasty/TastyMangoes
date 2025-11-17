# MoviePageHeader Component - Integration Guide

## Overview

The `MoviePageHeader` component is a reusable SwiftUI component that matches the Figma design for the Movie Page Header. It includes:

- Trailer/backdrop section with "Play Trailer" button
- Movie poster that overlaps the trailer section
- Tasty Score and AI Score displays with icons
- Exact spacing, colors, and typography from Figma design tokens

## Component File

**Location:** `/Users/timrobinson/Developer/TastyMangoes/MoviePageHeader.swift`

## Design Specifications

### Dimensions
- Trailer/Backdrop Height: `193px`
- Poster Size: `84px × 124px`
- Poster Overlap: `58px` (negative offset)
- Corner Radius: `8px` (M token)

### Spacing
- Horizontal Padding: `16px` (trailer section)
- Poster Horizontal Padding: `28px`
- Score Section Bottom Padding: `8px`
- Divider Padding: `12px` horizontal

### Typography
- **Play Trailer Button:**
  - Icon: System 12pt
  - Text: Nunito Bold 12pt
  - Duration: Inter Regular 12pt

- **Tasty Score:**
  - Label: Inter Regular 12pt
  - Value: Nunito Bold 20pt

- **AI Score:**
  - Label: Inter Regular 12pt
  - Value: Nunito Bold 20pt

### Colors (from Design Tokens)
- Background: `#fdfdfd` (Neutral/50)
- Trailer Background: `#1a1a1a` (Neutral/900)
- Poster Placeholder: `#333333` (Neutral/800)
- Text Primary: `#1a1a1a` (Neutral/900)
- Text Secondary: `#666666` (Neutral/600)
- Divider: `#ececec` (Neutral/200)
- Button Text: `#f3f3f3` (Neutral/100)
- Duration Text: `#ececec` (Neutral/200)

## Dependencies

The component requires:

1. **CustomIcons.swift** - Contains:
   - `MangoLogoIcon` - For Tasty Score display
   - `AIFilledIcon` - For AI Score display

2. **Color+Hex.swift** - For hex color initialization

3. **Fonts** - Must be registered in the app:
   - Nunito (Bold, SemiBold)
   - Inter (Regular, SemiBold)

## Usage

### Basic Usage

```swift
MoviePageHeader(
    backdropURL: movie.backdropURL,
    posterURL: movie.posterURL,
    trailerDuration: "4:20",
    tastyScore: 92.5,
    aiScore: 88.0,
    onPlayTrailer: {
        // Handle trailer play action
    }
)
```

### With MovieDetail Model

```swift
MoviePageHeader(
    backdropURL: movie.backdropURL,
    posterURL: movie.posterURL,
    trailerDuration: formatTrailerDuration(movie.trailerDuration),
    tastyScore: movie.tastyScore,
    aiScore: movie.aiScore,
    onPlayTrailer: {
        if let trailerURL = movie.trailerURL {
            // Open trailer URL or play video
        }
    }
)
```

### Optional Parameters

All parameters are optional:
- `backdropURL`: URL for the backdrop/trailer image
- `posterURL`: URL for the movie poster
- `trailerDuration`: Formatted duration string (e.g., "4:20")
- `tastyScore`: Double value for Tasty Score (displayed as percentage)
- `aiScore`: Double value for AI Score (displayed with 1 decimal)
- `onPlayTrailer`: Closure called when "Play Trailer" button is tapped

## Integration in MoviePageView

The component has been integrated into `MoviePageView.swift`. The `headerSection` function now uses `MoviePageHeader`:

```swift
private func headerSection(_ movie: MovieDetail) -> some View {
    VStack(spacing: 0) {
        MoviePageHeader(
            backdropURL: movie.backdropURL,
            posterURL: movie.posterURL,
            trailerDuration: formatTrailerDuration(movie.trailerDuration),
            tastyScore: movie.tastyScore,
            aiScore: movie.aiScore,
            onPlayTrailer: {
                // Handle trailer play action
            }
        )
        
        // Additional content (Mango's Tips, etc.)
        // ...
    }
}
```

## Assets Required

No additional image assets are required. The component uses:
- AsyncImage for backdrop and poster (loaded from URLs)
- Custom icon components from `CustomIcons.swift`
- System SF Symbols for info icons

## Responsive Design

The component is designed for iPhone 14/15/17 widths (375px base width) and uses:
- Fixed dimensions for poster (84×124)
- Fixed trailer height (193px)
- Responsive horizontal padding that scales with screen width

## Design Token Compliance

All spacing, colors, and typography values match the Figma design tokens:
- Uses exact hex colors from design system
- Matches font sizes and weights from design tokens
- Follows corner radius tokens (M = 8px)
- Respects padding and spacing values

## Testing

The component includes two preview variants:
1. **Full Header** - With all elements (backdrop, poster, scores)
2. **Minimal Header** - Without scores or trailer duration

To test:
1. Open `MoviePageHeader.swift` in Xcode
2. Use the Preview panel to see both variants
3. Test with different data combinations

## Notes

- The poster overlaps the trailer section by 58px (negative offset)
- Scores are conditionally displayed (only if values are provided)
- The divider between scores only appears if both scores are present
- Info buttons on scores are currently placeholders (add action handlers as needed)

