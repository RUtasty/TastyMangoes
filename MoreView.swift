//
//  MoreView.swift
//  TastyMangoes
//
//  Created by ChatGPT on 2025-11-18 at 02:08 (America/Los_Angeles).
//  This file was written entirely by ChatGPT.
//
//  Placeholder “More” tab content. Replace with your real settings/profile
//  screen later.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        ZStack {
            Color(red: 253/255, green: 253/255, blue: 253/255)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("More")
                    .font(.system(size: 28, weight: .bold))

                Text("This is a placeholder screen for the More tab.\nYou can add settings, profile, and other options here.")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
    }
}

#Preview {
    MoreView()
}
