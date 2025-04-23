//
//  ContentView.swift
//  Bubble Pop Game
//
//  Created by Harshi on 21/04/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
                    GameReadyView()
                        .environmentObject(BubbleViewModel())
                }
    }
}

#Preview {
    ContentView()
}
