//
//  Mission.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 09/04/2024.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    struct CrewRole: Codable, Hashable {
        var name: String
        var role: String
    }
    
}
