//
//  GameView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 23/04/25.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject private var viewModel: BubbleViewModel
    
    @State var score = 0
    @State var timeRemaining = 30
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var lastPoppedColor: Color? = nil
    @State private var consecutiveSameColor = false
    @State var gameOver = false
    
    var body: some View {
        if (!gameOver) {
            HStack {
                Text("Score: \(score)")
                    .font(.title)
                    .bold()
                Spacer()
                Text("Time: \(timeRemaining)")
                    .onReceive(timer) { _ in
                        if timeRemaining >= 1 {
                            timeRemaining -= 1
                        }
                        withAnimation {
                            refreshBubbles(screenWidth: UIScreen.main.bounds.width,
                                           screenHeight: UIScreen.main.bounds.height)
                        }
                    }
                    .font(.title)
                    .bold()
            }
            ZStack {
                
                
                GeometryReader { geometry in
                    ZStack {
                        ZStack {
                            ForEach(viewModel.bubbles) { bubble in
                                Circle()
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(bubble.color)
                                    .position(x: bubble.xCord, y: bubble.yCord)
                                    .transition(.opacity)
                                    .onTapGesture {
                                        popBubble(bubble)
                                    }
                                
                            }
                        }
                        .onAppear {
                            checkAndCreate(screenWidth: geometry.size.width, screenHeight: geometry.size.height)
                        }
                    }
                    .background(Color.gray)
                    .onReceive(timer) { _ in
                        if timeRemaining == 0 {
                            viewModel.bubbles.removeAll() // Remove all bubbles
                            gameOver = true
                        }
                    }
                    
                }
                
            }
            
        }
        else {
            GameOverView(score: score)
        }}
    private func popBubble(_ bubble: Bubble) {
        withAnimation {
            var pointsToAdd = bubble.points
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
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            if timeRemaining > 0 && viewModel.bubbles.count < 15 {
                withAnimation {
                    viewModel.createBubble(screenWidth: screenWidth, screenHeight: screenHeight)
                }
            } else if timeRemaining <= 0 {
                timer.invalidate()
            }
        }
    }
    private func refreshBubbles(screenWidth: CGFloat, screenHeight: CGFloat) {
        let removalCount = Int.random(in: 0...(viewModel.bubbles.count / 3))
        
        // Remove random bubbles (not player popped, just random ones)
        for _ in 0..<removalCount {
            if let randomIndex = viewModel.bubbles.indices.randomElement() {
                viewModel.bubbles.remove(at: randomIndex)
            }
        }
        
        // Add some new bubbles, randomly
        let remainingSlots = 15 - viewModel.bubbles.count
        let bubblesToAdd = Int.random(in: 0...remainingSlots)
        for _ in 0..<bubblesToAdd {
            viewModel.createBubble(screenWidth: screenWidth, screenHeight: screenHeight)
        }
    }
}

#Preview {
    GameView()
        .environmentObject(BubbleViewModel())
}
