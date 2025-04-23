//
//  ScoreView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject private var viewModel: PlayerViewModel
    var body: some View {
        VStack{
            Text("Ranking")
                .font(.largeTitle)
                .bold()
            ForEach(viewModel.players.sorted(by: { $0.score > $1.score })) { player in
                HStack {
                    Text(player.name)
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Text("\(player.score)")
                        .font(.title2)
                }
                .padding(.horizontal)
            }
        }
        
    }
}

#Preview {
    ScoreView()
        .environmentObject(PlayerViewModel())
}
