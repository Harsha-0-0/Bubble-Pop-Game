//
//  PlayerInputView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 23/04/25.
//
import SwiftUI

struct PlayerInputView: View {
    @State private var newPlayerName: String = ""
    @State private var time: Int = 60
    @State private var numberOfBubbles: Int = 15
    @State private var navigateToGame = false
    @EnvironmentObject var bubbleViewModel: BubbleViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.7), Color.pink.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .blur(radius: 10)
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Enter Your Name")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    // Player Name TextField with shadow and rounded corners
                    TextField("Enter your name", text: $newPlayerName)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(radius: 10)
                        .frame(maxWidth: .infinity)
                    
                    // Choose Game Duration Text
                    Text("Choose the duration of the game")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                    
                        .padding(.bottom, 10)
                    
                    // Picker for Game Duration with customized style
                    Picker(selection: $time, label: Text("Choose the duration of the game")) {
                        ForEach(1...100, id: \.self) { sec in
                            Text("\(sec) seconds").tag(sec)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    // Choose Number of Bubbles
                    Text("Choose the number of bubbles")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                    
                        .padding(.bottom, 10)
                    
                    // Segmented Picker for Number of Bubbles
                    Picker("Choose the number of bubbles", selection: $numberOfBubbles) {
                        Text("10").tag(10)
                        Text("15").tag(15)
                        Text("20").tag(20)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .background(Color.white.opacity(0.6))
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    
                    
                    // Start Game Button
                    Button(action: {
                        if !newPlayerName.isEmpty {
                            navigateToGame = true
                        }
                    }) {
                        Text("Start Game")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(newPlayerName.isEmpty ? Color.gray : Color.pink)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .scaleEffect(newPlayerName.isEmpty ? 1.0 : 1.05)
                            .animation(.easeInOut(duration: 0.2), value: newPlayerName.isEmpty)
                    }
                    .disabled(newPlayerName.isEmpty)
                    .padding(.bottom, 30)
                    
                    // Take user to the Game View
                    // we have time and initial time. both are the same values but this helps when player goes back from GameOverView to GameView as the time will turn to 0 and the game won't start when user clicks on Play Again
                    .navigationDestination(isPresented: $navigateToGame) {
                        CountdownView(playerName: newPlayerName, time: time,  initialTime: time, numberOfBubbles: numberOfBubbles)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    PlayerInputView()
        .environmentObject(BubbleViewModel())
}
