//
//  SearchHistoryItem.swift
//  TastyMangoes
//
//  Created by ChatGPT on 2025-11-17 at 23:50 (America/Los_Angeles).
//  This file was written entirely by ChatGPT.
//

import SwiftUI

struct SearchHistoryItem: View {
    let query: String
    let onTap: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "clock")
                .foregroundColor(Color(hex: "#999999"))
                .font(.system(size: 16))
            
            Text(query)
                .font(.custom("Inter-Regular", size: 15))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .lineLimit(1)
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .foregroundColor(Color(hex: "#bbbbbb"))
                    .font(.system(size: 14, weight: .semibold))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .background(Color.white)
        .contentShape(Rectangle())
        .onTapGesture { onTap() }
    }
}
