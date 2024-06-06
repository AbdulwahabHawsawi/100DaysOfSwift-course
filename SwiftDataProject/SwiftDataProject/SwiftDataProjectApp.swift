//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Abdulwahab Hawsawi on 21/04/2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
