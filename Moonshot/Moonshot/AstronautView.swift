//
//  AstronautView.swift
//  Moonshot
//
//  Created by Abdulwahab Hawsawi on 11/04/2024.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack (alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .opacity(0.5)
                            .padding(.vertical)
                        
                        Text(astronaut.name)
                            .font(.title.bold())
                            .padding(.bottom)
                        
                        Text(astronaut.description)
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("More Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let previewAstronaut: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: previewAstronaut.first!.value)
        .preferredColorScheme(.dark)
}

