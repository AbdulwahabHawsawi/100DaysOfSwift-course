//
//  MissionView.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 10/04/2024.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String : Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("The astronaut \(member.name) can't be found in the dictionary of astronauts even though he is a part of the mission \(mission.displayName)")
            }
        }
        
        
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    Text("Launch date: \(mission.formattedLaunchDate)")
                        .font(.caption)
                        .opacity(0.7)
                    
                    VStack (alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .opacity(0.5)
                            .padding(.vertical)
                        
                        Text("Mission Highlight")
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .opacity(0.5)
                            .padding(.vertical)
                        
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom)
                    }
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(crew, id: \.role) { crewMember in
                                HStack {
                                    NavigationLink {
                                        AstronautView(astronaut: crewMember.astronaut)
                                    } label: {
                                        Image(crewMember.astronaut.id)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .frame(width: 100)
                                            .overlay {
                                                Circle()
                                                    .strokeBorder(.white, lineWidth: 1)
                                            }
                                        VStack (alignment: .leading) {
                                            Text(crewMember.astronaut.name)
                                                .foregroundStyle(.white)
                                                .font(.headline)
                                            
                                            Text(crewMember.role)
                                                .foregroundStyle(.white.opacity(0.5))
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let previewMission: [Mission] = Bundle.main.decode("missions.json")
    let previewAstronaut: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: previewMission.first!, astronauts: previewAstronaut)
        .preferredColorScheme(.dark)
}
