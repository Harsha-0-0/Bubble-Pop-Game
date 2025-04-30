//
//  CountdownView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct CountdownView: View {
    @State private var seconds = 3
    @State private var showBubble = false
    @State private var scale: CGFloat = 1.0
    var playerName: String
    var time: Int
    var initialTime: Int
    var numberOfBubbles: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if showBubble {
            // sending the playerName, time, numberOfBubbles from PlayerInputView to the GameView
            GameView(time: time, playerName: playerName, initialTime: initialTime, numberOfBubbles: numberOfBubbles)
                .environmentObject(BubbleViewModel())
                .id(UUID()) 
        } else {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blur(radius: 10)
                .ignoresSafeArea()
                // Showing 3 2 1 Go!
                Text(seconds > 0 ? "\(seconds)" : "Go!")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.white)
                    .scaleEffect(scale)
                    .onReceive(timer) { _ in
                        if seconds > 0 {
                            // adding animation to make it pretty
                            withAnimation(.easeInOut(duration: 0.5)) {
                                scale = 1.3
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    scale = 1.0
                                }
                            }
                            seconds -= 1
                        } else {
                            showBubble = true
                        }
                    }
            }
            .navigationBarBackButtonHidden(true) // don't want to display the back button
        }
    }
}

