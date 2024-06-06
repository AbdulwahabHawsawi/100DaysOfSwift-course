//
//  Triangle.swift
//  helloWorld
//
//  Created by Abdulwahab Hawsawi on 31/07/22 .
//

import Foundation
struct Triangle: Shape {
    static var numOfShapes: Int = 0
    var length: Double = 0
    var height: Double
    var numOfCorners = 3
    var base: Double
    static var num: Int = 0
    
    init (height: Double, base: Double){
        Triangle.num += 1
        self.height = height
        self.base = base
    }
    func description() {
        print("This is a triangle. Its base is \(base), and its height is \(length)")
    }
    
    func area() -> Double {
        return (base * height) / 2
    }
    
    func perimeter() -> Double {
        return base + (height * 2)
    }
    
    
}
