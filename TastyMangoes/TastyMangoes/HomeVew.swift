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
                    // Tasty Mangoes Logo
                    HStack(spacing: 0) {
                        Text("Tasty")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 255/255, green: 165/255, blue: 0/255))
                        Text("Mangoes")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(Color(red: 255/255, green: 140/255, blue: 0/255))
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
                
                // Welcome message section
                VStack(spacing: 12) {
                    Text("Welcome\nto Tasty Mangoes 🥭")
                        .font(.custom("Nunito-Bold", size: 32))
                        .lineSpacing(8)
                        .foregroundColor(Color(red: 26/255, green: 26/255, blue: 26/255))
                        .multilineTextAlignment(.center)
                    
                    Text("We're just getting started. Soon you'll see movie suggestions, trending picks, and more right here!")
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                }
                .padding(.horizontal, 16)
                
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
