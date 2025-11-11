import SwiftUI

// MARK: - Main View
struct SearchResultsView: View {
    @State private var searchText = "Searching film by name..."
    @State private var selectedPlatforms: Set<String> = ["Netflix", "Prime"]
    @State private var selectedGenres = 3
    
    var body: some View {
        ZStack {
            Color(hex: "FDFDFD")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Movie Results
                    VStack(spacing: 16) {
                        // Filter badges
                        filterBadges
                        
                        // Movie cards
                        VStack(spacing: 8) {
                            ForEach(sampleMovies) { movie in
                                MovieCard(movie: movie)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 16)
                    .padding(.top, 120) // Space for top nav
                    .padding(.bottom, 100) // Space for bottom nav
                }
            }
            
            // Top Navigation
            VStack {
                topNavigation
                Spacer()
            }
            
            // Bottom Navigation
            VStack {
                Spacer()
                bottomNavigation
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    // MARK: - Top Navigation
    private var topNavigation: some View {
        VStack(spacing: 0) {
            // Status bar space
            Rectangle()
                .fill(Color.clear)
                .frame(height: 44)
            
            // Search bar
            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    // Back button
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "333333"))
                            .font(.system(size: 16))
                    }
                    
                    Text(searchText)
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "666666"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Search icon
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "333333"))
                        .font(.system(size: 16))
                    
                    // Microphone icon
                    Image(systemName: "mic.fill")
                        .foregroundColor(Color(hex: "333333"))
                        .font(.system(size: 16))
                }
                .padding(12)
                .background(Color(hex: "F3F3F3"))
                .cornerRadius(8)
                
                // Filter button
                Button(action: {}) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color(hex: "414141"))
                        .font(.system(size: 16))
                }
                .padding(12)
                .background(Color(hex: "F3F3F3"))
                .cornerRadius(8)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color(hex: "F3F3F3"))
                .frame(height: 1),
            alignment: .bottom
        )
    }
    
    // MARK: - Filter Badges
    private var filterBadges: some View {
        HStack(spacing: 4) {
            // Platform filter
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text("Platform:")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "332100"))
                    
                    HStack(spacing: -4) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Text("N")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            )
                        
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Text("P")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "ECECEC"), lineWidth: 1)
                )
            }
            
            // Genres filter
            Button(action: {}) {
                HStack(spacing: 4) {
                    Text("Geners:")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "332100"))
                    
                    Text("3+")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "332100"))
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 8))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "ECECEC"), lineWidth: 1)
                )
            }
            
            Spacer()
        }
        .padding(.horizontal, 4)
    }
    
    // MARK: - Bottom Navigation
    private var bottomNavigation: some View {
        ZStack {
            // Tab Bar Background
            HStack(spacing: 0) {
                TabBarItem(icon: "house", label: "Home", isActive: false)
                TabBarItem(icon: "magnifyingglass", label: "Search", isActive: true)
                
                Spacer()
                    .frame(width: 88)
                
                TabBarItem(icon: "list.bullet", label: "Watchlist", isActive: false)
                TabBarItem(icon: "ellipsis", label: "More", isActive: false)
            }
            .padding(.horizontal, 16)
            .padding(.top, 4)
            .frame(height: 60)
            .background(Color.white)
            .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: -2)
            .overlay(
                Rectangle()
                    .fill(Color(hex: "FFEDCC"))
                    .frame(height: 1),
                alignment: .top
            )
            
            // Floating AI Button
            VStack {
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: "FEA500"),
                                        Color(hex: "F48500")
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 56, height: 56)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "leaf.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -34)
                
                Spacer()
            }
            
            // Home Indicator
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black)
                    .frame(width: 134, height: 5)
                    .padding(.bottom, 8)
            }
        }
        .frame(height: 94)
    }
}

// MARK: - Movie Card
struct MovieCard: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            // Movie poster
            AsyncImage(url: URL(string: movie.posterURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 81, height: 120)
            .cornerRadius(8)
            
            // Content
            VStack(spacing: 12) {
                // Top section - Title and ratings
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(movie.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "1A1A1A"))
                            .lineLimit(1)
                        
                        HStack(spacing: 4) {
                            Text(movie.year)
                            Text("‧")
                            Text(movie.genre)
                            Text("‧")
                            Text(movie.duration)
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "666666"))
                        .lineLimit(1)
                    }
                    
                    Spacer()
                    
                    // Ratings
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack(spacing: 2) {
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "648D00"))
                            Text("\(movie.tastyScore)%")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "1A1A1A"))
                        }
                        
                        HStack(spacing: 2) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "FEA500"))
                            Text(String(format: "%.1f", movie.aiScore))
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "1A1A1A"))
                        }
                    }
                }
                
                // Bottom section - Platforms, friends, and actions
                HStack(spacing: 8) {
                    // Watch on platforms
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Watch on:")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "333333"))
                        
                        HStack(spacing: -6) {
                            ForEach(0..<min(3, movie.platforms.count), id: \.self) { index in
                                PlatformBadge(platform: movie.platforms[index])
                            }
                        }
                    }
                    .frame(width: 76)
                    
                    // Liked by friends
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Liked by:")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "333333"))
                        
                        HStack(spacing: -6) {
                            ForEach(0..<min(3, movie.likedBy.count), id: \.self) { index in
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .frame(width: 76)
                    
                    Spacer()
                    
                    // Action buttons
                    HStack(spacing: 4) {
                        Button(action: {}) {
                            Image(systemName: movie.isWatched ? "popcorn.fill" : "popcorn")
                                .font(.system(size: 16))
                                .foregroundColor(Color(hex: "414141"))
                                .frame(width: 44, height: 44)
                                .background(Color(hex: "F3F3F3"))
                                .cornerRadius(8)
                        }
                        .overlay(
                            movie.isWatched ?
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(hex: "648D00"))
                                .font(.system(size: 14))
                                .background(Circle().fill(Color.white))
                                .offset(x: 15, y: -15)
                            : nil
                        )
                        
                        Button(action: {}) {
                            ZStack {
                                Image(systemName: movie.inWatchlist ? "list.bullet" : "plus")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color(hex: "414141"))
                                    .frame(width: 44, height: 44)
                                    .background(Color(hex: "F3F3F3"))
                                    .cornerRadius(8)
                                
                                if movie.inWatchlist {
                                    Circle()
                                        .fill(Color(hex: "FEA500"))
                                        .frame(width: 14, height: 14)
                                        .overlay(
                                            Text("1")
                                                .font(.system(size: 10, weight: .bold))
                                                .foregroundColor(.white)
                                        )
                                        .offset(x: 15, y: -15)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.trailing, 4)
            .padding(.vertical, 4)
        }
        .padding(4)
        .background(Color(hex: "FDFDFD"))
        .cornerRadius(12)
    }
}

// MARK: - Platform Badge
struct PlatformBadge: View {
    let platform: String
    
    var body: some View {
        Circle()
            .fill(platformColor)
            .frame(width: 24, height: 24)
            .overlay(
                Text(platformInitial)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.white)
            )
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 1)
            )
    }
    
    private var platformInitial: String {
        String(platform.prefix(1))
    }
    
    private var platformColor: Color {
        switch platform {
        case "Netflix": return Color.red
        case "Prime": return Color.blue
        case "Disney+": return Color.blue
        case "HBO": return Color.purple
        default: return Color.gray
        }
    }
}

// MARK: - Tab Bar Item
struct TabBarItem: View {
    let icon: String
    let label: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: isActive ? icon + ".fill" : icon)
                .font(.system(size: 14))
                .foregroundColor(isActive ? Color(hex: "333333") : Color(hex: "999999"))
            
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(isActive ? Color(hex: "333333") : Color(hex: "999999"))
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Models
struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let year: String
    let genre: String
    let duration: String
    let posterURL: String
    let tastyScore: Int
    let aiScore: Double
    let platforms: [String]
    let likedBy: [String]
    let isWatched: Bool
    let inWatchlist: Bool
}

// MARK: - Sample Data
let sampleMovies = [
    Movie(
        title: "Jurassic World: Reborn",
        year: "2025",
        genre: "Action/Si-Fi",
        duration: "2h 13m",
        posterURL: "placeholder",
        tastyScore: 88,
        aiScore: 5.5,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: true,
        inWatchlist: true
    ),
    Movie(
        title: "Juror #2",
        year: "2024",
        genre: "Thriller/Drama",
        duration: "1h 54min",
        posterURL: "placeholder",
        tastyScore: 50,
        aiScore: 3.4,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: false,
        inWatchlist: false
    ),
    Movie(
        title: "Jurassic World: Dominion",
        year: "2022",
        genre: "Action/Si-Fi",
        duration: "1h 50m",
        posterURL: "placeholder",
        tastyScore: 67,
        aiScore: 6.8,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: false,
        inWatchlist: true
    ),
    Movie(
        title: "Jurassic World",
        year: "2015",
        genre: "Action/Si-Fi",
        duration: "2h 20m",
        posterURL: "placeholder",
        tastyScore: 95,
        aiScore: 9.1,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: true,
        inWatchlist: false
    ),
    Movie(
        title: "Jury Duty",
        year: "2023",
        genre: "Comedy/Thriller",
        duration: "1h 40m",
        posterURL: "placeholder",
        tastyScore: 75,
        aiScore: 2.5,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: false,
        inWatchlist: false
    ),
    Movie(
        title: "Jurassic Park III",
        year: "2001",
        genre: "Action/Si-Fi",
        duration: "1h 40m",
        posterURL: "placeholder",
        tastyScore: 33,
        aiScore: 0.8,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: true,
        inWatchlist: false
    ),
    Movie(
        title: "Jurassic World: Fallen Kingdom",
        year: "2024",
        genre: "Action/Si-Fi",
        duration: "1h 40m",
        posterURL: "placeholder",
        tastyScore: 24,
        aiScore: 4.7,
        platforms: ["Netflix", "Prime", "Disney+"],
        likedBy: ["User1", "User2", "User3"],
        isWatched: false,
        inWatchlist: false
    )
]

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview
struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
