//
//  ContentView.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 17/03/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var expenseListQuery: [ExpenseList]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ExpenseListView()
        }
        .navigationTitle("iExpense")
        .onAppear {
            if expenseListQuery.first == nil {
                modelContext.insert(ExpenseList(items: []))
            }
        }
    }
    
}


#Preview {
    ContentView()
}
