//
//  ContentView.swift
//  Lab2
//
//  Created by Joshua Tan on 2025/10/9.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Test Your Memory!")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
            GameBoard()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
