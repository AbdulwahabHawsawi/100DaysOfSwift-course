//
//  AddExpense.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 05/04/2024.
//

import SwiftUI
import SwiftData

struct AddExpense: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query var expenseListQuery: [ExpenseList]
    
    @State private var name = ""
    @State private var type: String = "personal"
    @State private var amount = 0.0
    @State private var isNotValidExpense = true
    
    var body: some View {
        List {
            TextField("What's the name of the item?", text: $name)
            Picker("Type", selection: $type) {
                ForEach(ExpenseType.allCases) {
                    if $0.rawValue != "none" {
                        Text($0.rawValue)
                    }
                }
            }
            TextField("How much does it cost?", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "SAR"))
                .keyboardType(.decimalPad)
        }
        .onChange(of: name){
            if !name.isEmpty && !amount.isZero {
                isNotValidExpense = false
            } else {
                isNotValidExpense = true
            }
        }
        .onChange(of: amount){
            if !name.isEmpty && !amount.isZero {
                isNotValidExpense = false
            } else {
                isNotValidExpense = true
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Add New Expense")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let item = Expense(name: name, type: type, amount: amount)
                    if let expenseList = expenseListQuery.first {
                        expenseList.items.append(item)
                        
                    } else {
                        
                    }
                    dismiss()
                }
                .disabled(isNotValidExpense)
            }
        }
    }
}

#Preview {
    AddExpense()
}
