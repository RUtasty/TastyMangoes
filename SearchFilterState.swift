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

    /// Allowed range for Tasty Score (0–100)
    @Published var tastyScoreRange: ClosedRange<Int> = 0...100

    /// Allowed range for AI Score (0–10)
    @Published var aiScoreRange: ClosedRange<Int> = 0...10

    // MARK: - Release Year

    /// Allowed release year range (1925–2025 by default)
    @Published var yearRange: ClosedRange<Int> = 1925...2025

    // MARK: - Social / People

    /// "Any", "Friends", etc.
    @Published var likedBy: String = "Any"

    /// Free-text actor search field.
    @Published var actors: String = ""

    // Private so everyone uses the shared singleton
    private init() {}
}
