//
//  TMDBConfig.swift
//  TastyMangoes
//
//  Created by Claude on 11/13/25 at 8:48 PM
//

import Foundation

enum TMDBConfig {
    // API Configuration
    static let apiKey = "a97bed9d1924e96fed6fd3f449d79936"
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p"
    
    // Image Sizes
    enum ImageSize: String {
        case poster_small = "w185"
        case poster_medium = "w342"
        case poster_large = "w500"
        case poster_original = "original"
        
        case backdrop_small = "w300"
        case backdrop_medium = "w780"
        case backdrop_large = "w1280"
        case backdrop_original = "original_backdrop"
        
        case profile_small = "w45"
        case profile_medium = "w185_profile"
        case profile_large = "h632"
        
        var path: String {
            switch self {
            case .backdrop_original:
                return "/original"
            case .profile_medium:
                return "/w185"
            default:
                return "/\(self.rawValue)"
            }
        }
    }
    
    // Build image URL
    static func imageURL(path: String, size: ImageSize = .poster_medium) -> URL? {
        guard !path.isEmpty else { return nil }
        let cleanPath = path.hasPrefix("/") ? path : "/\(path)"
        return URL(string: "\(imageBaseURL)\(size.path)\(cleanPath)")
    }
}
