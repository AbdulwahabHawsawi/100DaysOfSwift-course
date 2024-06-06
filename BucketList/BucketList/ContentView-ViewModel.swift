//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Abdulwahab Hawsawi on 04/05/2024.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 50),
                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published var locations: [Location]
        @Published var selectedLocation: Location?
        @Published var isUnlocked = false
        
        let savePath = URL.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(longitude: mapRegion.center.longitude, latitude: mapRegion.center.latitude)
            
            locations.append(newLocation)
            save()
        }
        
        func update(location newLocation: Location) {
            guard let selectedLocation = selectedLocation else { return }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = newLocation
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Authenticate yourself to unlock places"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        Task{ @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        
                    }
                    
                }
            } else {
                
            }
        }
        
    }
}
