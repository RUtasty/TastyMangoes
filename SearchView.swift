//
//  SearchView.swift
//  TastyMangoes
//
//  Created automatically by ChatGPT on 2025-11-18 at 16:45 (America/Los_Angeles).
//  Notes: Search landing screen. Tapping Start Searching pushes selected
//         platforms + genres into SearchFilterState.shared before navigating
//         to CategoryResultsView so counts and pills stay in sync.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var selectedServices: Set<String> = []
    @State private var selectedGenres: Set<String> = []

    @State private var showResults = false

    // Shared filter state used by results + filter sheets
    @StateObject private var filterState = SearchFilterState.shared

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        SearchHeaderView()

                        SearchFieldView(text: $searchText)

                        SearchPlatformsRow(
                            selectedServices: $selectedServices
                        )

                        SearchGenresRow(
                            selectedGenres: $selectedGenres
                        )

                        Spacer(minLength: 48)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 120) // space for black bar + tab bar
                }

                StartSearchingBar(
                    count: totalSelectionCount,
                    action: startSearching
                )
            }
            .navigationDestination(isPresented: $showResults) {
                CategoryResultsView()
            }
        }
    }

    // MARK: - Helpers

    private var totalSelectionCount: Int {
        selectedServices.count + selectedGenres.count
    }

    private func startSearching() {
        guard totalSelectionCount > 0 else { return }

        // Push local selections into the shared filter state
        filterState.selectedPlatforms = selectedServices
        filterState.selectedGenres = selectedGenres

        // Reset other filters to defaults for this new run
        filterState.sortBy = "List order"
        filterState.tastyScoreRange = 0.0...100.0
        filterState.aiScoreRange = 0.0...10.0
        filterState.yearRange = 1925...2025
        filterState.likedBy = "Any"
        filterState.watchedStatus = "Any"
        // Leave actors alone – user might refine later

        print("Start Searching with \(totalSelectionCount) selections")
        showResults = true
    }
}
