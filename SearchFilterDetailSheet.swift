//
//  SearchFilterDetailSheet.swift
//  TastyMangoes
//
//  Created automatically by ChatGPT on 2025-11-18 at 16:45 (America/Los_Angeles).
//  Notes: Detail sheet for a single Search filter (Genres, Platform, Year, etc.).
//         Bottom "Apply" button now shows an Apply (N) count for the current filter.
//

import SwiftUI

struct SearchFilterDetailSheet: View {
    enum FilterType {
        case sortBy
        case platform
        case tastyScore
        case aiScore
        case genres
        case year
        case likedBy
        case actors
    }

    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var filterState = SearchFilterState.shared

    let filterType: FilterType
    let title: String

    var body: some View {
        VStack(spacing: 0) {
            // Grabber + Title
            VStack(spacing: 8) {
                Capsule()
                    .fill(Color(hex: "#D8D8D8"))
                    .frame(width: 36, height: 4)
                    .padding(.top, 8)

                Text(title)
                    .font(.custom("Nunito-Bold", size: 18))
            }
            .padding(.bottom, 8)

            // Content
            Group {
                switch filterType {
                case .sortBy:
                    sortByContent
                case .platform:
                    platformContent
                case .tastyScore:
                    scoreContent(
                        title: "Tasty Score",
                        range: $filterState.tastyScoreRange,
                        maxValue: 100
                    )
                case .aiScore:
                    scoreContent(
                        title: "AI Score",
                        range: $filterState.aiScoreRange,
                        maxValue: 10
                    )
                case .genres:
                    genresContent
                case .year:
                    yearContent
                case .likedBy:
                    likedByContent
                case .actors:
                    actorsContent
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 12)

            Spacer(minLength: 0)

            // Apply Button with count
            VStack(spacing: 0) {
                Divider()
                    .background(Color(hex: "#f3f3f3"))

                Button(action: {
                    dismiss()
                }) {
                    Text(applyButtonTitle)
                        .font(.custom("Nunito-Bold", size: 14))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.black)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                }
            }
            .background(Color.white)
        }
        .background(Color(hex: "#F7F7F7"))
    }

    // MARK: - Apply button count for this filter

    private var applyButtonTitle: String {
        let count = selectionCountForCurrentFilter
        if count > 0 {
            return "Apply (\(count))"
        } else {
            return "Apply"
        }
    }

    private var selectionCountForCurrentFilter: Int {
        switch filterType {
        case .sortBy:
            return filterState.sortBy == "List order" ? 0 : 1

        case .platform:
            return filterState.selectedPlatforms.count

        case .tastyScore:
            return filterState.tastyScoreRange == 0...100 ? 0 : 1

        case .aiScore:
            return filterState.aiScoreRange == 0...10 ? 0 : 1

        case .genres:
            return filterState.selectedGenres.count

        case .year:
            return filterState.yearRange == 1925...2025 ? 0 : 1

        case .likedBy:
            return filterState.likedBy == "Any" ? 0 : 1

        case .actors:
            let trimmed = filterState.actors.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { return 0 }
            let pieces = trimmed
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { !$0.isEmpty }
            return max(pieces.count, 1)
        }
    }

    // MARK: - Section Content

    private var sortByContent: some View {
        List {
            ForEach([
                "List order",
                "Tasty Score (high → low)",
                "AI Score (high → low)",
                "Newest first",
                "Oldest first"
            ], id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    if filterState.sortBy == option {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "#FEA500"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    filterState.sortBy = option
                }
            }
        }
        .listStyle(.plain)
    }

    private var platformContent: some View {
        List {
            ForEach(["Netflix", "Prime Video", "Disney+", "Max", "Hulu"], id: \.self) { platform in
                HStack {
                    Text(platform)
                    Spacer()
                    if filterState.selectedPlatforms.contains(platform) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "#FEA500"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if filterState.selectedPlatforms.contains(platform) {
                        filterState.selectedPlatforms.remove(platform)
                    } else {
                        filterState.selectedPlatforms.insert(platform)
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    private func scoreContent(
        title: String,
        range: Binding<ClosedRange<Double>>,
        maxValue: Double
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.custom("Nunito-SemiBold", size: 16))

            Text("\(Int(range.wrappedValue.lowerBound)) – \(Int(range.wrappedValue.upperBound))")
                .font(.custom("Nunito-Regular", size: 14))

            Slider(
                value: Binding(
                    get: {
                        (range.wrappedValue.lowerBound + range.wrappedValue.upperBound) / 2
                    },
                    set: { newCenter in
                        let halfWidth = (range.wrappedValue.upperBound - range.wrappedValue.lowerBound) / 2
                        let lower = max(0, newCenter - halfWidth)
                        let upper = min(maxValue, newCenter + halfWidth)
                        range.wrappedValue = lower...upper
                    }
                ),
                in: 0...maxValue
            )
        }
    }

    private var genresContent: some View {
        List {
            ForEach(allGenres, id: \.self) { genre in
                HStack {
                    Text(genre)
                    Spacer()
                    if filterState.selectedGenres.contains(genre) {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "#FEA500"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if filterState.selectedGenres.contains(genre) {
                        filterState.selectedGenres.remove(genre)
                    } else {
                        filterState.selectedGenres.insert(genre)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    // MARK: - Genre List
    
    private let allGenres: [String] = [
        "Action",
        "Adventure",
        "Animation",
        "Biography",
        "Comedy",
        "Crime",
        "Documentary",
        "Drama",
        "Family",
        "Fantasy",
        "Historical",
        "Horror",
        "Musical",
        "Mystery",
        "Romance",
        "Sci-Fi",
        "Sport",
        "Thriller",
        "War",
        "Western"
    ]

    private var yearContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Year")
                .font(.custom("Nunito-SemiBold", size: 16))

            Text("\(filterState.yearRange.lowerBound) – \(filterState.yearRange.upperBound)")
                .font(.custom("Nunito-Regular", size: 14))

            Slider(
                value: Binding(
                    get: {
                        Double(filterState.yearRange.lowerBound + filterState.yearRange.upperBound) / 2
                    },
                    set: { newCenter in
                        let width = Double(filterState.yearRange.upperBound - filterState.yearRange.lowerBound)
                        let lower = max(1925, Int(newCenter - width / 2))
                        let upper = min(2025, Int(newCenter + width / 2))
                        filterState.yearRange = lower...upper
                    }
                ),
                in: 1925...2025
            )
        }
    }

    private var likedByContent: some View {
        List {
            ForEach(["Any", "Friends", "Critics"], id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    if filterState.likedBy == option {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(hex: "#FEA500"))
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    filterState.likedBy = option
                }
            }
        }
        .listStyle(.plain)
    }

    private var actorsContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Actors")
                .font(.custom("Nunito-SemiBold", size: 16))

            TextField("Type actor names…", text: $filterState.actors)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.top, 12)
    }
}
