//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 17/03/2024.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: ExpenseList.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
