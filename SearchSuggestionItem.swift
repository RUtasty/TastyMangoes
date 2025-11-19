//
//  SearchSuggestionItem.swift
//  TastyMangoes
//
//  Created by ChatGPT on 2025-11-17 at 23:50 (America/Los_Angeles).
//  This file was written entirely by ChatGPT.
//

import SwiftUI

struct SearchSuggestionItem: View {
    let suggestion: String
    let query: String
    let onTap: () -> Void
    
    private var highlightedText: AttributedString {
        var attr = AttributedString(suggestion)
        if let range = attr.range(of: query, options: .caseInsensitive) {
            attr[range].foregroundColor = Color(hex: "#FEA500")
            attr[range].font = .custom("Inter-SemiBold", size: 15)
        }
        return attr
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color(hex: "#999999"))
                .font(.system(size: 16))
            
            Text(highlightedText)
                .foregroundStyle(Color(hex: "#1a1a1a"))
                .font(.custom("Inter-Regular", size: 15))
                .lineLimit(1)
            
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .background(Color.white)
        .contentShape(Rectangle())
        .onTapGesture { onTap() }
    }
}
