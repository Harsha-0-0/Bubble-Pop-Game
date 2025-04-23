//
//  Bubble.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//
import SwiftUI

struct Bubble: Identifiable{
    var id: UUID = UUID()
    var color: Color
    var xCord: CGFloat
    var yCord: CGFloat
    var points: Int
}
