//
//  MoviePageView.swift
//  TastyMangoes
//
//  Updated with exact Figma icons - 11/14/25 at 11:15 PM really 10:28pm
//

import SwiftUI

struct MoviePageView: View {
    
    // MARK: - Properties
    
    let movieId: String
    @StateObject private var viewModel: MovieDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header with video, poster, and scores
                headerSection(movie)
                
                // Tab Navigation
                tabNavigationSection
                
                // Tab Content
                tabContentSection(movie)
            }
        }
        .background(Color(hex: "#fdfdfd"))
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
    
    // MARK: - Header Section
    
    private func headerSection(_ movie: MovieDetail) -> some View {
        VStack(spacing: 0) {
            // Video/Trailer Section
            ZStack(alignment: .topLeading) {
                // Backdrop/Trailer Image
                if let backdropURL = movie.backdropURL {
                    AsyncImage(url: backdropURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color(hex: "#1A1A1A"))
                    }
                    .frame(height: 193)
                    .clipped()
                }
                
                // Play Trailer Button
                HStack(spacing: 6) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#f3f3f3"))
                    
                    Text("Play Trailer")
                        .font(.custom("Nunito-Bold", size: 12))
                        .foregroundColor(Color(hex: "#f3f3f3"))
                    
                    Text("4:20")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color(hex: "#ececec"))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .padding(.top, 12)
                .padding(.leading, 12)
            }
            .frame(height: 193)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            
            // Poster and Scores Section - overlapping video
            HStack(alignment: .bottom, spacing: 16) {
                // Poster - drops down
                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color(hex: "#333333"))
                    }
                    .frame(width: 84, height: 124)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                
                // Scores Section
                HStack(spacing: 0) {
                    // Tasty Score
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 2) {
                            MangoLogoIcon(size: 16.667)
                            Text("Tasty Score")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color(hex: "#666666"))
                            Image(systemName: "info.circle")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#666666"))
                        }
                        
                        if let tastyScore = movie.tastyScore {
                            Text(String(format: "%.0f%%", tastyScore))
                                .font(.custom("Nunito-Bold", size: 20))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                        }
                    }
                    
                    // Divider
                    Rectangle()
                        .fill(Color(hex: "#ececec"))
                        .frame(width: 1, height: 40)
                        .padding(.horizontal, 12)
                    
                    // AI Score
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 2) {
                            AIFilledIcon(size: 20)
                            Text("AI Score")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color(hex: "#666666"))
                            Image(systemName: "info.circle")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#666666"))
                        }
                        
                        if let aiScore = movie.aiScore {
                            Text(String(format: "%.1f", aiScore))
                                .font(.custom("Nunito-Bold", size: 20))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                        }
                    }
                }
                .padding(.bottom, 8)
                
                Spacer()
            }
            .padding(.horizontal, 28)
            .offset(y: -58)
            
            // Mango's Tips and Cards Section
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
                
                // Watch On and Liked By Cards
                HStack(spacing: 4) {
                    // Watch On Card
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
                    
                    // Liked By Card
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
            .padding(.horizontal, 16)
            .padding(.top, -40)
        }
    }
    
    // MARK: - Back Button
    
    private var backButton: some View {
        Button(action: { dismiss() }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.black.opacity(0.4))
                .clipShape(Circle())
        }
        .padding(.top, 50)
        .padding(.leading, 16)
    }
    
    // MARK: - Tab Navigation
    
    private var tabNavigationSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(MovieTab.allCases) { tab in
                    TabButton(
                        title: tab.rawValue,
                        isSelected: viewModel.selectedTab == tab,
                        action: { viewModel.selectTab(tab) }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 0)
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.04), radius: 2, x: 0, y: 1)
    }
    
    // MARK: - Tab Content
    
    private func tabContentSection(_ movie: MovieDetail) -> some View {
        Group {
            switch viewModel.selectedTab {
            case .overview:
                overviewTab(movie)
            case .cast:
                castTab
            case .crew:
                crewTab
            case .reviews:
                reviewsTab
            case .similar:
                similarTab
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    // MARK: - Overview Tab
    
    private func overviewTab(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Synopsis
            synopsisSection(movie)
            
            // Genre badges
            genreBadgesSection(movie)
            
            // Movie Info
            movieInfoSection(movie)
            
            Spacer(minLength: 60)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .background(Color(hex: "#FDFDFD"))
    }
    
    private func synopsisSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
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
        }
    }
    
    private func genreBadgesSection(_ movie: MovieDetail) -> some View {
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
    
    private func movieInfoSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if let runtime = movie.runtime {
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
    }
    
    // MARK: - Cast Tab
    
    private var castTab: some View {
        CastTabView(cast: viewModel.displayedCast)
    }
    
    // MARK: - Crew Tab
    
    private var crewTab: some View {
        CrewTabView(crew: viewModel.displayedCrew)
    }
    
    // MARK: - Reviews Tab (Placeholder)
    
    private var reviewsTab: some View {
        VStack(spacing: 16) {
            Image(systemName: "text.bubble")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: "#CCCCCC"))
            Text("Reviews coming soon")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }
    
    // MARK: - Similar Tab (Placeholder)
    
    private var similarTab: some View {
        VStack(spacing: 16) {
            Image(systemName: "film.stack")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: "#CCCCCC"))
            Text("Similar movies coming soon")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }
}

// MARK: - Supporting Views

struct TabButton: View {
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
            .padding(.horizontal, 0)
            .padding(.vertical, 12)
            
            Divider()
                .background(Color(hex: "#ececec"))
        }
    }
}

// MARK: - Previews

#Preview("Normal") {
    MoviePageView(movieId: 550)
}

#Preview("With Mock Data") {
    let viewModel = MovieDetailViewModel.mock()
    return MoviePageView(movieId: 550)
}
