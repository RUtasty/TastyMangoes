//
//  TabBarView.swift
//  Tasty Mangoes
//
//  Updated by Claude on 11/13/25 at 9:43 PM
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab content
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                SearchView()
                    .tag(1)
                
                // AI Chat placeholder for center button
                Color.clear
                    .tag(2)
                
                WatchlistView()
                    .tag(3)
                
                MoreView()
                    .tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            // Custom tab bar
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            // Tab bar background with gradient top border
            VStack(spacing: 0) {
                // Gradient border at top
                LinearGradient(
                    colors: [
                        Color(red: 255/255, green: 237/255, blue: 204/255),
                        Color(red: 255/255, green: 237/255, blue: 204/255)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 1)
                
                // White background
                Color.white
                    .frame(height: 60)
            }
            .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: -2)
            
            // Tab items
            HStack(spacing: 0) {
                TabBarItem(
                    icon: "house.fill",
                    label: "Home",
                    isSelected: selectedTab == 0
                ) {
                    selectedTab = 0
                }
                
                TabBarItem(
                    icon: "magnifyingglass",
                    label: "Search",
                    isSelected: selectedTab == 1
                ) {
                    selectedTab = 1
                }
                
                // Center spacer for AI button
                Spacer()
                    .frame(width: 88)
                
                TabBarItem(
                    icon: "list.bullet",
                    label: "Watchlist",
                    isSelected: selectedTab == 3
                ) {
                    selectedTab = 3
                }
                
                TabBarItem(
                    icon: "ellipsis",
                    label: "More",
                    isSelected: selectedTab == 4
                ) {
                    selectedTab = 4
                }
            }
            .frame(height: 60)
            .padding(.horizontal, 16)
            
            // Floating AI Button
            VStack {
                Spacer()
                
                Button {
                    selectedTab = 2
                } label: {
                    ZStack {
                        // Gradient background
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color(red: 255/255, green: 200/255, blue: 87/255),
                                        Color(red: 255/255, green: 165/255, blue: 0/255)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 56, height: 56)
                        
                        // Inner highlight
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            .frame(width: 56, height: 56)
                        
                        // Mango icon
                        MangoIconView()
                            .frame(width: 28, height: 28)
                    }
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                }
                .offset(y: -34)
                
                // Label below button
                Text("Talk to Mango")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                    .offset(y: -24)
            }
        }
        .frame(height: 60)
    }
}

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 17))
                    .foregroundColor(isSelected ? Color(red: 65/255, green: 65/255, blue: 65/255) : Color(red: 153/255, green: 153/255, blue: 153/255))
                
                Text(label)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(isSelected ? Color(red: 51/255, green: 51/255, blue: 51/255) : Color(red: 153/255, green: 153/255, blue: 153/255))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
    }
}

struct MangoIconView: View {
    var body: some View {
        ZStack {
            // Mango shape (simplified version)
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: 20, height: 20)
            
            // You can replace this with the actual mango vector from Figma
            Text("🥭")
                .font(.system(size: 16))
        }
    }
}

// Placeholder views for other tabs
struct WatchlistView: View {
    var body: some View {
        ZStack {
            Color(red: 253/255, green: 253/255, blue: 253/255)
                .ignoresSafeArea()
            Text("Watchlist")
                .font(.largeTitle)
        }
    }
}

struct MoreView: View {
    var body: some View {
        ZStack {
            Color(red: 253/255, green: 253/255, blue: 253/255)
                .ignoresSafeArea()
            Text("More")
                .font(.largeTitle)
        }
    }
}

#Preview {
    TabBarView()
}
