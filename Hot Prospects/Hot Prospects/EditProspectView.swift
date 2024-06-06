//
//  EditProspectView.swift
//  Hot Prospects
//
//  Created by Abdulwahab Hawsawi on 25/04/2024.
//

import SwiftUI
import SwiftData

struct EditProspectView: View {
    @Bindable var prospect: Prospect
    @Binding var getSelectionToFixBugWithNavLinkAndSelection: Set<Prospect>
    @State private var oldName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
                .textContentType(.name)
            TextField("Email", text: $prospect.email)
                .textContentType(.emailAddress)
        }
        .navigationTitle("Edit Details of \(oldName)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            oldName = prospect.name
            getSelectionToFixBugWithNavLinkAndSelection.removeAll()
        }
    }
    
}

#Preview {
    
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        struct Preview: View {

            @State var exampleSet = Set<Prospect>()
            let example = Prospect(name: "Important", email: "important@mail.com")
            var body: some View {
                EditProspectView(prospect: example, getSelectionToFixBugWithNavLinkAndSelection: $exampleSet)
            }
        }
        
        return NavigationStack {
            Preview()
        }
    }  catch {
        return Text("An error has occured while previewing \(error.localizedDescription)")
    }
}
