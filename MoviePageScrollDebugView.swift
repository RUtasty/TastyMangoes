//  MoviePageScrollDebugView.swift
//  TastyMangoes
//
//  Created automatically by Cursor Assistant
//  Created on: 2025-11-16 at 00:18
//  Notes: Debug view to test vertical scrolling behavior

import SwiftUI

struct MoviePageScrollDebugView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Fake header rectangle
                Rectangle()
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 260)
                    .overlay(
                        Text("Fake Header")
                            .font(.title)
                            .foregroundColor(.white)
                    )
                
                // Fake tabs row
                HStack(spacing: 0) {
                    ForEach(["Overview", "Cast", "Crew"], id: \.self) { tab in
                        Text(tab)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                    }
                }
                .frame(height: 50)
                
                // Big block of dummy content
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(0..<20) { index in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Section \(index + 1)")
                                .font(.title2)
                                .bold()
                            
                            Text("This is dummy content to make the view taller than the screen. " +
                                 "If scrolling works, you should be able to drag up and down to see all sections. " +
                                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
                                 "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .font(.body)
                            
                            Rectangle()
                                .fill(Color.green.opacity(0.3))
                                .frame(height: 100)
                                .cornerRadius(8)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                }
                .padding()
            }
        }
        .background(Color(hex: "#fdfdfd"))
    }
}

#Preview("Scroll Debug") {
    MoviePageScrollDebugView()
}

