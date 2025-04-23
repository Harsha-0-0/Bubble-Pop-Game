//
//  GameReadyView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct GameReadyView: View {
    @State private var showCountdown = false
    var body: some View {
        if showCountdown {
            CountdownView()
        } else {
            VStack {
                Text("Are you ready to play the Bubble Pop Game?")
                
                Button {
                    showCountdown = true
                } label: {
                    Text("Start")
                }
            }
        }
    }
}


#Preview {
    GameReadyView()
}
