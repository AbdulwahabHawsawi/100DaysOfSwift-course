//
//  GridView.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 11/04/2024.
//

import SwiftUI

struct GridView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let layout = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach (missions) { mission in
                    VStack {
                        NavigationLink (value:  mission) {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(maxWidth: .infinity)
                            .overlay {
                                RoundedRectangle (cornerRadius: 10)
                                    .stroke(.lightBackground)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)
        .navigationDestination(for: Mission.self) {
            MissionView(mission: $0, astronauts: astronauts)
        }
    }
}


#Preview {
    GridView()
}
