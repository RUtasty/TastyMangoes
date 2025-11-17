//
//  SearchComponents.swift
//  Tasty Mangoes
//
//  Created by Claude on 11/13/25.
//

import SwiftUI

// MARK: - Selectable Platform Card

struct SelectablePlatformCard: View {
    let name: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color(hex: "#ffedcc") : Color.white)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 0)
                    .overlay(
                        Text(name)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(4)
                    )
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(hex: "#FEA500"))
                        .font(.system(size: 16))
                        .offset(x: -4, y: 4)
                }
            }
        }
    }
}

// MARK: - Selectable Category Card

struct SelectableCategoryCard: View {
    let category: CategoryItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                HStack(spacing: 16) {
                    Text(category.icon)
                        .font(.system(size: 24))
                    
                    Text(category.name)
                        .font(.custom("Nunito-SemiBold", size: 16))
                        .foregroundColor(Color(hex: "#333333"))
                    
                    Spacer()
                }
                .padding(16)
                .background(isSelected ? Color(hex: "#ffedcc") : Color.white)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 0)
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(Color(hex: "#FEA500"))
                        .font(.system(size: 16))
                        .offset(x: -4, y: 4)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Selectable Category Section

struct SelectableCategorySection: View {
    let title: String
    let categories: [CategoryItem]
    @Binding var selectedCategories: Set<String>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.custom("Nunito-SemiBold", size: 14))
                .foregroundColor(Color(hex: "#999999"))
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 4),
                GridItem(.flexible(), spacing: 4)
            ], spacing: 4) {
                ForEach(categories) { category in
                    SelectableCategoryCard(
                        category: category,
                        isSelected: selectedCategories.contains(category.name)
                    ) {
                        if selectedCategories.contains(category.name) {
                            selectedCategories.remove(category.name)
                        } else {
                            selectedCategories.insert(category.name)
                        }
                    }
                }
            }
        }
    }
}
