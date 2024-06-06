//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Abdulwahab Hawsawi on 27/04/2023.
//

import SwiftUI

struct FlagImage: View {
    var flagName = ""
    var body: some View {
        Image(flagName)
            .clipShape(.circle)
            .shadow(radius: 10)
    }
}

struct ContentView: View {
    init() {
        remainingQuestions = numberOfQuestions
    }
    
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Nigeria", "Poland", "Spain", "UK", "US", "Russia", "Monaco"].shuffled()
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    @State private var correctCountry = Int.random(in: 0...2)
    @State private var showAnswerAlert = false
    @State private var scoreStatus = ""
    @State private var score = 0
    private let numberOfQuestions = 8
    @State private var remainingQuestions: Int
    @State private var correctAnswerText = ""
    @State private var showEndOfGame = false
    
    @State private var clickAnimation = [0.0, 0.0, 0.0]
    @State private var opacityAnimation = [0.0, 0.0, 0.0]
    @State private var scaleAnimation = [0.0, 0.0, 0.0]
    
    @State private var clickedFlag = 999
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.15),
                .init(color: Color(red: 0.4, green: 0.5, blue: 0.7), location: 0.15)
            ], center: .top, startRadius: 20, endRadius: 1300)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea()
            
            VStack (spacing: 30){
                
                VStack{
                    Text("Choose the correct flag for the country:")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    
                    
                    Text("\(countries[correctCountry])")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                VStack (spacing:40) {
                    withAnimation {
                        ForEach(0..<3) { number in
                            Button {
                                    withAnimation {
                                        for index in 0..<clickAnimation.count {
                                            if index == number {
                                                clickAnimation[number] += 360
                                            } else {
                                                opacityAnimation[index] = 0.75
                                                scaleAnimation[index] = 0.5
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                determineAnswer(number)
                            } label: {
                            FlagImage(flagName: countries[number])
                                //Without using an array, all flags would rotate at the same time
                                .rotation3DEffect(.degrees(clickAnimation[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                                .opacity(1 - opacityAnimation[number])
                                .animation(.default, value: clickAnimation)
                                .scaleEffect(1 - scaleAnimation[number])
                            }
                            .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                        }
                    }
                }
                Text("Score: \(score)")
                    .frame(width: 70, height: 30)
                    .background(.regularMaterial, in: .capsule)
                    .foregroundStyle(.primary)
                Text("Remaining attemps: \(remainingQuestions)")
                    .frame(width: 200, height: 30)
                    .background(.regularMaterial, in: .capsule)
                    .foregroundStyle(.primary)
            }
        }
        .background(.indigo.gradient)
        .alert(scoreStatus, isPresented: $showAnswerAlert) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(correctAnswerText)")
            Text("Your score is\(score)")
        }
        .alert("Game over!", isPresented: $showEndOfGame) {
            Button("Play Again") {
                remainingQuestions = numberOfQuestions
                score = 0
                askQuestion()
            }
        } message: {
            Text("You reached the end of the game. The final score is \(score) out of \(numberOfQuestions)")
            
        }
    }
    
    func determineAnswer(_ number:Int) {
        remainingQuestions -= 1
        
        if remainingQuestions == 0 {
            showEndOfGame = true
            return
        }
        
        if number == correctCountry {
            scoreStatus = "Correct!"
            correctAnswerText = ""
            score += 1
        } else {
            scoreStatus = "False :("
            correctAnswerText = "This flag is for the country \(countries[number])"
        }
        
        showAnswerAlert = true
    }
    
    func askQuestion() {
        withAnimation {
            opacityAnimation = [0.0, 0.0, 0.0]
            scaleAnimation = [0.0, 0.0, 0.0]
        }
        countries.shuffle()
        correctCountry = Int.random(in: 0..<3)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
