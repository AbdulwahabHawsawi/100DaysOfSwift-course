//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Abdulwahab Hawsawi on 11/05/2024.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchTerm = ""
    @State private var favorites = Favorites()
    @State private var sortOption = SortResorts.none
    
    var filteredResorts: [Resort] {
        let filteredResorts = if searchTerm.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchTerm) }
        }
        
        switch sortOption {
            case .resortName:
                return filteredResorts.sorted {$0.name < $1.name}
            case .country:
                return filteredResorts.sorted {$0.country < $1.country}
            case .none:
                return filteredResorts
        }
    }
    
    var body: some View {
        
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                                    
                            }
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) {
                ResortView(resort: $0)
            }
            .searchable(text: $searchTerm, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem {
                    Menu("Sort by") {
                        Picker("Sort By", selection: $sortOption){
                            ForEach(SortResorts.allCases) {
                                Button("\($0.rawValue.capitalized)") {
                                    
                                }
                                .tag($0)
                            }
                        }
                    }
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

enum SortResorts: String, CaseIterable, Identifiable {
    var id: String {
        self.rawValue
    }
    case none = "default"
    case resortName = "resort name"
    case country = "country"
}
    #Preview {
        ContentView()
    }
