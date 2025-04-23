//
//  GameOverView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 23/04/25.
//

import SwiftUI

struct GameOverView: View {
    var score: Int
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Game Over")
                    .font(.largeTitle)
                    .bold()
                
                Text("Your Score: \(score)")
                    .font(.title)
                    .padding()
                
                HStack {
                    NavigationLink(
                        destination: GameView()
                            .environmentObject(BubbleViewModel())
                            .id(UUID())
                            .navigationBarBackButtonHidden(true), // <- right here
                        label: {
                            Text("Play Again")
                        }
                    )
                    
                    
                    NavigationLink(
                        destination: GameReadyView()
                            .id(UUID())
                            .navigationBarBackButtonHidden(true),
                        label: {
                            Text("Go Home")
                        }
                    )
                    
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true) // hides back button on GameOverView itself
    }
}

