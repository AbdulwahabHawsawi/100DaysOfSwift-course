//
//  ContentView.swift
//  Animation
//
//  Created by Abdulwahab Hawsawi on 03/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var animationNumber = 1.0
    
    @State private var secondAnimation = true
    
    @State private var dragString = Array("Drag me!")
    @State private var dragAmount = CGSize.zero
    
    @State private var isShowingRectangle = false
    var body: some View {
        
        VStack {
            
            Button("Don't tap me"){
                animationNumber += 1
            }
            
            .padding(10)
            .background(.indigo)
            .foregroundStyle(.white)
            .clipShape(.ellipse)
            .overlay {
                Ellipse()
                    .stroke(.indigo)
                    .scaleEffect(animationNumber)
                    .opacity(2.0 - animationNumber)
                    .animation(.easeOut
                        .speed(0.5)
                        .repeatForever(autoreverses: false),
                               value: animationNumber)
            }
            
            .onAppear {
                animationNumber = 2.0
            }
            .padding()
            
            Button("Tap me") {
                secondAnimation.toggle()
            }
            .frame(width: 150, height: 150)
            .background(secondAnimation ? .blue : .red)
            .animation(.easeInOut(duration: 2), value: secondAnimation)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: secondAnimation ? 60 : 0))
            .animation(.spring(duration: 3, bounce: 0.2)
                .speed(4), value: secondAnimation)
            .padding(.bottom, 20)
            
            
            HStack (spacing: 0){
                ForEach(0..<dragString.count) { index in
                    Text(String(dragString[index]))
                        .background(.yellow)
                        .font(.title)
                        .offset(dragAmount)
                        .animation(.linear(duration: Double(index) / 20), value: dragAmount)
                }
            }
            .padding()
            .gesture(
                DragGesture()
                    .onChanged {
                        dragAmount = $0.translation
                    } .onEnded {_ in 
                        withAnimation {
                            dragAmount = .zero
                        }
                    }
            )
            
            HStack{
                Button("Tap me to see a magical trick!") {
                    withAnimation {
                        isShowingRectangle.toggle()
                    }
                }
                .padding(6)
                .background(.brown)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10.0))
                
                if isShowingRectangle{
                    Rectangle()
                        .fill(LinearGradient(colors: [.red, .black], startPoint:
                                .top, endPoint: .bottomTrailing))
                        .frame(width: 100, height: 100)
                        .transition(.asymmetric(insertion: .push(from: .leading), removal: .push(from: .trailing)))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
