import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Background color
            Color(red: 253/255, green: 253/255, blue: 253/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top section with logo and avatar
                HStack {
                    // Tasty Mangoes Logo - stacked vertically with logo image
                    VStack(alignment: .leading, spacing: 0) {
                        // Logo image/icon (if there's a separate logo image, it would go here)
                        // For now, using the text logo
                        HStack(spacing: 0) {
                            Text("Tasty")
                                .font(.custom("Nunito-Bold", size: 32))
                                .foregroundColor(Color(hex: "#FFA500"))
                            HStack(spacing: 0) {
                                Text("Mang")
                                    .font(.custom("Nunito-Bold", size: 32))
                                    .foregroundColor(Color(hex: "#FF8C00"))
                                // Mango icon replacing the "o"
                                MangoLogoIcon(size: 20)
                                    .offset(y: -2)
                                Text("es")
                                    .font(.custom("Nunito-Bold", size: 32))
                                    .foregroundColor(Color(hex: "#FF8C00"))
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Avatar
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        )
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                
                Spacer()
                
                // Welcome message section - raised higher on page
                VStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Text("Welcome to Tasty Mangoes")
                            .font(.custom("Nunito-Bold", size: 32))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                        Text("🥭")
                            .font(.system(size: 24))
                    }
                    
                    Text("We're just getting started. Soon you'll see movie suggestions, trending picks, and more right here!")
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(Color(hex: "#333333"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                }
                .padding(.horizontal, 16)
                .padding(.top, -80) // Raise it up
                
                Spacer()
                
                // Safe area spacing at bottom (for tab bar)
                Color.clear
                    .frame(height: 48)
            }
        }
    }
}

#Preview {
    HomeView()
}
