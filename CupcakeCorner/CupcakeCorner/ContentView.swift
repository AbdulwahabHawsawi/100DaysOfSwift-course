//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Abdulwahab Hawsawi on 11/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select Your Cake Type", selection: $order.type) {
                        ForEach (Order.types.indices) {
                            Text(Order.types[$0].capitalized)
                        }
                    }
                    
                    Stepper("Number of Cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Special Requests? ", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Extra Frosting", isOn: $order.extraFrosting)
                        Toggle("Add Sprinkes", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
            
        
        
    }
}
#Preview {
    ContentView()
}
