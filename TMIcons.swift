//
//  TMIcons.swift
//  Tasty Mangoes Component Library
//
//  Created: 2025-01-15 07:30 UTC
//  Complete icon system from Figma with 90+ icons
//  Extracted from Figma Component Library
//

import SwiftUI

// MARK: - Icon Protocol
protocol TMIcon: View {
    var size: CGFloat { get }
    var color: Color { get }
}

// MARK: - Navigation Icons
struct TMHomeIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "house")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMHomeFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "house.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMListIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "list.bullet")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMListFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "list.bullet.rectangle.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSearchIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "magnifyingglass")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSearchFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "magnifyingglass.circle.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMUserIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "person")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMUserFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "person.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMenuDotsIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "ellipsis")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMenuDotsVerticalIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "ellipsis")
            .font(.system(size: size))
            .foregroundColor(color)
            .rotationEffect(.degrees(90))
    }
}

// MARK: - Arrow Icons
struct TMArrowLeftIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.left")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMArrowRightIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.right")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMArrowUpIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.up")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMArrowDownIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.down")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMAltArrowLeftIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMAltArrowRightIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMAltArrowUpIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "chevron.up")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMAltArrowDownIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "chevron.down")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSortVerticalIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.up.arrow.down")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMRefreshIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.clockwise")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

// MARK: - Category/Genre Icons
struct TMDetectiveIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "theatermasks")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSwordIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "chevron.up.chevron.down")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMagicStickIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "wand.and.stars")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMusicNotesIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "music.note.list")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMCatIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "cat.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMRocketIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "paperplane.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMHeartsIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMasksIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "theatermasks")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMCastleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "building.columns.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMasksDramaIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "theatermasks.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSportIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "sportscourt.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMGlobusIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "globe")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMGhostIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "moon.stars.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSofaIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "sofa.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMCowboyHatIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "triangle.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPoliceCarIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "car.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMHandFistIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "hand.raised.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMReelIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "film.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMQuestionCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "questionmark.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

// MARK: - Essential UI Icons
struct TMCloseIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "xmark")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPlusIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "plus")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMReorderIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPlusCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "plus.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMCheckCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "checkmark.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMSettingsIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "gearshape")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMMicrophoneIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "mic")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMShareIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "square.and.arrow.up")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMShare2Icon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrowshape.turn.up.right")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMShare3Icon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.turn.up.forward.iphone")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMInfoCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "info.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMReviewIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "text.bubble")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPenIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "pencil")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMEditIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "pencil.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMDeleteIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "trash")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPlayIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "play.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMListMoveIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "arrow.up.arrow.down")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMWidgetIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "square.grid.2x2")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMListEditIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "list.bullet.rectangle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMCopyIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "doc.on.doc")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMDangerCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "exclamationmark.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPlayCircleIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "play.circle")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMHistoryIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "clock.arrow.circlepath")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

// MARK: - Status & Rating Icons
struct TMAIIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "sparkles")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMAIFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "sparkles")
            .font(.system(size: size, weight: .bold))
            .foregroundColor(color)
    }
}

struct TMPopcornIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "popcorn")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMPopcornFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "popcorn.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMListAddIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "text.badge.plus")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMEyeIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "eye")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMEyeFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "eye.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMLikeIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "hand.thumbsup")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMLikeFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "hand.thumbsup.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMDislikeIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "hand.thumbsdown")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMDislikeFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "hand.thumbsdown.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMStarIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "star")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

struct TMStarFilledIcon: TMIcon {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Image(systemName: "star.fill")
            .font(.system(size: size))
            .foregroundColor(color)
    }
}

// MARK: - Mango Logo Icons
struct TMMangoIcon: View {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        // Custom mango icon - using placeholder
        Circle()
            .stroke(color, lineWidth: 2)
            .frame(width: size, height: size)
            .overlay(
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: size * 0.6, height: size * 0.6)
            )
    }
}

struct TMMangoFilledIcon: View {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
    }
}

struct TMMangoLogoIcon: View {
    var size: CGFloat = 24
    var color: Color = .black
    
    var body: some View {
        // Mango logo with leaf
        ZStack {
            Circle()
                .fill(color)
                .frame(width: size * 0.7, height: size * 0.7)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(color)
                .frame(width: size * 0.3, height: size * 0.4)
                .offset(x: size * 0.25, y: -size * 0.25)
                .rotationEffect(.degrees(-30))
        }
        .frame(width: size, height: size)
    }
}

struct TMMangoLogoColorIcon: View {
    var size: CGFloat = 24
    
    var body: some View {
        // Colored mango logo
        ZStack {
            Circle()
                .fill(Color(red: 254/255, green: 165/255, blue: 0))
                .frame(width: size * 0.7, height: size * 0.7)
            
            RoundedRectangle(cornerRadius: 2)
                .fill(Color(red: 100/255, green: 141/255, blue: 0))
                .frame(width: size * 0.3, height: size * 0.4)
                .offset(x: size * 0.25, y: -size * 0.25)
                .rotationEffect(.degrees(-30))
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Icon Helper Extensions
extension View {
    func iconSize(_ size: CGFloat) -> some View {
        self.frame(width: size, height: size)
    }
    
    func iconColor(_ color: Color) -> some View {
        self.foregroundColor(color)
    }
}

// MARK: - Preview
#Preview("All Icons") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            // Navigation Icons
            VStack(alignment: .leading, spacing: 12) {
                Text("Navigation Icons")
                    .font(.headline)
                HStack(spacing: 16) {
                    TMHomeIcon()
                    TMHomeFilledIcon()
                    TMListIcon()
                    TMSearchIcon()
                    TMUserIcon()
                    TMMenuDotsIcon()
                }
            }
            
            // Arrow Icons
            VStack(alignment: .leading, spacing: 12) {
                Text("Arrow Icons")
                    .font(.headline)
                HStack(spacing: 16) {
                    TMArrowLeftIcon()
                    TMArrowRightIcon()
                    TMArrowUpIcon()
                    TMArrowDownIcon()
                    TMAltArrowLeftIcon()
                    TMAltArrowRightIcon()
                    TMSortVerticalIcon()
                    TMRefreshIcon()
                }
            }
            
            // Category Icons
            VStack(alignment: .leading, spacing: 12) {
                Text("Category/Genre Icons")
                    .font(.headline)
                HStack(spacing: 16) {
                    TMDetectiveIcon()
                    TMMagicStickIcon()
                    TMMusicNotesIcon()
                    TMRocketIcon()
                    TMHeartsIcon()
                    TMSportIcon()
                }
            }
            
            // UI Icons
            VStack(alignment: .leading, spacing: 12) {
                Text("Essential UI Icons")
                    .font(.headline)
                HStack(spacing: 16) {
                    TMCloseIcon()
                    TMPlusIcon()
                    TMCheckCircleIcon()
                    TMSettingsIcon()
                    TMShareIcon()
                    TMEditIcon()
                    TMDeleteIcon()
                    TMPlayIcon()
                }
            }
            
            // Status & Rating
            VStack(alignment: .leading, spacing: 12) {
                Text("Status & Rating Icons")
                    .font(.headline)
                HStack(spacing: 16) {
                    TMAIIcon()
                    TMPopcornIcon()
                    TMEyeIcon()
                    TMLikeIcon()
                    TMDislikeIcon()
                    TMStarIcon()
                    TMMangoLogoColorIcon()
                }
            }
        }
        .padding()
    }
}
