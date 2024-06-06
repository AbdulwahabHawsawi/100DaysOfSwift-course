//
//  ContentView.swift
//  BucketList
//
//  Created by Abdulwahab Hawsawi on 03/05/2024.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundStyle(.white)
                        .font(.title)
                        .clipShape(.circle)
                        .padding(.trailing)
                        .sheet(item: $viewModel.selectedLocation) { selectedLocation in
                            EditView(location: selectedLocation) { newLocation in
                                viewModel.update(location: newLocation)
                            }
                        }
                    }
                }
            }
        } else {
            Button ("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            
        }
    }
}



#Preview {
    ContentView()
}
