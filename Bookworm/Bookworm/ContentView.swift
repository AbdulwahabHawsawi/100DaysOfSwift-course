//
//  ContentView.swift
//  Bookworm
//
//  Created by Abdulwahab Hawsawi on 14/04/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Book.author)]) var books: [Book]
    
    @State var showingAddScreen = false
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(books) { book in
                        NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                        .foregroundStyle(book.rating == 1 ? .red : .black)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                    Text("Finished on \(book.date.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteBooks)
                }
                .navigationDestination(for: Book.self) {
                    BookDetailView(book: $0)
                }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button ("Add Book", systemImage: "plus") {
                            showingAddScreen = true
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
            }
        }
    }
    
    func deleteBooks (at offsets: IndexSet) {
        for index in offsets {
            let bookToDelete = books[index]
            modelContext.delete(bookToDelete)
        }
    }
}

#Preview {
    ContentView()
}
