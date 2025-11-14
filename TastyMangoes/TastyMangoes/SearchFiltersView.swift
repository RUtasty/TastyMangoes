//
//  SearchFiltersView.swift
//  Tasty Mangoes
//
//  Updated by Claude on 11/13/25 at 3:57 PM
//

import SwiftUI

struct SearchFiltersView: View {
    @State private var showMySubscriptions = false
    @State private var selectedPlatforms: Set<String> = []
    @State private var selectedCategories: Set<String> = []
    @State private var navigateToResults = false
    
    private var totalSelections: Int {
        selectedPlatforms.count + selectedCategories.count
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Main Content
                ScrollView(showsIndicators: true) {
                    VStack(alignment: .leading, spacing: 24) {
                        // Top Nav with gradient background
                        VStack(alignment: .leading, spacing: 16) {
                            HStack(spacing: 16) {
                                // Text Block
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Find Your Movie 🎬")
                                        .font(.custom("Nunito-Bold", size: 24))
                                        .foregroundColor(Color(hex: "#1a1a1a"))
                                    
                                    Text("Type a title or pick a genre\nto discover the film you're looking for.")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(hex: "#333333"))
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
                            
                            // Search Input
                            HStack(spacing: 8) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                                
                                Text("Searching by name...")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color(hex: "#666666"))
                                
                                Spacer()
                                
                                Image(systemName: "mic.fill")
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                            }
                            .padding(12)
                            .background(Color(hex: "#ffdb99"))
                            .cornerRadius(8)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 68)
                        .padding(.bottom, 20)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "#F7C200").opacity(0.8),
                                    Color(hex: "#FEA500").opacity(0.8),
                                    Color(hex: "#F48500").opacity(0.8)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: 2)
                        
                        // Categories Section
                        VStack(alignment: .leading, spacing: 24) {
                            // Results count and Clear All
                            HStack {
                                Text("1000+ results found")
                                    .font(.custom("Nunito-SemiBold", size: 14))
                                    .foregroundColor(Color(hex: "#999999"))
                                    .padding(.horizontal, 4)
                                
                                Spacer()
                                
                                Button(action: clearAll) {
                                    Text("Clear All")
                                        .font(.custom("Nunito-Bold", size: 14))
                                        .foregroundColor(Color(hex: "#414141"))
                                        .underline()
                                }
                            }
                            
                            // My Subscriptions
                            VStack(alignment: .leading, spacing: 16) {
                                HStack(spacing: 8) {
                                    Image(systemName: showMySubscriptions ? "checkmark.square.fill" : "square")
                                        .foregroundColor(showMySubscriptions ? Color(hex: "#FEA500") : Color(hex: "#b3b3b3"))
                                        .frame(width: 24, height: 24)
                                        .onTapGesture {
                                            showMySubscriptions.toggle()
                                        }
                                    
                                    Text("My subscriptions")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Color(hex: "#333333"))
                                }
                                
                                // Platform Logos
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 4) {
                                        SelectablePlatformCard(
                                            name: "Netflix",
                                            isSelected: selectedPlatforms.contains("Netflix")
                                        ) {
                                            togglePlatform("Netflix")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Prime Video",
                                            isSelected: selectedPlatforms.contains("Prime Video")
                                        ) {
                                            togglePlatform("Prime Video")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Disney+",
                                            isSelected: selectedPlatforms.contains("Disney+")
                                        ) {
                                            togglePlatform("Disney+")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "HBO Max",
                                            isSelected: selectedPlatforms.contains("HBO Max")
                                        ) {
                                            togglePlatform("HBO Max")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Hulu",
                                            isSelected: selectedPlatforms.contains("Hulu")
                                        ) {
                                            togglePlatform("Hulu")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Apple TV+",
                                            isSelected: selectedPlatforms.contains("Apple TV+")
                                        ) {
                                            togglePlatform("Apple TV+")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Peacock",
                                            isSelected: selectedPlatforms.contains("Peacock")
                                        ) {
                                            togglePlatform("Peacock")
                                        }
                                        
                                        SelectablePlatformCard(
                                            name: "Paramount+",
                                            isSelected: selectedPlatforms.contains("Paramount+")
                                        ) {
                                            togglePlatform("Paramount+")
                                        }
                                    }
                                }
                            }
                            
                            // Fun & Light
                            SelectableCategorySection(
                                title: "FUN & LIGHT",
                                categories: [
                                    CategoryItem(icon: "😊", name: "Comedy"),
                                    CategoryItem(icon: "💕", name: "Romance"),
                                    CategoryItem(icon: "🎵", name: "Musical"),
                                    CategoryItem(icon: "👨‍👩‍👧‍👦", name: "Family"),
                                    CategoryItem(icon: "🎨", name: "Animation")
                                ],
                                selectedCategories: $selectedCategories
                            )
                            
                            // Epic & Imaginative
                            SelectableCategorySection(
                                title: "EPIC & IMAGINATIVE",
                                categories: [
                                    CategoryItem(icon: "🗺️", name: "Adventure"),
                                    CategoryItem(icon: "✨", name: "Fantasy"),
                                    CategoryItem(icon: "🚀", name: "Sci-Fi"),
                                    CategoryItem(icon: "🏛️", name: "Historical")
                                ],
                                selectedCategories: $selectedCategories
                            )
                            
                            // Dark & Intense
                            SelectableCategorySection(
                                title: "DARK & INTENSE",
                                categories: [
                                    CategoryItem(icon: "💥", name: "Action"),
                                    CategoryItem(icon: "🔍", name: "Thriller"),
                                    CategoryItem(icon: "🕵️", name: "Mystery"),
                                    CategoryItem(icon: "🚔", name: "Crime"),
                                    CategoryItem(icon: "👻", name: "Horror"),
                                    CategoryItem(icon: "⚔️", name: "War"),
                                    CategoryItem(icon: "🤠", name: "Western")
                                ],
                                selectedCategories: $selectedCategories
                            )
                            
                            // Real Stories
                            SelectableCategorySection(
                                title: "REAL STORIES",
                                categories: [
                                    CategoryItem(icon: "🎬", name: "Documentary"),
                                    CategoryItem(icon: "📖", name: "Biography"),
                                    CategoryItem(icon: "⚽", name: "Sport"),
                                    CategoryItem(icon: "🎭", name: "Drama")
                                ],
                                selectedCategories: $selectedCategories
                            )
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 140) // Space for button and tab bar
                    }
                }
                .background(Color(hex: "#fdfdfd"))
                
                // Bottom Button (floating above tab bar)
                VStack {
                    Spacer()
                    
                    Button(action: startSearching) {
                        Text("Start Searching (\(totalSelections))")
                            .font(.custom("Nunito-Bold", size: 14))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(hex: "#333333"))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 76) // Above the tab bar
                    .background(
                        Color.white.opacity(0.95)
                            .frame(height: 100)
                            .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: -2)
                    )
                }
            }
            .ignoresSafeArea(edges: .top)
            .navigationDestination(isPresented: $navigateToResults) {
                CategoryResultsView()
            }
        }
    }
    
    // MARK: - Actions
    
    private func togglePlatform(_ platform: String) {
        if selectedPlatforms.contains(platform) {
            selectedPlatforms.remove(platform)
        } else {
            selectedPlatforms.insert(platform)
        }
    }
    
    private func clearAll() {
        selectedPlatforms.removeAll()
        selectedCategories.removeAll()
    }
    
    private func startSearching() {
        // Navigate to results
        navigateToResults = true
    }
}

// MARK: - Preview

#Preview {
    SearchFiltersView()
}
