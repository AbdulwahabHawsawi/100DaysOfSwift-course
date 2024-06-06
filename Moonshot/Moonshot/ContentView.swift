//
//  ContentView.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 07/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isDisplayedAsGrid = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isDisplayedAsGrid {
                    GridView()
                } else {
                    ListView()
                }
            }
            .toolbar{
                Button {
                    withAnimation {
                        isDisplayedAsGrid.toggle()
                    }
                } label: {
                    if isDisplayedAsGrid {
                        Image(systemName: "list.bullet")
                    } else {
                        Image(systemName: "square.grid.2x2")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
