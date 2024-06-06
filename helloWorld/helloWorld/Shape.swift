//
//  Shape.swift
//  helloWorld
//
//  Created by Abdulwahab Hawsawi on 31/07/22 .
//

import Foundation
protocol Shape {
    var length: Double {get set}
    var height: Double {get set}
    var numOfCorners: Int {get set}
    var base: Double {get set}
    func description()
    func area() -> Double // مساحة
    func perimeter() -> Double//محيط
    }

