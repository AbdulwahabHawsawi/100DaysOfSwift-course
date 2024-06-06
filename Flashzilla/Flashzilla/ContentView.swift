//
//  ContentView.swift
//  Flashzilla
//
//  Created by Abdulwahab Hawsawi on 07/05/2024.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}


struct ContentView: View {
    @State private var cards = [Card]()
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
            VStack {
                Text("Time Remianing is \(timeRemaining) seconds")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 25.0).fill(.black).opacity(0.5))
                ZStack{
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index  == cards.count - 1)
                        .accessibilityHidden(index < cards.count - 1)
                        
                    }
                }
                .allowsHitTesting(timeRemaining > 0 ? true : false)
                
                if cards.isEmpty {
                    Button("Start Again", action: reset)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                        .padding()
                }
            }
            VStack {
                HStack {
                    Spacer()

                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }

                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding(.horizontal, 100)
            .padding(.vertical, 45)
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                                .padding()
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as correct")
                        Spacer()
                        Button {
                            withAnimation {
                                removeCard(at: cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                                .padding()
                        }
                    }
                }
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
            }
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active && !cards.isEmpty {
                isActive = true
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: reset, content: EditCardView.init)
        .onAppear(perform: reset)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func reset() {
        loadData()
        timeRemaining = 100
        isActive = true
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}
#Preview {
    ContentView()
}
