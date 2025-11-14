//
//  MoviePageView.swift
//  TastyMangoes
//
//  Created by Claude on 11/13/25 at 7:02 PM
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
        .background(Color(hex: "#F5F5F5"))
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
                    .background(Color(hex: "#8B5CF6"))
                    .cornerRadius(8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#F5F5F5"))
    }
    
    // MARK: - Movie Content
    
    private func movieContent(_ movie: MovieDetail) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header with backdrop and poster
                headerSection(movie)
                
                // Tab Navigation
                tabNavigationSection
                
                // Tab Content
                tabContentSection(movie)
            }
        }
        .background(Color(hex: "#F5F5F5"))
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
    
    // MARK: - Header Section
    
    private func headerSection(_ movie: MovieDetail) -> some View {
        ZStack(alignment: .bottomLeading) {
            // Backdrop Image
            if let backdropURL = movie.backdropURL {
                AsyncImage(url: backdropURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Rectangle()
                        .fill(Color(hex: "#1A1A1A"))
                }
                .frame(height: 280)
                .clipped()
            }
            
            // Gradient Overlay
            LinearGradient(
                colors: [
                    Color.black.opacity(0),
                    Color.black.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 280)
            
            // Poster and Title
            HStack(alignment: .bottom, spacing: 16) {
                // Poster
                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color(hex: "#333333"))
                    }
                    .frame(width: 100, height: 150)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                
                // Title and Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.custom("Nunito-Bold", size: 24))
                        .foregroundColor(.white)
                        .lineLimit(2)
                    
                    HStack(spacing: 8) {
                        Text(movie.releaseYear)
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color.white.opacity(0.8))
                        
                        if let rating = movie.rating {
                            Text("•")
                                .foregroundColor(Color.white.opacity(0.8))
                            Text(rating)
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color.white.opacity(0.8))
                        }
                        
                        if let runtime = movie.runtime {
                            Text("•")
                                .foregroundColor(Color.white.opacity(0.8))
                            Text(movie.formattedRuntime)
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color.white.opacity(0.8))
                        }
                    }
                    
                    // Genres
                    Text(movie.genresList)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color.white.opacity(0.7))
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
        .frame(height: 280)
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
            .padding(.horizontal, 20)
        }
        .background(Color.white)
        .padding(.top, 16)
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
        .padding(.top, 20)
    }
    
    // MARK: - Overview Tab
    
    private func overviewTab(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            // Scores Section
            scoresSection(movie)
            
            // Synopsis
            synopsisSection(movie)
            
            // Movie Info
            movieInfoSection(movie)
            
            Spacer(minLength: 40)
        }
        .padding(.horizontal, 20)
    }
    
    private func scoresSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Scores")
                .font(.custom("Nunito-Bold", size: 20))
                .foregroundColor(Color(hex: "#1A1A1A"))
            
            HStack(spacing: 12) {
                if let tastyScore = movie.tastyScore {
                    ScoreCard(label: "Tasty", score: String(format: "%.0f", tastyScore), color: Color(hex: "#8B5CF6"))
                }
                if let aiScore = movie.aiScore {
                    ScoreCard(label: "AI", score: String(format: "%.0f", aiScore), color: Color(hex: "#3B82F6"))
                }
                if let criticsScore = movie.criticsScore {
                    ScoreCard(label: "Critics", score: String(format: "%.0f", criticsScore), color: Color(hex: "#10B981"))
                }
                if let audienceScore = movie.audienceScore {
                    ScoreCard(label: "Audience", score: String(format: "%.0f", audienceScore), color: Color(hex: "#F59E0B"))
                }
            }
        }
    }
    
    private func synopsisSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Synopsis")
                .font(.custom("Nunito-Bold", size: 20))
                .foregroundColor(Color(hex: "#1A1A1A"))
            
            Text(movie.overview)
                .font(.custom("Inter-Regular", size: 15))
                .foregroundColor(Color(hex: "#333333"))
                .lineSpacing(4)
        }
    }
    
    private func movieInfoSection(_ movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Movie Info")
                .font(.custom("Nunito-Bold", size: 20))
                .foregroundColor(Color(hex: "#1A1A1A"))
                .padding(.bottom, 16)
            
            VStack(spacing: 0) {
                if let director = movie.director {
                    InfoRow(label: "Director", value: director)
                }
                
                let writers = viewModel.writersNames
                if !writers.isEmpty {
                    InfoRow(label: "Writer", value: writers)
                }
                
                if let runtime = movie.runtime {
                    InfoRow(label: "Running time", value: movie.formattedRuntime)
                }
                
                InfoRow(label: "Budget", value: movie.formattedBudget)
                InfoRow(label: "Revenue", value: movie.formattedRevenue)
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }
    
    // MARK: - Cast Tab
    
    private var castTab: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Cast")
                .font(.custom("Nunito-Bold", size: 20))
                .foregroundColor(Color(hex: "#1A1A1A"))
                .padding(.horizontal, 20)
            
            if viewModel.displayedCast.isEmpty {
                Text("No cast information available")
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color(hex: "#666666"))
                    .padding(.horizontal, 20)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.displayedCast) { member in
                            CastMemberRow(member: member)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
    
    // MARK: - Crew Tab
    
    private var crewTab: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Crew")
                .font(.custom("Nunito-Bold", size: 20))
                .foregroundColor(Color(hex: "#1A1A1A"))
                .padding(.horizontal, 20)
            
            if viewModel.displayedCrew.isEmpty {
                Text("No crew information available")
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color(hex: "#666666"))
                    .padding(.horizontal, 20)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.displayedCrew) { member in
                            CrewMemberRow(member: member)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
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
            VStack(spacing: 8) {
                Text(title)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(isSelected ? Color(hex: "#8B5CF6") : Color(hex: "#666666"))
                
                Rectangle()
                    .fill(isSelected ? Color(hex: "#8B5CF6") : Color.clear)
                    .frame(height: 3)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

struct ScoreCard: View {
    let label: String
    let score: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Circle()
                    .fill(color)
                    .frame(width: 8, height: 8)
                
                Text(label)
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color(hex: "#666666"))
            }
            
            Text(score)
                .font(.custom("Nunito-Bold", size: 24))
                .foregroundColor(Color(hex: "#1A1A1A"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
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
                    .frame(width: 100, alignment: .leading)
                
                Text(value)
                    .font(.custom("Inter-Regular", size: 14))
                    .foregroundColor(Color(hex: "#1A1A1A"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            
            Divider()
                .padding(.leading, 128)
        }
    }
}

struct CastMemberRow: View {
    let member: CastMember
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            if let profileURL = member.profileURL {
                AsyncImage(url: profileURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle()
                        .fill(Color(hex: "#E0E0E0"))
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color(hex: "#E0E0E0"))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(hex: "#999999"))
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color(hex: "#1A1A1A"))
                
                Text(member.character)
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color(hex: "#666666"))
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct CrewMemberRow: View {
    let member: CrewMember
    
    var body: some View {
        HStack(spacing: 12) {
            // Profile Image
            if let profileURL = member.profileURL {
                AsyncImage(url: profileURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Circle()
                        .fill(Color(hex: "#E0E0E0"))
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color(hex: "#E0E0E0"))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(hex: "#999999"))
                    )
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color(hex: "#1A1A1A"))
                
                Text(member.job)
                    .font(.custom("Inter-Regular", size: 13))
                    .foregroundColor(Color(hex: "#666666"))
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Color Extension
// Note: Color hex extension already exists in Color+Hex.swift

// MARK: - Previews

#Preview("Normal") {
    MoviePageView(movieId: 550)
}

#Preview("With Mock Data") {
    let viewModel = MovieDetailViewModel.mock()
    return MoviePageView(movieId: 550)
}
