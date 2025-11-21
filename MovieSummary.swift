//  MovieSummary.swift
//  Created automatically by Cursor Assistant
//  Created on: 2025-01-15 at 14:40 (America/Los_Angeles - Pacific Time)
//  Notes: Lightweight movie summary model for search results. Compatible with Movie model for easy conversion.

import Foundation

/// Lightweight movie summary for search results
struct MovieSummary: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let year: Int
    let posterImageURL: String?
    let tastyScore: Double?
    let aiScore: Double?
    let genres: [String]
    let runtime: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, year, genres
        case posterImageURL
        case tastyScore
        case aiScore
        case runtime
        case releaseDate
    }
}

// MARK: - Conversion from Movie

extension MovieSummary {
    init(from movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.year = movie.year
        self.posterImageURL = movie.posterImageURL
        self.tastyScore = movie.tastyScore
        self.aiScore = movie.aiScore
        self.genres = movie.genres
        self.runtime = movie.runtime
        self.releaseDate = movie.releaseDate
    }
}

