//
//  ContentView.swift
//  BetterSleep
//
//  Created by Abdulwahab Hawsawi on 25/02/2024.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    
    @State private var selectedCoffeeAmount = 0
    
    static var defaultWakeUp: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        return Calendar.current.date(from: component) ?? .now
    }
    
    var predictedSleep: Date {
        var sleepTime = Date.now
        do{
        let config = MLModelConfiguration()
        let model = try BetterSleepPredictor(configuration: config)
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
        //Model takes seconds. convert time to seconds
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60
        
        let prediction = try model.prediction(wake: Int64(Double(hour + minutes)), estimatedSleep: sleepAmount, coffee: Int64(selectedCoffeeAmount))
        
        sleepTime = wakeUp - prediction.actualSleep
        
    } catch { }
        
        return sleepTime

    }
    
    var body: some View {
        NavigationStack {
            Form{
                VStack {
                    VStack (alignment: .leading, spacing: 0 ){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Select a day and time", selection: $wakeUp, in: wakeUp..., displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack (alignment: .leading, spacing: 0 ){
                        Text("For how many hours would you like to sleep?")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    VStack (alignment: .leading, spacing: 0 ){
                        Text("How many coffee cups would you like to drink?")
                            .font(.headline)
                        Picker("^[\(selectedCoffeeAmount) cup](inflect: true)", selection: $selectedCoffeeAmount){
                            ForEach(0..<11){
                                Text("\($0)")
                            }
                        }
                    }
                    VStack{
                        Text("The recommended bedtime is:")
                        Text(predictedSleep.formatted(date: .omitted, time: .shortened))
                            .font(.largeTitle)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                .navigationTitle("BetterSleep")
            }
        }
    }
}

#Preview {
    ContentView()
}
