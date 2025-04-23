//
//  BubbleViewModel.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//
import SwiftUI

class BubbleViewModel: ObservableObject {
    
    @Published var bubbles: [Bubble] = []
    
    func createBubble(screenWidth: CGFloat, screenHeight: CGFloat) {
        let type = generateRandomBubble()
        let bubbleRadius: CGFloat = 33
        let maxAttempts = 10
        var attempt = 0
        var newBubble: Bubble?
        
        while attempt < maxAttempts {
            let x = CGFloat.random(in: bubbleRadius...(screenWidth - bubbleRadius))
            let y = CGFloat.random(in: bubbleRadius...(screenHeight - bubbleRadius))
            
            let overlaps = bubbles.contains { existing in
                let dx = x - existing.xCord
                let dy = y - existing.yCord
                let distance = sqrt(dx * dx + dy * dy)
                return distance < bubbleRadius * 3
            }
            
            if !overlaps {
                newBubble = Bubble(color: type.color, xCord: x, yCord: y, points: type.points)
                break
            }
            attempt += 1
        }
        
        if let bubble = newBubble {
            bubbles.append(bubble)
        }
    }
    private func generateRandomBubble() -> (color: Color, points: Int) {
        let rand = Double.random(in: 0..<1)
        switch rand {
        case 0..<0.4: return (.red, 1)
        case 0.4..<0.7: return (Color("Pink_Bubble"), 2)
        case 0.7..<0.85: return (.green, 5)
        case 0.85..<0.95: return (.blue, 8)
        default: return (.black, 10)
        }
    }
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
        }
    }
    
    
}
