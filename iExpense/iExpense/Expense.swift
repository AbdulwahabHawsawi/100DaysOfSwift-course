//
//  Expense.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 05/04/2024.
//

import Foundation
import SwiftData

@Model
class Expense: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String = "N/A", type: String = "business", amount: Double = 0.0) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
    
    
}
