//
//  FileManager-extension.swift
//  BucketList
//
//  Created by Abdulwahab Hawsawi on 04/05/2024.
//

import Foundation
extension FileManager {
    static var savePath: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
