//
//  SearchFilterState.swift
//  TastyMangoes
//
//  Created automatically by ChatGPT on 2025-11-18 at 17:58 (America/Los_Angeles).
//  Notes: Shared observable state for Search filters (platforms, genres,
//         scores, years, liked-by, and actors). Used by SearchView,
//         SearchFiltersBottomSheet, and SearchFilterDetailSheet.
//

import Foundation
import SwiftUI
import Combine

final class SearchFilterState: ObservableObject {
    // Shared singleton instance used across Search screens
    static let shared = SearchFilterState()

    // MARK: - Sort / ordering

    /// Selected sort option (e.g. "List order", "Tasty Score", etc.)
    @Published var sortBy: String = "List order"

    // MARK: - Platforms & Genres

    /// Selected streaming platforms (e.g. ["Netflix", "Prime Video"])
    @Published var selectedPlatforms: Set<String> = []

    /// Selected genres (e.g. ["Action", "Drama"])
    @Published var selectedGenres: Set<String> = []

    // MARK: - Scores

    /// Allowed range for Tasty Score (0.0–100.0)
    @Published var tastyScoreRange: ClosedRange<Double> = 0.0...100.0

    /// Allowed range for AI Score (0.0–10.0)
    @Published var aiScoreRange: ClosedRange<Double> = 0.0...10.0

    // MARK: - Release Year

    /// Allowed release year range (1925–2025 by default)
    @Published var yearRange: ClosedRange<Int> = 1925...2025

    // MARK: - Social / People

    /// "Any", "Friends", etc.
    @Published var likedBy: String = "Any"

    /// Free-text actor search field.
    @Published var actors: String = ""

    /// Watched status filter ("Any", "Watched", "Unwatched")
    @Published var watchedStatus: String = "Any"

    // MARK: - Computed Properties

    /// Text for platform filter badge (e.g. "Platform: Any" or "Platform: 3+")
    var platformFilterText: String {
        if selectedPlatforms.isEmpty {
            return "Platform: Any"
        } else if selectedPlatforms.count == 1 {
            return "Platform: \(selectedPlatforms.first ?? "")"
        } else {
            return "Platform: \(selectedPlatforms.count)+"
        }
    }

    /// Text for genre filter badge (e.g. "Genres: Any" or "Genres: 3+")
    var genreFilterText: String {
        if selectedGenres.isEmpty {
            return "Genres: Any"
        } else if selectedGenres.count == 1 {
            return "Genres: \(selectedGenres.first ?? "")"
        } else {
            return "Genres: \(selectedGenres.count)+"
        }
    }

    // MARK: - Helper Methods

    /// Clear all platform filters
    func clearPlatformFilters() {
        selectedPlatforms.removeAll()
    }

    /// Clear all genre filters
    func clearGenreFilters() {
        selectedGenres.removeAll()
    }

    // Private so everyone uses the shared singleton
    private init() {}
}
