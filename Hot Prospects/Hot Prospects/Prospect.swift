//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Abdulwahab Hawsawi on 25/04/2024.
//

import Foundation
import SwiftData

@Model
class Prospect {
    var name: String
    var email: String
    var isContacted: Bool
    var dateAdded = Date.now
    
    init(name: String, email: String, isContacted: Bool = false) {
        self.name = name
        self.email = email
        self.isContacted = isContacted
    }
}
