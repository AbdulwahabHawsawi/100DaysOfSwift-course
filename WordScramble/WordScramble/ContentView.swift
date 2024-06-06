//
//  ContentView.swift
//  WordScramble
//
//  Created by Abdulwahab Hawsawi on 26/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var enteredWords = [String]()
    
    @State private var rootWord = ""
    @State private var previousRootWords = [(word: String, score: Int)]()
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .onSubmit(addWord)
                }
                Section {
                    ForEach (enteredWords, id: \.self) { word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")  
                    }
                } header: {
                    if enteredWords.count > 0 {
                        Text("Correct words")
                    }
                }
                
                
                Section {
                    ForEach(previousRootWords, id: \.self.word){ root in
                        HStack{
                            Text("\(root.word)")
                            Spacer()
                            Text("\(root.score)")
                        }
                    }
                } header: {
                    if previousRootWords.count > 0 {
                        Text("Previous scores")
                    }
                }
                
            }
            .onAppear(perform: startGame)
            .navigationTitle(rootWord)
            .toolbar{
                Button("Try another word") {
                    withAnimation {
                        previousRootWords.insert((rootWord, score), at: 0)
                        enteredWords.removeAll()
                        
                        startGame()
                    }
                    
                }
            }
            .alert(errorTitle, isPresented: $showAlert) {
                
            } message: {
                Text(errorMessage)
            }
            
            Text("Score for the word \(rootWord): \(score)")
        }
    }
    func startGame() {
        
        if let startFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startFileAsString = try? String(contentsOf: startFileURL) {
                let allWords = startFileAsString.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                
                return
            }
        }
        
        fatalError("An error occured while trying to load start.txt from bundle")
    }
    func addWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            showErrorAlert(title: "Invalid letter count", Message: "Use a word longer than 2 letters")
            return
        }
        guard !isRootWord(word: answer) else {
            showErrorAlert(title: "Cheeky!", Message: "Use a different word")
            return
        }
        guard isOriginal(word: answer) else {
            showErrorAlert(title: "The word \(answer) is invalid", Message: "You have already used it")
            return
        }
        guard isPossible(word: answer) else {
            showErrorAlert(title: "The word \(answer) is invalid", Message: "It does not use the same letters as the word \(rootWord)")
            return
        }
        guard isReal(word: answer) else {
            showErrorAlert(title: "The word \(answer) is invalid", Message: "This is not a real word")
            return
        }
        
        withAnimation{
            enteredWords.insert(answer, at: 0)
        }
        newWord = ""
        score += answer.count
    }
    
    func isOriginal (word: String) -> Bool {
        return !enteredWords.contains(word)
    }
    
    func isPossible (word: String) -> Bool {
        var tempRootWord = rootWord
        
        /*
         Loop over all letter in the user word. All letters. if letters match between
         The matching letters will be removed. If there is, at most, one non-matching letter,
         then false will be returned.
         
         */
        for letter in word {
            if let letterPosition = tempRootWord.firstIndex(of: letter){
                tempRootWord.remove(at: letterPosition)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorAlert (title: String, Message: String) {
        errorTitle = title
        errorMessage = Message
        showAlert = true
    }
    
    func isRootWord(word: String) -> Bool {
        return word == rootWord
    }
}

#Preview {
    ContentView()
}
