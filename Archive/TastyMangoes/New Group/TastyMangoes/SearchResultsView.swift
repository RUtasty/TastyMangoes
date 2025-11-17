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
                            // Movie cards - will add later with real data
                            Text("No movies to display")
                                .foregroundColor(.gray)
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

// MARK: - Preview
struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}

