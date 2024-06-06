//
//  ContentView.swift
//  Hot Prospects
//
//  Created by Abdulwahab Hawsawi on 24/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State var update = false
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Prospect.self)
}
