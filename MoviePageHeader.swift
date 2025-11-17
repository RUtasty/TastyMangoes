//  MoviePageHeader.swift
//  TastyMangoes
//
//  Created from Figma Design - Movie Page Header Component
//  Last updated by Cursor Agent on 2025-11-16 at 00:42
//

import SwiftUI

struct MoviePageHeader: View {
    // MARK: - Properties
    
    let backdropURL: URL?
    let posterURL: URL?
    let trailerDuration: String?
    let tastyScore: Double?
    let aiScore: Double?
    let onPlayTrailer: (() -> Void)?
    
    // MARK: - Design Tokens (from Figma variables)
    
    private let cornerRadiusM: CGFloat = 8
    private let trailerHeight: CGFloat = 193
    private let posterWidth: CGFloat = 84
    private let posterHeight: CGFloat = 124
    private let posterOverlap: CGFloat = 58
    private let horizontalPadding: CGFloat = 16
    private let posterHorizontalPadding: CGFloat = 28
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 0) {
            // Trailer/Backdrop Section
            trailerSection
            
            // Poster and Scores Section (overlapping trailer)
            posterAndScoresSection
        }
    }
    
    // MARK: - Trailer Section
    
    private var trailerSection: some View {
        ZStack(alignment: .topLeading) {
            // Backdrop Image
            if let backdropURL = backdropURL {
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
                .frame(height: trailerHeight)
                .clipped()
            } else {
                Rectangle()
                    .fill(Color(hex: "#1a1a1a"))
                    .frame(height: trailerHeight)
            }
            
            // Play Trailer Button
            playTrailerButton
        }
        .frame(height: trailerHeight)
        .cornerRadius(cornerRadiusM)
        .padding(.horizontal, horizontalPadding)
    }
    
    // MARK: - Play Trailer Button
    
    private var playTrailerButton: some View {
        HStack(spacing: 6) {
            Image(systemName: "play.fill")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "#f3f3f3"))
            
            Text("Play Trailer")
                .font(.custom("Nunito-Bold", size: 12))
                .foregroundColor(Color(hex: "#f3f3f3"))
            
            if let duration = trailerDuration {
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
            onPlayTrailer?()
        }
    }
    
    // MARK: - Poster and Scores Section
    
    private var posterAndScoresSection: some View {
        HStack(alignment: .bottom, spacing: 16) {
            // Poster Image
            posterImage
            
            // Scores Section
            scoresSection
            
            Spacer()
        }
        .padding(.horizontal, posterHorizontalPadding)
        .offset(y: -posterOverlap)
    }
    
    // MARK: - Poster Image
    
    private var posterImage: some View {
        Group {
            if let posterURL = posterURL {
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
            } else {
                Rectangle()
                    .fill(Color(hex: "#333333"))
            }
        }
        .frame(width: posterWidth, height: posterHeight)
        .cornerRadius(cornerRadiusM)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Scores Section
    
    private var scoresSection: some View {
        HStack(spacing: 0) {
            // Tasty Score (always shown with colored icon)
            TastyScoreView(tastyScore: tastyScore)
                .frame(maxWidth: .infinity)
            
            // Divider
            Rectangle()
                .fill(Color(hex: "#ececec"))
                .frame(width: 1, height: 40)
                .padding(.horizontal, 12)
            
            // AI Score (always shown with colored icon)
            AIScoreView(aiScore: aiScore)
                .frame(maxWidth: .infinity)
        }
        .padding(.bottom, 8)
    }
}

// MARK: - Tasty Score View Component

struct TastyScoreView: View {
    let tastyScore: Double?
    
    var body: some View {
        VStack(spacing: 2) {
            // Title Row (never wrap)
            HStack(spacing: 4) {
                Image("TastyScoreIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                
                Text("Tasty Score")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color(hex: "#666666"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                
                Image(systemName: "info.circle")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#666666"))
            }
            
            // Value (N/A or percentage) - centered
            Text(displayValue)
                .font(.custom("Nunito-Bold", size: 20))
                .monospacedDigit()
                .foregroundColor(Color(hex: "#1a1a1a"))
                .lineLimit(1)
                .minimumScaleFactor(0.95)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var displayValue: String {
        if let score = tastyScore {
            return "\(Int(score * 100))%"
        } else {
            return "N/A"
        }
    }
}

// MARK: - AI Score View Component

struct AIScoreView: View {
    let aiScore: Double?
    
    var body: some View {
        VStack(spacing: 2) {
            // Title Row (never wrap)
            HStack(spacing: 4) {
                Image("AIScoreIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
                
                Text("AI Score")
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(Color(hex: "#666666"))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                
                Image(systemName: "info.circle")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#666666"))
            }
            
            // Value (N/A or score with one decimal) - centered
            Text(displayValue)
                .font(.custom("Nunito-Bold", size: 20))
                .monospacedDigit()
                .foregroundColor(Color(hex: "#1a1a1a"))
                .lineLimit(1)
                .minimumScaleFactor(0.95)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    private var displayValue: String {
        if let score = aiScore {
            return String(format: "%.1f", score)
        } else {
            return "N/A"
        }
    }
}

// MARK: - Preview

#Preview("Movie Page Header") {
    ScrollView {
        VStack(spacing: 0) {
            MoviePageHeader(
                backdropURL: URL(string: "https://image.tmdb.org/t/p/original/hZkgoQYus5vegHoetLkCJzb17zJ.jpg"),
                posterURL: URL(string: "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"),
                trailerDuration: "4:20",
                tastyScore: 0.64, // 64% (stored as 0.0-1.0)
                aiScore: 5.9, // 0-10 scale
                onPlayTrailer: {
                    print("Play trailer tapped")
                }
            )
            
            // Spacer to show the overlap effect
            Spacer()
                .frame(height: 100)
        }
    }
    .background(Color(hex: "#fdfdfd"))
}

#Preview("Without Scores (N/A)") {
    ScrollView {
        VStack(spacing: 0) {
            MoviePageHeader(
                backdropURL: URL(string: "https://image.tmdb.org/t/p/original/hZkgoQYus5vegHoetLkCJzb17zJ.jpg"),
                posterURL: URL(string: "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"),
                trailerDuration: nil,
                tastyScore: nil,
                aiScore: nil,
                onPlayTrailer: nil
            )
            
            Spacer()
                .frame(height: 100)
        }
    }
    .background(Color(hex: "#fdfdfd"))
}

#Preview("With AI Score Only") {
    ScrollView {
        VStack(spacing: 0) {
            MoviePageHeader(
                backdropURL: URL(string: "https://image.tmdb.org/t/p/original/hZkgoQYus5vegHoetLkCJzb17zJ.jpg"),
                posterURL: URL(string: "https://image.tmdb.org/t/p/w500/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"),
                trailerDuration: "2:30",
                tastyScore: nil,
                aiScore: 8.4,
                onPlayTrailer: {
                    print("Play trailer tapped")
                }
            )
            
            Spacer()
                .frame(height: 100)
        }
    }
    .background(Color(hex: "#fdfdfd"))
}

