//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Abdulwahab Hawsawi on 23/04/2024.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    VStack {
                        Text(user.name)
                        Text(user.city)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    
                    Text(String(user.jobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>], listOfUsers: [User] = [User(name: "N/A", city: "No city", joinDate: .now)]) {
        _users = Query( filter: #Predicate<User> {
            $0.joinDate >= minimumJoinDate
        },
                        sort: sortOrder
                        
        )
    }
    
    func addSample() {
        let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = [User(name: "N/A", city: "No city", joinDate: .now)]
        return  UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)], listOfUsers: user)
            .modelContainer(for: User.self)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
    
}
