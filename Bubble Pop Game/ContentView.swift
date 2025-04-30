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
            // adding the home screen view here
            GameReadyView()
                .environmentObject(BubbleViewModel())
        }
    }
}

#Preview {
    ContentView()
}
