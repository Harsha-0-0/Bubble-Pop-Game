//
//  CountdownView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct CountdownView: View {
    @State var seconds = 3
    @State private var showBubble = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        if showBubble {
            GameView().environmentObject(BubbleViewModel())
                .id(UUID())
        } else {
            Text(seconds > 0 ? "\(seconds)" : "Go!")
                .font(.largeTitle)
                .onReceive(timer) { _ in
                    if seconds > 0 {
                        seconds -= 1
                    } else {
                        // Wait 1 second after "Go!" then show bubble
                        showBubble = true
                    }
                }
        }
    }}

#Preview {
    CountdownView()
}
