//
//  GameReadyView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct GameReadyView: View {
    @State private var readyToPlay = false // if true we show the PlayerInputView, else show the homescreen
    @State private var animateBubble = false
    
    var body: some View {
        if readyToPlay { // goes in if this is true -> is triggered when the player clicks on Play button
            PlayerInputView()
        } else {
            NavigationView {
                ZStack {
                    // Gradient Background
                    LinearGradient(
                        gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.2)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .blur(radius: 10)
                    .ignoresSafeArea()
                    
                    VStack(spacing: 40) {
                        HStack(spacing: 10) {
                            Text("Bubble Pop")
                                .font(.system(size: 50, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                                .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            // Floating Bubble Animation
                            Circle()
                                .fill(Color.pink.opacity(0.8))
                                .frame(width: 50, height: 50)
                                .scaleEffect(animateBubble ? 1.2 : 1)
                                .offset(y: animateBubble ? -15 : 15)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animateBubble)
                                .onAppear {
                                    animateBubble = true
                                }
                        }
                        
                        Text("Welcome to the world of Bubbles!")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        // Takes user to the PlayerInputView
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                readyToPlay = true
                            }
                        }) {
                            Text("Play")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(Color.pink)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                        }
                        // Takes user to the ScoreView to show top players
                        NavigationLink(destination: ScoreView().environmentObject(PlayerViewModel())) {
                            Text("Scoreboard")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 15)
                                .background(Color.pink)
                                .cornerRadius(20)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                }
            }
        }}
}

#Preview {
    GameReadyView()
}
