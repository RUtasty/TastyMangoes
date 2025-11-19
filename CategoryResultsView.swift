//
//  CategoryResultsView.swift
//  TastyMangoes
//
//  Created automatically by ChatGPT on 2025-11-18 at 16:45 (America/Los_Angeles).
//  Notes: Search results list. Header pills (Platform / Genres) are bound to
//         SearchFilterState.shared so they reflect selected filters.
//

import SwiftUI

struct CategoryResultsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var filterState = SearchFilterState.shared

    // Temporary sample data
    let movies: [MovieSummary] = SampleMovies.resultsSample

    var body: some View {
        VStack(spacing: 0) {
            // Header search + pills
            VStack(spacing: 12) {
                ResultsSearchBar(onBack: { dismiss() })

                HStack(spacing: 8) {
                    FilterSummaryBadge(text: filterState.platformFilterText)
                    FilterSummaryBadge(text: filterState.genreFilterText)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 4)

            Divider()

            List {
                ForEach(movies) { movie in
                    IndividualListView(movie: movie)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(hex: "#F7F7F7"))
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Header pieces

struct ResultsSearchBar: View {
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 32, height: 32)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 1)
            }

            HStack(spacing: 8) {
                Text("Searching film by name…")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#B0B0B0"))

                Spacer()

                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#B0B0B0"))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

/// Simple white pill that shows a single text label, e.g. "Platform: Any" or "Genres: 3+"
struct FilterSummaryBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(Color(hex: "#333333"))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: "#E3E3E3"), lineWidth: 1)
            )
    }
}
