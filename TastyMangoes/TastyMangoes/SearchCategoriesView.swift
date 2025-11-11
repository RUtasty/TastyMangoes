import SwiftUI

// MARK: - Main View
struct SearchCategoriesView: View {
    @State private var searchText = ""
    @State private var mySubscriptionsEnabled = false
    @State private var selectedPlatforms: Set<String> = []
    @State private var selectedCategories: Set<String> = []
    
    var body: some View {
        ZStack {
            Color(hex: "FDFDFD")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    // Header with gradient
                    headerSection
                    
                    // Content
                    VStack(spacing: 24) {
                        // My Subscriptions Section
                        subscriptionsSection
                        
                        // Category Sections
                        categorySection(
                            title: "FUN & LIGHT",
                            categories: funLightCategories
                        )
                        
                        categorySection(
                            title: "EPIC & IMAGINATIVE",
                            categories: epicCategories
                        )
                        
                        categorySection(
                            title: "DARK & INTENSE",
                            categories: darkCategories
                        )
                        
                        categorySection(
                            title: "REAL STORIES",
                            categories: realStoriesCategories
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                    .padding(.bottom, 100) // Space for bottom nav
                }
            }
            
            // Bottom Navigation
            VStack {
                Spacer()
                bottomNavigation
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            // Top section with title and avatar
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Find Your Movie 🎬")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(hex: "1A1A1A"))
                    
                    Text("Type a title or pick a genre\nto discover the film you're looking for.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(Color(hex: "333333"))
                        .lineSpacing(2)
                }
                
                Spacer()
                
                // Avatar
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                    )
            }
            .padding(.horizontal, 16)
            
            // Search Bar
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                
                TextField("Searching by name...", text: $searchText)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "666666"))
                
                Image(systemName: "mic.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
            }
            .padding(12)
            .background(Color(hex: "FFDB99"))
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
        .padding(.top, 68)
        .padding(.bottom, 20)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "F7C200").opacity(0.8),
                    Color(hex: "FEA500").opacity(0.8),
                    Color(hex: "F48500").opacity(0.8)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .shadow(color: .black.opacity(0.04), radius: 12, x: 0, y: 2)
    }
    
    // MARK: - Subscriptions Section
    private var subscriptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Checkbox
            HStack(spacing: 8) {
                Button(action: {
                    mySubscriptionsEnabled.toggle()
                }) {
                    Image(systemName: mySubscriptionsEnabled ? "checkmark.square.fill" : "square")
                        .foregroundColor(mySubscriptionsEnabled ? Color(hex: "FEA500") : Color(hex: "B3B3B3"))
                        .font(.system(size: 20))
                }
                
                Text("My subscriptions")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(hex: "333333"))
            }
            
            // Platform logos
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    ForEach(streamingPlatforms, id: \.name) { platform in
                        PlatformButton(
                            platform: platform,
                            isSelected: selectedPlatforms.contains(platform.name)
                        ) {
                            if selectedPlatforms.contains(platform.name) {
                                selectedPlatforms.remove(platform.name)
                            } else {
                                selectedPlatforms.insert(platform.name)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Category Section
    private func categorySection(title: String, categories: [MovieCategory]) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(hex: "999999"))
                .tracking(0.5)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 4),
                    GridItem(.flexible(), spacing: 4)
                ],
                spacing: 4
            ) {
                ForEach(categories) { category in
                    CategoryCard(
                        category: category,
                        isSelected: selectedCategories.contains(category.name)
                    ) {
                        if selectedCategories.contains(category.name) {
                            selectedCategories.remove(category.name)
                        } else {
                            selectedCategories.insert(category.name)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Bottom Navigation
    private var bottomNavigation: some View {
        ZStack {
            // Tab Bar Background
            HStack(spacing: 0) {
                TabBarItem(icon: "house", label: "Home", isActive: false)
                TabBarItem(icon: "magnifyingglass", label: "Search", isActive: true)
                
                Spacer()
                    .frame(width: 88) // Space for floating button
                
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
        .frame(height: 94) // 60 tab bar + 34 home indicator
    }
}

// MARK: - Supporting Views

struct PlatformButton: View {
    let platform: StreamingPlatform
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .frame(width: 80, height: 80)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 0)
                
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "FEA500"), lineWidth: 2)
                        .frame(width: 80, height: 80)
                }
                
                // Platform logo placeholder
                Text(platform.name)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(platform.color)
                    .multilineTextAlignment(.center)
                    .padding(8)
            }
        }
    }
}

struct CategoryCard: View {
    let category: MovieCategory
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: category.icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "FEA500"))
                    .frame(width: 24, height: 24)
                
                Text(category.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "333333"))
                    .lineLimit(1)
                
                Spacer()
            }
            .padding(16)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color(hex: "FEA500") : Color.clear, lineWidth: 2)
            )
        }
    }
}

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

struct MovieCategory: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
}

struct StreamingPlatform: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

// MARK: - Data

let funLightCategories = [
    MovieCategory(name: "Comedy", icon: "theatermasks"),
    MovieCategory(name: "Romance", icon: "heart"),
    MovieCategory(name: "Musical", icon: "music.note"),
    MovieCategory(name: "Family", icon: "person.3"),
    MovieCategory(name: "Animation", icon: "paintbrush")
]

let epicCategories = [
    MovieCategory(name: "Adventure", icon: "globe"),
    MovieCategory(name: "Fantasy", icon: "sparkles"),
    MovieCategory(name: "Sci-Fi", icon: "rocket"),
    MovieCategory(name: "Historical", icon: "building.columns")
]

let darkCategories = [
    MovieCategory(name: "Action", icon: "flame"),
    MovieCategory(name: "Thriller", icon: "exclamationmark.triangle"),
    MovieCategory(name: "Mystery", icon: "questionmark.circle"),
    MovieCategory(name: "Crime", icon: "car"),
    MovieCategory(name: "Horror", icon: "moon.stars"),
    MovieCategory(name: "War", icon: "shield"),
    MovieCategory(name: "Western", icon: "star")
]

let realStoriesCategories = [
    MovieCategory(name: "Documentary", icon: "camera"),
    MovieCategory(name: "Biography", icon: "person"),
    MovieCategory(name: "Sport", icon: "sportscourt"),
    MovieCategory(name: "Drama", icon: "theatermasks.fill")
]

let streamingPlatforms = [
    StreamingPlatform(name: "Netflix", color: .red),
    StreamingPlatform(name: "Prime", color: .blue),
    StreamingPlatform(name: "Disney+", color: .blue),
    StreamingPlatform(name: "HBO Max", color: .purple),
    StreamingPlatform(name: "Hulu", color: .green),
    StreamingPlatform(name: "Apple TV+", color: .black),
    StreamingPlatform(name: "Peacock", color: .purple),
    StreamingPlatform(name: "Paramount+", color: .blue)
]

// MARK: - Color Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
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

struct SearchCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoriesView()
    }
}
