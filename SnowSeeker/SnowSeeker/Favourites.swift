//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Abdulwahab Hawsawi on 13/05/2024.
//

import Foundation

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    private let saveLoadFileName = "favourites.txt"

    init() {
        if let resortsAsData = try? Data(contentsOf: URL.documentsDirectory.appending(path: saveLoadFileName)) {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: resortsAsData) {
                resorts = decodedResorts
                return
            }
        }

        // still here? Use an empty array
        resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set and saves the change
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }

    func save() {
        do{
            let resortsAsData = try Data(JSONEncoder().encode(resorts))
            try resortsAsData.write(to: URL.documentsDirectory.appending(path: saveLoadFileName), options: [.atomic, .completeFileProtection])
        } catch {
            print("An error occurred while trying to encode resorts")
        }
        
        
    }
}
