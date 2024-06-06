//
//  Bundle-decode.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 09/04/2024.
//

import Foundation

extension Bundle {
    func decode<T: Codable> (_ file: String) -> T{
        guard let JSON_URL = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in Bundle")
        }
        
        guard let JSONFileData = try? Data(contentsOf: JSON_URL) else {
            fatalError("Could not load \(file) from URL variable")
        }
        
        let decoder = JSONDecoder()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormat)
        
        guard let TObject = try? decoder.decode(T.self, from: JSONFileData) else {
            fatalError("Could not decode the JSON in \(file)")
        }
        
        return TObject
    }
}
