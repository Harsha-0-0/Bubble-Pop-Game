//
//  GameView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 23/04/25.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject private var viewModel: BubbleViewModel
    @State var time: Int
    @State var score = 0
    @State private var lastPoppedColor: Color? = nil
    @State private var consecutiveSameColor = false
    @State var gameOver = false
    @State private var gameAreaSize: CGSize = .zero
    var playerName: String
    var initialTime: Int
    var numberOfBubbles: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if !gameOver {
            ZStack {
                //Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.4)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blur(radius: 10)
                .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    // Score, Player, Time
                    HStack(spacing: 30) {
                        VStack {
                            Text("Score")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("\(score)")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }
                        
                        VStack {
                            Text("Player")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text(playerName) // displaying playerName from the PlayerInputView
                                .font(.title2.bold())
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        
                        VStack {
                            Text("Time")
                                .font(.title2.bold())
                                .foregroundColor(.white)
                            Text("\(time)")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    .background(.pink.opacity(0.5))
                    .cornerRadius(12)
                    .padding(.top, 20)
                    
                    // Bubble Popping screen
                    // Used GeometryReader to get the screen size and make sure bubbles don't go out of screen
                    GeometryReader { geometry in
                        ZStack {
                            ForEach(viewModel.bubbles) { bubble in
                                BubbleView(bubble: bubble) { poppedBubble in
                                    popBubble(poppedBubble)
                                }
                            }
                            
                        }
                        .onAppear {
                            gameAreaSize = geometry.size
                            checkAndCreate(screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                            
                        }
                        
                    }
                    .clipped()
                }
                .padding(.horizontal)
                .onReceive(timer) { _ in
                    if time > 0 {
                        time -= 1
                        withAnimation {
                            refreshBubbles(screenWidth: gameAreaSize.width, screenHeight: gameAreaSize.height)
                        }
                    } else {
                        withAnimation {
                            viewModel.bubbles.removeAll()
                            gameOver = true
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            
        } else {
            GameOverView(score: score, playerName: playerName, time: time, initialTime: initialTime, numberOfBubbles: numberOfBubbles)
                .environmentObject(PlayerViewModel())
        }
    }
    
    // logic to add points and remove the bubble when it is tapped
    private func popBubble(_ bubble: Bubble) {
        withAnimation {
            var pointsToAdd = bubble.points
            // checking if two bubbles of same color is popped
            if let lastColor = lastPoppedColor, lastColor == bubble.color {
                consecutiveSameColor = true
                pointsToAdd = Int(round(Double(bubble.points) * 1.5))
            } else {
                consecutiveSameColor = false
            }
            lastPoppedColor = bubble.color
            score += pointsToAdd
            viewModel.removeBubble(bubble)
        }
    }
    
    private func checkAndCreate(screenWidth: CGFloat, screenHeight: CGFloat) {
        // Create bubbles based on the number of bubbles needed
        if viewModel.bubbles.count < numberOfBubbles {
            withAnimation {
                let bubblesToAdd = numberOfBubbles - viewModel.bubbles.count
                for _ in 0..<bubblesToAdd {
                    viewModel.createBubble(screenWidth: screenWidth, screenHeight: screenHeight)
                }
            }
        }
    }
    // logic to refresh bubbles on the screen randomly
    private func refreshBubbles(screenWidth: CGFloat, screenHeight: CGFloat) {
        let removalCount = Int.random(in: 0...(viewModel.bubbles.count / 3))
        for _ in 0..<removalCount {
            if let randomIndex = viewModel.bubbles.indices.randomElement() {
                viewModel.bubbles.remove(at: randomIndex)
            }
        }
        
        // Ensuring that remainingSlots is not negative
        let remainingSlots = max(0, numberOfBubbles - viewModel.bubbles.count)
        let bubblesToAdd = min(remainingSlots, Int.random(in: 0...remainingSlots))
        
        for _ in 0..<bubblesToAdd {
            viewModel.createBubble(screenWidth: screenWidth, screenHeight: screenHeight)
        }
    }
    
}

#Preview {
    GameView(time: 20, playerName: "Harsha", initialTime: 20, numberOfBubbles: 20)
        .environmentObject(BubbleViewModel())
}

