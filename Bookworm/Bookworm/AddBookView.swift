//
//  AddBookView.swift
//  Bookworm
//
//  Created by Abdulwahab Hawsawi on 19/04/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var database
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    var isValidBook: Bool {
        if title.isEmpty || author.isEmpty || review.isEmpty {
            return false
        }
        
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Mystrey", "Politics", "Romance"]
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Name", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0.capitalized)
                        }
                    }
                }
                
                Section ("Write a Review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button ("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        database.insert(newBook)
                        dismiss()
                    }
                    .disabled(!isValidBook)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
