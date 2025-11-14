//
//  SearchView.swift
//  TastyMangoes
//
//  Created by Claude on 11/14/25 at 9:59 AM
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var showFilters = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Header
                searchHeader
                
                // Content
                if viewModel.isSearching {
                    loadingView
                } else if let error = viewModel.error {
                    errorView(error: error)
                } else if viewModel.hasSearched && viewModel.searchResults.isEmpty {
                    emptyStateView
                } else if !viewModel.searchResults.isEmpty {
                    resultsListView
                } else {
                    popularMoviesView
                }
            }
            .background(Color(hex: "#fdfdfd"))
        }
        .task {
            // Load popular movies on launch
            await viewModel.loadPopularMovies()
        }
    }
    
    // MARK: - Search Header
    
    private var searchHeader: some View {
        VStack(spacing: 16) {
            // Title
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Find Your Movie 🎬")
                        .font(.custom("Nunito-Bold", size: 28))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                    
                    Text("Type a title or pick a genre")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    Text("to discover the film you're looking for.")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                }
                
                Spacer()
            }
            
            // Search Bar
            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(hex: "#666666"))
                    
                    TextField("Searching by name...", text: $viewModel.searchQuery)
                        .font(.custom("Inter-Regular", size: 16))
                        .onChange(of: viewModel.searchQuery) { _, _ in
                            viewModel.search()
                        }
                    
                    if !viewModel.searchQuery.isEmpty {
                        Button(action: {
                            viewModel.clearSearch()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(hex: "#999999"))
                        }
                    }
                    
                    Image(systemName: "mic.fill")
                        .foregroundColor(Color(hex: "#666666"))
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(12)
                
                Button(action: {
                    showFilters.toggle()
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundColor(Color(hex: "#1a1a1a"))
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [Color(hex: "#FFD60A"), Color(hex: "#FFA500")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    // MARK: - Loading View
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Searching movies...")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Error View
    
    private func errorView(error: TMDBError) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(Color(hex: "#FF6B6B"))
            
            Text("Oops!")
                .font(.custom("Nunito-Bold", size: 24))
                .foregroundColor(Color(hex: "#1a1a1a"))
            
            Text(error.localizedDescription ?? "Something went wrong")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: {
                Task {
                    await viewModel.loadPopularMovies()
                }
            }) {
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
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "film")
                .font(.system(size: 64))
                .foregroundColor(Color(hex: "#CCCCCC"))
            
            Text("No movies found")
                .font(.custom("Nunito-Bold", size: 24))
                .foregroundColor(Color(hex: "#1a1a1a"))
            
            Text("Try a different search term")
                .font(.custom("Inter-Regular", size: 16))
                .foregroundColor(Color(hex: "#666666"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Results List
    
    private var resultsListView: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Results count
                HStack {
                    Text("\(viewModel.searchResults.count) results found")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                // Movie cards
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.searchResults) { movie in
                        NavigationLink(destination: MoviePageView(movieId: movie.id)) {
                            SearchMovieCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
    
    // MARK: - Popular Movies View
    
    private var popularMoviesView: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Popular Movies")
                        .font(.custom("Nunito-Bold", size: 20))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                    
                    Spacer()
                    
                    Button(action: {
                        Task {
                            await viewModel.loadTrendingMovies()
                        }
                    }) {
                        Text("Trending")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color(hex: "#8B5CF6"))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                // Movie cards
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.searchResults) { movie in
                        NavigationLink(destination: MoviePageView(movieId: movie.id)) {
                            SearchMovieCard(movie: movie)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

// MARK: - Search Movie Card

struct SearchMovieCard: View {
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 12) {
            // Poster with our custom component
            MoviePosterImage(
                posterURL: movie.posterImageURL,
                width: 80,
                height: 120,
                cornerRadius: 8
            )
            
            // Info
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.custom("Nunito-Bold", size: 16))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .lineLimit(2)
                
                if movie.year > 0 {
                    Text(String(movie.year))
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(hex: "#666666"))
                }
                
                if let overview = movie.overview, !overview.isEmpty {
                    Text(overview)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color(hex: "#666666"))
                        .lineLimit(2)
                }
                
                // Rating
                if let aiScore = movie.aiScore {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#FFD60A"))
                        
                        Text(String(format: "%.1f", aiScore))
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview

#Preview {
    SearchView()
}
