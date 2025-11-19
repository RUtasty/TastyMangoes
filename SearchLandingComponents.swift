//
//  SearchLandingComponents.swift
//  TastyMangoes
//
//  Created automatically by ChatGPT on 2025-11-18 at 17:05 (America/Los_Angeles).
//  Notes: Reusable UI components for the Search landing screen:
//         header, search field, platform row, and Start Searching bar.
//

import SwiftUI

// MARK: - Search Header ("Find Your Movie")

struct SearchHeaderView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Orange gradient background
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.95),
                    Color.yellow.opacity(0.95)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 8) {
                Text("Find Your Movie 🎬")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)

                Text("Type a title or pick a genre to discover the film you're looking for.")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.9))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 18)
            .padding(.top, 18)
        }
        .frame(maxWidth: .infinity)
        .clipShape(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
        )
    }
}

// MARK: - Search Field

struct SearchFieldView: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)

            TextField("Searching film by name…", text: $text)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)

            Button {
                // Voice search hook – wire up later
                print("Voice search tapped")
            } label: {
                Image(systemName: "mic.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 3)
        )
    }
}

// MARK: - Platforms Row ("My subscriptions")

private struct SearchPlatform: Identifiable, Hashable {
    let id = UUID()
    let code: String    // e.g. "N"
    let name: String    // e.g. "Netflix"
    let tint: Color
}

private let allSearchPlatforms: [SearchPlatform] = [
    .init(code: "N", name: "Netflix",       tint: Color.red),
    .init(code: "P", name: "Prime Video",   tint: Color.blue),
    .init(code: "D", name: "Disney+",       tint: Color.blue.opacity(0.75)),
    .init(code: "M", name: "Max",           tint: Color.black),
    .init(code: "H", name: "Hulu",          tint: Color.green),
    .init(code: "T", name: "Tubi",          tint: Color.purple),
    .init(code: "C", name: "Criterion",     tint: Color.gray)
]

struct SearchPlatformsRow: View {
    @Binding var selectedServices: Set<String>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("My subscriptions")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)

                Spacer()

                Button("Clear All") {
                    selectedServices.removeAll()
                }
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.orange)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(allSearchPlatforms) { platform in
                        PlatformBadge(
                            platform: platform,
                            isSelected: selectedServices.contains(platform.name)
                        ) {
                            toggle(platform: platform)
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private func toggle(platform: SearchPlatform) {
        if selectedServices.contains(platform.name) {
            selectedServices.remove(platform.name)
        } else {
            selectedServices.insert(platform.name)
        }
    }
}

private struct PlatformBadge: View {
    let platform: SearchPlatform
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(platform.tint)
                        .frame(width: 52, height: 52)

                    Text(platform.code)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }

                Text(platform.name)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Start Searching Bar (black bar above tab bar)

struct StartSearchingBar: View {
    let count: Int
    let action: () -> Void

    private var titleText: String {
        count > 0 ? "Start Searching (\(count))" : "Start Searching"
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(titleText)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
        }
        .buttonStyle(.plain)
    }
}
