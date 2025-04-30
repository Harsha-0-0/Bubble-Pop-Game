//
//  GameOverView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 23/04/25.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject private var viewModel: PlayerViewModel
    var score: Int
    var playerName: String
    var time: Int
    var initialTime: Int
    var numberOfBubbles: Int
    
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .blur(radius: 10)
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                Text("Game Over")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                
                // Player score
                VStack(spacing: 8) {
                    Text(playerName)
                        .font(.title.bold())
                        .foregroundColor(.black)
                        .padding(8)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    Text("Your Score")
                        .font(.title3)
                        .foregroundColor(.black)
                    
                    Text("\(score)")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding()
                .background(.pink.opacity(0.5))
                .cornerRadius(12)
                .padding(.top, 8)
                // Showing the top players here
                ScoreView()
                    .frame(height: 360)
                    .cornerRadius(12)
                
                HStack(spacing: 20) {
                    // taking user to the game again with the same player name and time and number of bubbles values
                    NavigationLink(
                        // we send the initial time set by the user on PlayerInputView to the time
                        destination: GameView(time: initialTime, playerName: playerName, initialTime: initialTime, numberOfBubbles: numberOfBubbles)
                            .environmentObject(BubbleViewModel())
                            .id(UUID())
                            .navigationBarBackButtonHidden(true)
                    ) {
                        Text("Play Again")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.pink)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .scaleEffect(1.1)
                            .animation(.spring(), value: 1)
                    }
                    // taking the user to the home screen
                    NavigationLink(
                        destination: GameReadyView()
                            .id(UUID())
                            .navigationBarBackButtonHidden(true)
                    ) {
                        Text("Home")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 12)
                            .background(Color.pink)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .scaleEffect(1.1)
                            .animation(.spring(), value: 1)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true) // don't want to display the back button
        .onAppear {
            addNewPlayer() // when player exits the game and comes to the GameOverView, we add them with the existing players
        }
    }
    // sending to the PlayerViewModel
    private func addNewPlayer() {
        let player = Player(name: playerName, score: score)
        viewModel.addNewPlayer(player: player)
    }
}

#Preview {
    GameOverView(score: 50, playerName: "Belacopia magic", time: 9, initialTime: 15, numberOfBubbles: 15)
        .environmentObject(PlayerViewModel())
}
