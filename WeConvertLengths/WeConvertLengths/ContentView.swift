//
//  ContentView.swift
//  WeConvertLengths
//
//  Created by Abdulwahab Hawsawi on 30/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var userLength: Double = 0.rounded()
    
    var userLengthInMeters: Double {
        switch (selectedUnit) {
            case "Inch":
                return userLength * 0.0254
            case "Centimeter":
                return userLength / 100
            case "Feet":
                return userLength * 0.3048
            case "Meter":
                return userLength
            default:
                return 0
        }
    }
    
    let lengthUnits = ["Inch", "Centimeter", "Feet", "Meter"]
    @State var selectedUnit = ""
    @State var convertToUnit = ""
    var convertedUserLength: Double {
        switch (convertToUnit) {
            case "Inch":
                return userLengthInMeters / 0.0254
            case "Centimeter":
                return userLengthInMeters * 100
            case "Feet":
                return userLengthInMeters / 0.3048
            case "Meter":
                return userLength
            default:
                return 0
        }

    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Type Length Here", value: $userLength, format: .number)
                        .keyboardType(.decimalPad)
                    Picker("Unit to convert from", selection: $selectedUnit) {
                        ForEach(lengthUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onAppear{
                        selectedUnit = "Inch"
                    }
                } header: {
                    Text("Convert from")
                }
                
                Section{
                    Picker("Unit to convert from", selection: $convertToUnit) {
                        ForEach(lengthUnits, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onAppear{
                        convertToUnit = "Centimeter"
                    }
                    
                    Text("\(userLength.formatted()) \(selectedUnit) in \(convertToUnit) equals: ")
                    HStack{
                        Spacer()
                        Text("\(convertedUserLength.formatted())")
                            .foregroundColor(.green)
                        Spacer()
                    }
                } header: {
                    Text("Convert to")
                }
            }
            .navigationTitle("WeConvertLengths")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
