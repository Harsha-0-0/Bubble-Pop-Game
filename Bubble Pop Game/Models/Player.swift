//
//  Player.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//
import SwiftUI

// Player model
struct Player: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var score: Int
}
