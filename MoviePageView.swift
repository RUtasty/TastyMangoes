//  MoviePageView.swift
//  Created automatically by Cursor Assistant
//  Created on: 2025-01-15 at 14:30 (California time)
//  Notes: Redesigned movie page with pinned header (back arrow, title, share/menu) and scrollable content sections with horizontal scrolling for Cast, Reviews, and Similar movies

import SwiftUI

// MARK: - Sections

private enum MovieSection: String, CaseIterable, Identifiable {
    case overview = "Overview"
    case castCrew = "Cast & Crew"
    case reviews = "Reviews"
    case similar = "More to Watch"
    
    var id: String { rawValue }
}

struct MoviePageView: View {
    
    // MARK: - Properties
    
    let movieId: String
    @StateObject private var viewModel: MovieDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedSection: MovieSection = .overview
    
    // MARK: - Initialization
    
    init(movieId: String) {
        self.movieId = movieId
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieStringId: movieId))
    }
    
    // Alternative initializer for Int IDs
    init(movieId: Int) {
        self.movieId = String(movieId)
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieId))
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingView
            } else if viewModel.hasError {
                errorView
            } else if let movie = viewModel.movie {
                movieContent(movie)
            }
        }
        .task {
            await viewModel.loadMovie()
        }
    }
    
    // MARK: - Loading View
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading movie details...")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#fdfdfd"))
    }
    
    // MARK: - Error View
    
    private var errorView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: "#FF6B6B"))
            
            Text("Oops!")
                .font(.custom("Nunito-Bold", size: 24))
                .foregroundColor(Color(hex: "#1A1A1A"))
            
            Text(viewModel.errorMessage)
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: { viewModel.retry() }) {
                Text("Try Again")
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#333333"))
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#fdfdfd"))
    }
    
    // MARK: - Movie Content
    
    private func movieContent(_ movie: MovieDetail) -> some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 0) {
                // Trailer/Backdrop Section (scrolls)
                trailerSection(movie)
                
                // Poster and Scores Section (overlaps trailer)
                posterAndScoresSection(movie)
                    .padding(.horizontal, 16)
                    .padding(.top, -58)
                
                // Mango's Tips + Watch On / Liked By cards
                tipsAndCardsSection
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                
                // Horizontal Section Tabs (scrolls with content)
                sectionTabsBar
                    .padding(.top, 24)
                
                // Content Sections
                VStack(alignment: .leading, spacing: 32) {
                    overviewSection(movie)
                        .id(MovieSection.overview.id)
                    
                    castCrewSection(movie)
                        .id(MovieSection.castCrew.id)
                    
                    reviewsSection
                        .id(MovieSection.reviews.id)
                    
                    similarSection
                        .id(MovieSection.similar.id)
                }
                .padding(.top, 24)
                .padding(.horizontal, 16)
                
                // Bottom Action Buttons
                bottomActionButtons
                    .padding(.top, 32)
                    .padding(.bottom, 32)
            }
        }
        .background(Color(hex: "#fdfdfd"))
        .safeAreaInset(edge: .top) {
            // Pinned Header: Back arrow, Title, Details, Share, Menu
            pinnedHeader(movie)
        }
    }
    
    // MARK: - Pinned Header
    
    private func pinnedHeader(_ movie: MovieDetail) -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                // Back Arrow
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                
                Spacer()
                
                // Title and Details (centered)
                VStack(spacing: 4) {
                    Text(movie.title)
                        .font(.custom("Nunito-Bold", size: 18))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                    
                    HStack(spacing: 4) {
                        Text(movie.releaseYear)
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Text("·")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Text(movie.genres.prefix(2).map { $0.name }.joined(separator: "/"))
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Text("·")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Text(movie.formattedRuntime)
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                    }
                }
                
                Spacer()
                
                // Share and Menu Icons
                HStack(spacing: 16) {
                    Button(action: {
                        // Share action
                        print("Share tapped")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                    }
                    
                    Button(action: {
                        // Menu action
                        print("Menu tapped")
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Trailer Section
    
    private func trailerSection(_ movie: MovieDetail) -> some View {
        ZStack(alignment: .topLeading) {
            // Backdrop Image
            if let backdropURL = movie.backdropURL {
                AsyncImage(url: backdropURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color(hex: "#1a1a1a"))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Rectangle()
                            .fill(Color(hex: "#1a1a1a"))
                    @unknown default:
                        Rectangle()
                            .fill(Color(hex: "#1a1a1a"))
                    }
                }
                .frame(height: 193)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color(hex: "#1a1a1a"))
                    .frame(height: 193)
            }
            
            // Play Trailer Button
            HStack(spacing: 6) {
                Image(systemName: "play.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#f3f3f3"))
                
                Text("Play Trailer")
                    .font(.custom("Nunito-Bold", size: 12))
                    .foregroundColor(Color(hex: "#f3f3f3"))
                
                if let duration = formatTrailerDuration(movie.trailerDuration) {
                    Text(duration)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color(hex: "#ececec"))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .padding(.top, 12)
            .padding(.leading, 12)
            .onTapGesture {
                if let trailerURL = movie.trailerURL {
                    print("Play trailer: \(trailerURL)")
                }
            }
        }
        .frame(height: 193)
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Poster and Scores Section
    
    private func posterAndScoresSection(_ movie: MovieDetail) -> some View {
        HStack(alignment: .bottom, spacing: 16) {
            // Poster Image
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color(hex: "#333333"))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        Rectangle()
                            .fill(Color(hex: "#333333"))
                    @unknown default:
                        Rectangle()
                            .fill(Color(hex: "#333333"))
                    }
                }
                .frame(width: 84, height: 124)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            } else {
                Rectangle()
                    .fill(Color(hex: "#333333"))
                    .frame(width: 84, height: 124)
                    .cornerRadius(8)
            }
            
            // Scores Section
            HStack(spacing: 0) {
                // Tasty Score
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Image("TastyScoreIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        
                        Text("Tasty Score")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Image(systemName: "info.circle")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                    }
                    
                    Text(movie.tastyScore != nil ? "\(Int(movie.tastyScore! * 100))%" : "N/A")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                .frame(maxWidth: .infinity)
                
                // Divider
                Rectangle()
                    .fill(Color(hex: "#ececec"))
                    .frame(width: 1, height: 40)
                
                // AI Score
                VStack(spacing: 2) {
                    HStack(spacing: 4) {
                        Image("AIScoreIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18)
                        
                        Text("AI Score")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color(hex: "#666666"))
                        
                        Image(systemName: "info.circle")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#666666"))
                    }
                    
                    Text(movie.aiScore != nil ? String(format: "%.1f", movie.aiScore!) : "N/A")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            
            Spacer()
        }
    }
    
    // MARK: - Tips and Cards Section
    
    private var tipsAndCardsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Mango's Tips Badge and Text
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 4) {
                    AIFilledIcon(size: 16)
                    Text("MANGO'S TIPS")
                        .font(.custom("Nunito-SemiBold", size: 12))
                        .foregroundColor(Color(hex: "#648d00"))
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 9999)
                        .stroke(Color(hex: "#f7c200"), lineWidth: 1)
                )
                .cornerRadius(9999)
                
                (Text("You've been into courtroom dramas lately, and your friends loved this one — Juror #2 might be your next binge. It's smart, tense, and full... ")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color(hex: "#333333"))
                 +
                 Text("Read More")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#b56900"))
                    .underline())
                .lineLimit(2)
            }
            
            // Watch On / Liked By cards
            HStack(spacing: 4) {
                // Watch On
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Watch on:")
                            .font(.custom("Nunito-Bold", size: 12))
                            .foregroundColor(Color(hex: "#333333"))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                    }
                    
                    HStack(spacing: -6) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle()
                                        .stroke(Color(hex: "#fdfdfd"), lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
                
                // Liked By
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Liked by:")
                            .font(.custom("Nunito-Bold", size: 12))
                            .foregroundColor(Color(hex: "#333333"))
                        Spacer()
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                            .foregroundColor(.black)
                    }
                    
                    HStack(spacing: -6) {
                        ForEach(0..<3) { _ in
                            Circle()
                                .fill(Color.red)
                                .frame(width: 32, height: 32)
                                .overlay(
                                    Circle()
                                        .stroke(Color(hex: "#fdfdfd"), lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            }
        }
    }
    
    // MARK: - Section Tabs Bar (scrolls with content)
    
    private var sectionTabsBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(MovieSection.allCases) { section in
                    SectionTabButton(
                        title: section.rawValue,
                        isSelected: selectedSection == section
                    ) {
                        selectedSection = section
                        // Scroll to section
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 52)
        .background(Color.white)
    }
    
    // MARK: - Overview Section
    
    private func overviewSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            if !movie.overview.isEmpty {
                Text(movie.overview)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color(hex: "#333333"))
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text("No synopsis available")
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color(hex: "#999999"))
                    .italic()
            }
            
            if !movie.genres.isEmpty {
                HStack(spacing: 4) {
                    ForEach(movie.genres, id: \.id) { genre in
                        Text(genre.name)
                            .font(.custom("Nunito-Bold", size: 14))
                            .foregroundColor(Color(hex: "#332100"))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(hex: "#ffedcc"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 9999)
                                    .stroke(Color(hex: "#ffdb99"), lineWidth: 1)
                            )
                            .cornerRadius(9999)
                    }
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                if let _ = movie.runtime {
                    InfoRow(label: "Running time", value: movie.formattedRuntime)
                }
                
                if !movie.releaseDate.isEmpty {
                    InfoRow(label: "Release dates", value: movie.releaseDate)
                }
                
                InfoRow(label: "Country", value: "United States")
                
                if let rating = movie.rating {
                    InfoRow(label: "Age restrictions", value: rating)
                }
            }
            
            // View More Info link
            HStack {
                Text("View More Info")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#FEA500"))
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
            }
            .padding(.top, 8)
        }
    }
    
    // MARK: - Cast & Crew Section (with horizontal scroll)
    
    private func castCrewSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color(hex: "#FEA500"))
                        .frame(width: 6, height: 6)
                    
                    Text("Cast & Crew")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                
                Spacer()
                
                Text("See All")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#FEA500"))
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
            }
            
            // Horizontal scrolling cast cards
            if !viewModel.displayedCast.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.displayedCast.prefix(10), id: \.id) { member in
                            VStack(spacing: 8) {
                                // Profile Image
                                AsyncImage(url: member.profileURL) { phase in
                                    switch phase {
                                    case .empty:
                                        Circle()
                                            .fill(Color(hex: "#f0f0f0"))
                                            .frame(width: 80, height: 80)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    case .failure:
                                        Circle()
                                            .fill(Color(hex: "#f0f0f0"))
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        Circle()
                                            .fill(Color(hex: "#f0f0f0"))
                                            .frame(width: 80, height: 80)
                                    }
                                }
                                
                                VStack(spacing: 2) {
                                    Text(member.name)
                                        .font(.custom("Nunito-Bold", size: 14))
                                        .foregroundColor(Color(hex: "#1a1a1a"))
                                        .lineLimit(1)
                                    
                                    Text(member.character)
                                        .font(.custom("Inter-Regular", size: 12))
                                        .foregroundColor(Color(hex: "#666666"))
                                        .lineLimit(1)
                                }
                            }
                            .frame(width: 100)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, -16)
            }
            
            // Director and Writer
            if let director = movie.director {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Director")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    Text(director)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#333333"))
                }
                .padding(.top, 16)
            }
        }
    }
    
    // MARK: - Reviews Section (with horizontal scroll)
    
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color(hex: "#FEA500"))
                        .frame(width: 6, height: 6)
                    
                    Text("Reviews")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                
                Spacer()
                
                Text("See All")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#FEA500"))
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
            }
            
            // Filter tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Text("Top")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color(hex: "#333333"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(hex: "#ffedcc"))
                        .cornerRadius(20)
                    
                    Text("Friends")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(20)
                    
                    Text("Relevant Critics")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
            
            // Horizontal scrolling review cards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<3) { index in
                        ReviewCard(index: index)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
            .padding(.top, 12)
            
            // Leave a Review button
            Button(action: {
                print("Leave a Review tapped")
            }) {
                HStack {
                    Image(systemName: "bubble.left")
                        .font(.system(size: 16))
                    Text("Leave a Review")
                        .font(.custom("Inter-SemiBold", size: 14))
                }
                .foregroundColor(Color(hex: "#1a1a1a"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "#ececec"), lineWidth: 1)
                )
            }
            .padding(.top, 16)
        }
    }
    
    // MARK: - Similar Section (with horizontal scroll)
    
    private var similarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Circle()
                        .fill(Color(hex: "#FEA500"))
                        .frame(width: 6, height: 6)
                    
                    Text("More Movies Like This")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                
                Spacer()
                
                Text("See All")
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#FEA500"))
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
            }
            
            // Horizontal scrolling similar movies
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(0..<5) { index in
                        SimilarMovieCard(index: index)
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.horizontal, -16)
        }
    }
    
    // MARK: - Bottom Action Buttons
    
    private var bottomActionButtons: some View {
        HStack(spacing: 12) {
            Button(action: {
                print("Mark as Watched tapped")
            }) {
                HStack {
                    Image(systemName: "popcorn.fill")
                        .font(.system(size: 16))
                    Text("Mark as Watched")
                        .font(.custom("Inter-SemiBold", size: 14))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(hex: "#333333"))
                .cornerRadius(8)
            }
            
            Button(action: {
                print("Add to Watchlist tapped")
            }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 16))
                    Text("Add to Watchlist")
                        .font(.custom("Inter-SemiBold", size: 14))
                }
                .foregroundColor(Color(hex: "#1a1a1a"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "#ececec"), lineWidth: 1)
                )
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Helper
    
    private func formatTrailerDuration(_ durationInSeconds: Int?) -> String? {
        guard let duration = durationInSeconds else { return nil }
        let minutes = duration / 60
        let seconds = duration % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Section Tab Button

private struct SectionTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.custom("Nunito-Bold", size: 14))
                    .foregroundColor(isSelected ? Color(hex: "#333333") : Color(hex: "#666666"))
                    .padding(.bottom, 8)
                
                Rectangle()
                    .fill(isSelected ? Color(hex: "#FEA500") : Color.clear)
                    .frame(height: 2)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
    }
}

// MARK: - Review Card

private struct ReviewCard: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Circle()
                    .fill(Color(hex: "#f0f0f0"))
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Reviewer Name")
                        .font(.custom("Nunito-Bold", size: 14))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                    
                    Text("Sep 12, 2025")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#FEA500"))
                    Text("4.0")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
            }
            
            Text("Fusce volutpat lectus et nisi consectetur finibus. In vitae scelerisque augue, in varius eros. Nunc sapien diam, euismod et pr...")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color(hex: "#333333"))
                .lineLimit(3)
            
            Button(action: {}) {
                Text("Full Review")
                    .font(.custom("Inter-SemiBold", size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
            }
        }
        .padding(16)
        .frame(width: 280)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 1)
    }
}

// MARK: - Similar Movie Card

private struct SimilarMovieCard: View {
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Poster placeholder
            Rectangle()
                .fill(Color(hex: "#f0f0f0"))
                .frame(width: 120, height: 180)
                .cornerRadius(8)
            
            Text("Movie Title")
                .font(.custom("Nunito-Bold", size: 14))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .lineLimit(1)
            
            Text("2024 · Action/Sci-Fi")
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color(hex: "#666666"))
            
            HStack(spacing: 4) {
                Image("TastyScoreIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 14)
                Text("99%")
                    .font(.custom("Inter-SemiBold", size: 12))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#FEA500"))
                Text("7.2")
                    .font(.custom("Inter-SemiBold", size: 12))
                    .foregroundColor(Color(hex: "#1a1a1a"))
            }
        }
        .frame(width: 120)
    }
}

// MARK: - Info Row

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                Text(label)
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color(hex: "#666666"))
                    .frame(width: 120, alignment: .leading)
                
                Text(value)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color(hex: "#333333"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 12)
            
            Divider()
                .background(Color(hex: "#ececec"))
        }
    }
}

// MARK: - Preview

#Preview("Normal") {
    MoviePageView(movieId: 550)
}
