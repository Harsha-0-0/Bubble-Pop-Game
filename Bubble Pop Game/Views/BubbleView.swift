//
//  BubbleView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 25/04/25.
//

import SwiftUI

struct BubbleView: View {
    let bubble: Bubble
    let onTap: (Bubble) -> Void
    
    @State private var isPopped = false
    // creating the bubble here
    var body: some View {
        Circle()
            .fill(bubble.color)
            .frame(width: 66, height: 66)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .scaleEffect(isPopped ? 1.3 : 1.0)
            .opacity(isPopped ? 0 : 1)
            .position(x: bubble.xCord, y: bubble.yCord)
            .onAppear {
                withAnimation(.easeIn(duration: 0.4)) {
                }
            }
        // popping bubbles
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.2)) {
                    isPopped = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    onTap(bubble)
                }
            }
    }
}

