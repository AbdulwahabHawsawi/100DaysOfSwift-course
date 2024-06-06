//
//  Building.swift
//  helloWorld
//
//  Created by Abdulwahab Hawsawi on 30/11/2022.
//

import Foundation

protocol Building {
    var roomCount: Int {get set}
    var buildingCost: Int {get set}
    var realEstate: String {get set}
    
    func summary()
}

extension Building {
    func summary() {
        let roomWordFormat = roomCount == 1 ? "1 room" : "\(roomCount) rooms"
        
        print("This \(type(of: self)) has \(roomWordFormat), and costs \(buildingCost). Its manager is \(realEstate).")
    }
}
