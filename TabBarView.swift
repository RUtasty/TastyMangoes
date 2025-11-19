//
//  TabBarView.swift
//  TastyMangoes
//
//  Created automatically by Cursor Assistant on 2025-11-18 at 11:05 (America/Los_Angeles).
//  Notes: Root tab container with custom tab bar and floating Talk to Mango button.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0          // 0 = Home

    var body: some View {
        ZStack {
            // Main content with a bottom inset where we draw the custom tab bar
            currentTabView
                .safeAreaInset(edge: .bottom) {
                    CustomTabBar(selectedTab: $selectedTab)
                }

            // Floating Mango button – always visible for now
            VStack {
                Spacer()
                TalkToMangoButton {
                    selectedTab = 2
                }
                .padding(.bottom, 32)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(.keyboard)
    }

    // MARK: - Current Tab

    @ViewBuilder
    private var currentTabView: some View {
        switch selectedTab {
        case 0:
            HomeView()                        // your existing HomeView.swift

        case 1:
            SearchView()                      // cleaned-up Search screen

        case 2:
            // Placeholder for Talk to Mango / AI chat
            Color(.systemBackground)
                .overlay(
                    Text("Talk to Mango (Coming Soon)")
                        .font(.title3)
                        .foregroundColor(.gray)
                )

        case 3:
            WatchlistView()                   // your existing WatchlistView.swift

        case 4:
            MoreView()                        // your existing MoreView.swift

        default:
            SearchView()
        }
    }
}

// MARK: - Custom Tab Bar

struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            // Background
            VStack(spacing: 0) {
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.06),
                        Color.black.opacity(0.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 1)

                Color.white
                    .frame(height: 60)
            }
            .shadow(color: Color.black.opacity(0.04), radius: 12, x: 0, y: -2)

            // Items
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

                Spacer().frame(width: 56)   // gap for Mango button

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
        }
    }
}

// MARK: - Floating Talk to Mango Button

struct TalkToMangoButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hex: "#FFA500"),
                                Color(hex: "#FF8C00")
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 3)

                Image(systemName: "flame.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - Tab Bar Item

struct TabBarItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(isSelected ? Color(hex: "#FEA500") : Color(hex: "#999999"))

                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(isSelected ? Color(hex: "#FEA500") : Color(hex: "#999999"))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
        }
    }
}

#Preview {
    TabBarView()
}
