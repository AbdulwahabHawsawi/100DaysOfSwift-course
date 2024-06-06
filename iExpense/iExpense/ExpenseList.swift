//
//  ExpenseList.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 05/04/2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class ExpenseList {
    var items = [Expense]()
    
    init(items: [Expense] = [Expense]()) {
        self.items = items
    }
}

