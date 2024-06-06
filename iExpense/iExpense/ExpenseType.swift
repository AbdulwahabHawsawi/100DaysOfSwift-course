//
//  ExpenseType.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 24/04/2024.
//

import Foundation
enum ExpenseType:String, CaseIterable, Identifiable, Codable {
    var id: String {
        return self.rawValue
    }
    
    case none = "none"
    case personal = "personal"
    case business = "business"
}
