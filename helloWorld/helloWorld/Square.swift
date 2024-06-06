//
//  Square.swift
//  helloWorld
//
//  Created by Abdulwahab Hawsawi on 31/07/22 .
//

import Foundation
struct Square: Shape {
    var length: Double
    var height: Double = 0
    var numOfCorners = 4
    var base: Double = 0
    static var num = 0
    init(length: Double) {
        Square.num += 1
        self.length = length
    }
    
    func description() {
        print("This shape is a sqaure. Its length is \(length)")
    }
    
    func area() -> Double{
        return pow(length, 2)
    }
    
    func perimeter() -> Double {
        return length * 4
    }
    
    
}
