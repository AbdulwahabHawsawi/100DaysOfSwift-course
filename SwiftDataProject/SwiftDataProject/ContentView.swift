//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Abdulwahab Hawsawi on 21/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<User> { user in
        user.name.localizedStandardContains("K")
    },
           sort: \User.name) var users: [User]
    @State private var path = [User]()
    
    var isShowingUpcomingOnly = false
    @State private var sortOrder = [SortDescriptor(\User.name),
                                    SortDescriptor(\User.city)]
    
    var body: some View {
        NavigationStack(path: $path) {
            UsersView(minimumJoinDate: isShowingUpcomingOnly ? .now : .distantPast,
                      sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                EditUserView(user: user)
            }
            .toolbar {
                ToolbarItemGroup {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([SortDescriptor(\User.name),
                                      SortDescriptor(\User.city)])
                            
                            Text("Sort by city")
                                .tag([SortDescriptor(\User.city),
                                      SortDescriptor(\User.name)])
                        }
                    }
                    Button("Add User") {
                        let user = User(name: "", city: "", joinDate: .now)
                        modelContext.insert(user)
                        path = [user]
                    }
                    Button("Add Sample") {
                        try? modelContext.delete(model: User.self)
                        let firstName = ["Aaran", "Juliana", "Maxine", "Brett", "Victor"]
                        let lastName = ["Chukwuemeka", "Baird", "Ciann", "Hackney", "Wayne", "Nance"]
                        let countries = [
                            "Afghanistan", // A
                            "Brazil",       // B
                            "Canada",       // C
                            "Denmark",     // D
                            "Ethiopia",     // E
                            "France",       // F
                            "Greece",       // G
                            "Hungary",     // H
                            "India",        // I
                            "Japan"         // J
                        ]
                        for _ in 0..<10 {
                            let user = User(name: "\(firstName.randomElement()!) \(lastName.randomElement()!)", city: countries.randomElement()!, joinDate: .now.addingTimeInterval(TimeInterval(86400 * Int.random(in: -100 ... 100))))
                            modelContext.insert(user)
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
