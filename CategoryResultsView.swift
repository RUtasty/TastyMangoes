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
                    MovieSummaryRow(movie: movie)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 12, trailing: 16))
                }
            }
            .listStyle(.plain)
        }
        .background(Color(hex: "#F7F7F7"))
        .navigationBarBackButtonHidden(true)
        .toolbarVisibility(.hidden, for: .navigationBar)
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

// MARK: - Movie Summary Row

struct MovieSummaryRow: View {
    let movie: MovieSummary
    
    var body: some View {
        HStack(spacing: 16) {
            // Poster
            MoviePosterImage(
                posterURL: movie.posterImageURL,
                width: 70,
                height: 105
            )
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            // Content
            VStack(alignment: .leading, spacing: 6) {
                // Title
                Text(movie.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .lineLimit(2)
                
                // Year / release info
                if let release = movie.releaseDate, !release.isEmpty {
                    Text(release)
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#666666"))
                        .lineLimit(1)
                } else {
                    Text(String(movie.year))
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#666666"))
                }
                
                // Genres
                if !movie.genres.isEmpty {
                    Text(movie.genres.prefix(2).joined(separator: ", "))
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#999999"))
                        .lineLimit(1)
                }
                
                // Scores
                HStack(spacing: 12) {
                    // Tasty Score
                    if let tastyScore = movie.tastyScore {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(hex: "#FEA500"))
                                .font(.system(size: 12))
                            
                            Text("\(Int(tastyScore * 100))%")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                        }
                    }
                    
                    // AI Score
                    if let aiScore = movie.aiScore {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color(hex: "#FFD60A"))
                                .font(.system(size: 12))
                            
                            Text(String(format: "%.1f", aiScore))
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                        }
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}
