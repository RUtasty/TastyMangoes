//
//  CustomIcons.swift
//  TastyMangoes
//
//  Created to match Figma designs - 11/14/25 10:26pm
//

import SwiftUI

// MARK: - Mango Logo Icon Component (matches Figma Icon / Mango Logo Color)
struct MangoLogoIcon: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            // Stem/Leaf part (green)
            Path { path in
                path.move(to: CGPoint(x: size * 0.4167, y: size * 0.0417))
                path.addCurve(
                    to: CGPoint(x: size * 0.6667, y: size * 0.4167),
                    control1: CGPoint(x: size * 0.5417, y: size * 0.0417),
                    control2: CGPoint(x: size * 0.6667, y: size * 0.2083)
                )
                path.addCurve(
                    to: CGPoint(x: size * 0.4167, y: size * 0.0417),
                    control1: CGPoint(x: size * 0.6667, y: size * 0.2917),
                    control2: CGPoint(x: size * 0.5417, y: size * 0.1667)
                )
            }
            .fill(Color(hex: "#648d00"))
            
            // Mango body (yellow/orange gradient area)
            Path { path in
                path.move(to: CGPoint(x: size * 0.2917, y: size * 0.2917))
                path.addCurve(
                    to: CGPoint(x: size * 0.8333, y: size * 0.7083),
                    control1: CGPoint(x: size * 0.2917, y: size * 0.5417),
                    control2: CGPoint(x: size * 0.5417, y: size * 0.7083)
                )
                path.addCurve(
                    to: CGPoint(x: size * 0.2917, y: size * 0.2917),
                    control1: CGPoint(x: size * 0.75, y: size * 0.625),
                    control2: CGPoint(x: size * 0.4167, y: size * 0.4167)
                )
            }
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "#FFC966"),
                        Color(hex: "#FF9933")
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .frame(width: size, height: size)
    }
}

// MARK: - AI Filled Icon Component (matches Figma Icon / AI Filled)
struct AIFilledIcon: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            // Brain/chip icon shape
            Path { path in
                // Outer circuit-like shape
                path.move(to: CGPoint(x: size * 0.1354, y: size * 0.1146))
                
                // Top left corner
                path.addLine(to: CGPoint(x: size * 0.3, y: size * 0.1146))
                path.addCurve(
                    to: CGPoint(x: size * 0.35, y: size * 0.15),
                    control1: CGPoint(x: size * 0.3, y: size * 0.1146),
                    control2: CGPoint(x: size * 0.33, y: size * 0.125)
                )
                
                // Top right corner
                path.addLine(to: CGPoint(x: size * 0.7, y: size * 0.15))
                path.addCurve(
                    to: CGPoint(x: size * 0.8646, y: size * 0.1146),
                    control1: CGPoint(x: size * 0.75, y: size * 0.125),
                    control2: CGPoint(x: size * 0.8646, y: size * 0.1146)
                )
                
                // Right side
                path.addLine(to: CGPoint(x: size * 0.8646, y: size * 0.5))
                
                // Bottom right corner
                path.addCurve(
                    to: CGPoint(x: size * 0.7, y: size * 0.85),
                    control1: CGPoint(x: size * 0.8646, y: size * 0.7),
                    control2: CGPoint(x: size * 0.8, y: size * 0.8)
                )
                
                // Bottom left corner
                path.addLine(to: CGPoint(x: size * 0.3, y: size * 0.85))
                path.addCurve(
                    to: CGPoint(x: size * 0.1354, y: size * 0.5),
                    control1: CGPoint(x: size * 0.2, y: size * 0.8),
                    control2: CGPoint(x: size * 0.1354, y: size * 0.7)
                )
                
                // Close path
                path.addLine(to: CGPoint(x: size * 0.1354, y: size * 0.1146))
            }
            .fill(Color(hex: "#FEA500"))
            
            // Inner circuit details
            Circle()
                .fill(Color(hex: "#FEA500").opacity(0.3))
                .frame(width: size * 0.25, height: size * 0.25)
                .offset(x: -size * 0.1, y: size * 0.05)
            
            Circle()
                .fill(Color(hex: "#FEA500").opacity(0.3))
                .frame(width: size * 0.25, height: size * 0.25)
                .offset(x: size * 0.1, y: -size * 0.05)
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Preview for Testing
#Preview("Icons") {
    VStack(spacing: 20) {
        HStack(spacing: 20) {
            VStack {
                MangoLogoIcon(size: 16.667)
                Text("Mango Logo")
                    .font(.caption)
            }
            
            VStack {
                AIFilledIcon(size: 20)
                Text("AI Icon")
                    .font(.caption)
            }
        }
        
        // Show in context similar to movie page
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    MangoLogoIcon(size: 16.667)
                    Text("Tasty Score")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                }
                Text("64%")
                    .font(.custom("Nunito-Bold", size: 20))
                    .foregroundColor(Color(hex: "#1a1a1a"))
            }
            
            Rectangle()
                .fill(Color(hex: "#ececec"))
                .frame(width: 1, height: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 2) {
                    AIFilledIcon(size: 20)
                    Text("AI Score")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color(hex: "#666666"))
                }
                Text("5.9")
                    .font(.custom("Nunito-Bold", size: 20))
                    .foregroundColor(Color(hex: "#1a1a1a"))
            }
        }
        .padding()
        .background(Color.white)
    }
}
