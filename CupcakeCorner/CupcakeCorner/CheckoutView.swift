//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Abdulwahab Hawsawi on 12/04/2024.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var alertMessage = ""
    @State private var isShowingConfirmationAlert = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
            }
            
            Text("You cost is \(order.cost, format: .currency(code: Locale.current.currency?.identifier ?? "SAR"))")
                .font(.title)
            
            Button ("Place Order") {
                Task {
                    await uploadOrder()
                }
            }
            .padding()
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You!", isPresented: $isShowingConfirmationAlert) {
            
        }
    }
    
    func uploadOrder() async {
        guard let orderAsJSON = try? JSONEncoder().encode(order) else {
            print("An error occured while encoding the order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("Applicaiton/JSON", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: orderAsJSON)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            alertMessage = "You order of \(decodedOrder.quantity)x \(Order.types[decodedOrder.type]) cakes is on its way!"
            
            isShowingConfirmationAlert = true
            
        } catch {
            print("An error occured while sending the order \n \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
