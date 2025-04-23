//
//  PlayerViewModel.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = [
        Player(name: "Harsha", score: 10),
        Player(name: "Pooky", score: 20),
        Player(name: "Mickey", score: 25),
    ]
    
    @AppStorage("VisitCount") var visitCount: Int = 0
    
    func addNewPlayer(player: Player) {
        let newPlayer = Player(name: player.name, score: player.score)
        
        players.append(newPlayer)
    }
}
