//
//  ScoreView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject private var viewModel: PlayerViewModel
    @State private var showResetConfirmation = false

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

            VStack(spacing: 20) {
                Text("Player Rankings")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 5)
                // putting the players inside scroll view to enable scrolling
                ScrollView {
                    LazyVStack(spacing: 16) {
                        //getting the players data from PlayerViewModel
                        ForEach(Array(viewModel.players.sorted(by: { $0.score > $1.score }).enumerated()), id: \.element.id) { index, player in
                            HStack {
                                Text(rankEmoji(for: index) + " \(player.name)")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("\(player.score) pts")
                                    .font(.title3)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.white.opacity(0.8)) 
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
                            .padding(.horizontal)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                    }
                    .padding(.top, 10)
                }
                Spacer(minLength: 20)
            }
            .padding()
        }
    }

    // Ranking the players and displaying medals for the first 3
    private func rankEmoji(for index: Int) -> String {
        switch index {
        case 0: return "🥇"
        case 1: return "🥈"
        case 2: return "🥉"
        default: return "\(index + 1)."
        }
    }
}

#Preview {
    ScoreView()
        .environmentObject(PlayerViewModel())
}
