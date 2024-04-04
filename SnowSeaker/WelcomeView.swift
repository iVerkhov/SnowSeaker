//
//  WelcomeView.swift
//  SnowSeaker
//
//  Created by Игорь Верхов on 31.03.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Snow Seaker!")
                .font(.headline)
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
