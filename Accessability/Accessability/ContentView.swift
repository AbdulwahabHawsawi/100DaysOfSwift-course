//
//  ContentView.swift
//  Accessability
//
//  Created by Abdulwahab Hawsawi on 05/05/2024.
//

import SwiftUI

struct ContentView: View {
    let pictureNames = [
        "nicolas-tissot-335096",
        "kevin-horstmann-141705",
        "galina-n-189483",
        "ales-krivec-15949"
    ]
    @State private var value = 10
    @State private var selectedPicture = Int.random(in: 0...3)
    var body: some View {
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }
            .padding()

            Button("Decrement") {
                value -= 1
            }
            .padding()
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
            }
        }
    }
}

#Preview {
    ContentView()
}
