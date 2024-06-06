//
//  EditView.swift
//  BucketList
//
//  Created by Abdulwahab Hawsawi on 04/05/2024.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    
    var location: Location
    
    @State private var name: String
    @State private var description: String
    
    @State private var loadingState = LoadingStates.loading
    @State private var pages = [Page]()
    
    var onSave: (Location) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description, axis: .vertical)
                    
                }
                
                Section("Nerby Places of Interest") {
                    switch loadingState {
                        case .loading:
                            Text("Loading")
                        case .finished:
                            ForEach(pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.title)
                                + Text(": ")
                                + Text(page.description)
                                    .italic()
                            }
                        case .failed:
                            Text("An error has occured. Please try again")
                    }
                }
            }
            .navigationTitle("Place Detail")
            .toolbar {
                Button ("Save") {
                    var newLocation = location
                    
                    newLocation.id = UUID()
                    newLocation.name = name
                    newLocation.description = description
                    
                    onSave(newLocation)
                    
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.location = location
        self.onSave = onSave
        
        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        print(urlString)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(WikipediaResult.self, from: data)

            // success – convert the array values to our pages array
            pages = items.query.pages.values.sorted { $0.title < $1.title }
            loadingState = .finished
        } catch {
            // if we're still here it means the request failed somehow
            print(error.localizedDescription)
            loadingState = .failed
            
        }
    }
}

enum LoadingStates {
    case loading, finished, failed
}

#Preview {
    EditView(location: Location.example) { _ in }
}
