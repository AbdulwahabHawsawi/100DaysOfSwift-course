//
//  ListView.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 11/04/2024.
//

import SwiftUI

struct ListView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        List {
            ForEach (missions) { mission in
                VStack (alignment: .leading) {
                    NavigationLink (value: mission) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            
                        }
                    }
                }
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
            }
        }
        .padding([.horizontal, .bottom])
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        .scrollContentBackground(.hidden)
        .navigationDestination(for: Mission.self) {
            MissionView(mission: $0, astronauts: astronauts)
        }
    }
}

#Preview {
    ListView()
}
