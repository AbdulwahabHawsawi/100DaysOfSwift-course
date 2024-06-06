//
//  House.swift
//  helloWorld
//
//  Created by Abdulwahab Hawsawi on 30/11/2022.
//

import Foundation
struct House: Building{
    var roomCount: Int 
    var buildingCost: Int
    var realEstate: String
    
    init(roomCount: Int, buildingCost: Int, realEstate: String = "undetermined") throws{
        if roomCount < 1 {
            throw possibleErrors.lessThanOneRoom
        }
        
        if buildingCost < 0{
            throw possibleErrors.negativePrice
        }
        
        self.roomCount = roomCount
        self.buildingCost = buildingCost
        self.realEstate = realEstate
    }
}
