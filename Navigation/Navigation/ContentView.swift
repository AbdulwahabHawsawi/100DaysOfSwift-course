//
//  ContentView.swift
//  Navigation
//
//  Created by Abdulwahab Hawsawi on 11/04/2024.
//

import SwiftUI
struct infiniteView: View  {
    @Binding var pat: NavigationPath
    
    var body: some View {
        
        NavigationLink ("click me \(Int.random(in: 0..<1000))") {
            infiniteView(pat: $pat)
        }
        .toolbar {
            Button("home") {
                pat = NavigationPath()
            }
        }
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack (path: $path) {
            Button ("Hi") {
                path.append("h")
            }
            
            .navigationDestination(for: String.self) { item in
                infiniteView(pat: $path)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
