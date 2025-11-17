//  CastTabView.swift
//  TastyMangoes
//
//  Created automatically by Cursor Assistant from Figma design
//  Last updated on 2025-11-16 at 00:42 (local time)
//  Notes: Removed inner ScrollView so movie page scrolls correctly
//

import SwiftUI

struct CastTabView: View {
    let cast: [CastMember]
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        Group {
            if cast.isEmpty {
                // Empty state
                VStack(spacing: 16) {
                    Image(systemName: "person.2.slash")
                        .font(.system(size: 48))
                        .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                    
                    Text("No Cast Information")
                        .font(.custom("Nunito-Bold", size: 18))
                        .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                    
                    Text("Cast information is not available for this movie")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 100)
                .padding(.horizontal, 20)
            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cast.prefix(20)) { member in
                        CastMemberCard(member: member)
                    }
                }
                .padding(20)
            }
        }
        .background(Color(red: 253/255, green: 253/255, blue: 253/255))
    }
}

// MARK: - Cast Member Card

struct CastMemberCard: View {
    let member: CastMember
    
    var body: some View {
        VStack(spacing: 8) {
            // Profile Photo
            if let profilePath = member.profilePath {
                AsyncImage(url: TMDBConfig.imageURL(path: profilePath, size: .profile_medium)) { phase in
                    switch phase {
                    case .empty:
                        profilePlaceholder
                            .overlay(
                                ProgressView()
                                    .tint(Color(red: 255/255, green: 165/255, blue: 0/255))
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        profilePlaceholder
                            .overlay(
                                Image(systemName: "person.crop.circle.badge.exclamationmark")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            )
                    @unknown default:
                        profilePlaceholder
                    }
                }
                .frame(width: 160, height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                profilePlaceholder
                    .overlay(
                        VStack(spacing: 4) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 32))
                                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            
                            Text("No Photo")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                        }
                    )
            }
            
            // Name
            Text(member.name)
                .font(.custom("Nunito-Bold", size: 14))
                .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                .lineLimit(2)
                .multilineTextAlignment(.center)
            
            // Character
            Text(member.character)
                .font(.custom("Inter-Regular", size: 12))
                .foregroundColor(Color(red: 102/255, green: 102/255, blue: 102/255))
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var profilePlaceholder: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(red: 240/255, green: 240/255, blue: 240/255))
            .frame(width: 160, height: 180)
    }
}

// MARK: - Preview

#Preview("With Cast") {
    CastTabView(cast: [
        CastMember(
            id: 1,
            name: "Keanu Reeves",
            character: "Neo",
            profilePath: "/4D0PpNI0kmP58hgrwGC3wCjxhnm.jpg",
            order: 0
        ),
        CastMember(
            id: 2,
            name: "Carrie-Anne Moss",
            character: "Trinity",
            profilePath: "/xD4jTA3KmVp5Rq3aHcymL9DUGjD.jpg",
            order: 1
        ),
        CastMember(
            id: 3,
            name: "Laurence Fishburne",
            character: "Morpheus",
            profilePath: "/8suOhUmPbfKqDQ17U9IdnMN6VFH.jpg",
            order: 2
        )
    ])
}

#Preview("Empty Cast") {
    CastTabView(cast: [])
}
