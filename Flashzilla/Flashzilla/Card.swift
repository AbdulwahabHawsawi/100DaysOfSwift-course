//
//  Card.swift
//  Flashzilla
//
//  Created by Abdulwahab Hawsawi on 09/05/2024.
//

import Foundation

struct Card: Codable, Identifiable {
    var id: UUID
    var prompt: String
    var answer: String
    
    static let example = Card(prompt:  "What is the name of the CPU in my desktop computer?", answer: "Ryzen 5 1400")
    
    init(id: UUID = UUID(), prompt: String, answer: String) {
        self.id = id
        self.prompt = prompt
        self.answer = answer
    }
}

