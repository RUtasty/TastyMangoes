//
//  SearchMovieCard.swift
//  TastyMangoes
//
//  Created by ChatGPT on 2025-11-17 at 23:59 (America/Los_Angeles).
//  This file was written entirely by ChatGPT.
//
//  Card used in AddMoviesToListView search results. It is intentionally
//  based on the lightweight Tasty Mangoes `Movie` model, not `MovieDetail`.
//

import SwiftUI

struct SearchMovieCard: View {
    let movie: Movie   // Your Tasty Mangoes Movie model
    
    var body: some View {
        HStack(spacing: 16) {
            // Uses your MoviePosterImage helper from MoviePosterImage.swift
            MoviePosterImage(
                posterURL: movie.posterImageURL,
                width: 70,
                height: 105
            )
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 6) {
                // Title
                Text(movie.title)
                    .font(.custom("Nunito-Bold", size: 16))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .lineLimit(2)
                
                // Year / release info
                if let release = movie.releaseDate, !release.isEmpty {
                    Text(release)
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color(hex: "#666666"))
                        .lineLimit(1)
                } else {
                    Text(String(movie.year))
                        .font(.custom("Inter-Regular", size: 13))
                        .foregroundColor(Color(hex: "#666666"))
                }
                
                // AI score if available
                if let aiScore = movie.aiScore {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color(hex: "#FEA500"))
                            .font(.system(size: 14))
                        
                        Text(String(format: "%.1f", aiScore))
                            .font(.custom("Inter-SemiBold", size: 13))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                    }
                }
            }
            
            Spacer()
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
}
