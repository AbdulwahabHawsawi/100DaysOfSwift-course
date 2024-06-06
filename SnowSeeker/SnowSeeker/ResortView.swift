//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Abdulwahab Hawsawi on 12/05/2024.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @Environment(Favorites.self) var favorites

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .bottomTrailing) {
                            Text("Credit: \(resort.imageCredit)")
                                .foregroundStyle(.white)
                                .padding(3)
                                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(.gray).opacity(0.4))
                                .padding(5)
                            
                }
                
                HStack {
                    if sizeClass == .compact && dynamicTypeSize > DynamicTypeSize.large {
                        VStack (spacing: 10) {ResortDetailsView(resort: resort)}
                        VStack(spacing: 10) {SkiDetailsView(resort: resort)}
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityIcons) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favourites" : "Add to Favourites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .dynamicTypeSize(.small ... .xxxLarge)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
