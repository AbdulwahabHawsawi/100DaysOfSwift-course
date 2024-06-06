//
//  Hot_ProspectsApp.swift
//  Hot Prospects
//
//  Created by Abdulwahab Hawsawi on 24/04/2024.
//

import SwiftUI
import SwiftData

@main
struct Hot_ProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
