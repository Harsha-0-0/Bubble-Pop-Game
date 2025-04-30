//
//  BubbleViewModel.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//
import SwiftUI

class BubbleViewModel: ObservableObject {
    
    @Published var bubbles: [Bubble] = []
    
    // creating bubbles
    func createBubble(screenWidth: CGFloat, screenHeight: CGFloat) {
        let type = generateRandomBubble()
        let bubbleRadius: CGFloat = 33  // since bubbles are of size 66,66
        let maxAttempts = 20  // attempts to create bubbles
        var attempt = 0
        var newBubble: Bubble?
        
        while attempt < maxAttempts {
            // making sure that bubbles appear fully on screen
            let xCord = CGFloat.random(in: bubbleRadius ... screenWidth - bubbleRadius)
            let yCord = CGFloat.random(in: bubbleRadius ... screenHeight - bubbleRadius)
            
            // making sure bubbles don't overlap
            let overlaps = bubbles.contains { existing in
                let dx = xCord - existing.xCord
                let dy = yCord - existing.yCord
                let distance = sqrt(dx * dx + dy * dy)
                return distance < bubbleRadius * 2  // making sure that bubbles don't touch each other
            }
            
            if !overlaps {
                newBubble = Bubble(color: type.color, xCord: xCord, yCord: yCord, points: type.points)
                break
            }
            
            attempt += 1
        }
        
        if let bubble = newBubble {
            bubbles.append(bubble)
        } else {
            // If no bubble is created after max attempts, we create a bubble anyway
            let xCord = CGFloat.random(in: bubbleRadius ... screenWidth - bubbleRadius)
            let yCord = CGFloat.random(in: bubbleRadius ... screenHeight - bubbleRadius)
            let fallbackBubble = Bubble(color: type.color, xCord: xCord, yCord: yCord, points: type.points)
            bubbles.append(fallbackBubble)
        }
    }
    
    // logic to show bubbles on the probability of colors
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
    // removing bubbles when it is popped
    func removeBubble(_ bubble: Bubble) {
        if let index = bubbles.firstIndex(where: { $0.id == bubble.id }) {
            bubbles.remove(at: index)
        }
    }
    
    
}
