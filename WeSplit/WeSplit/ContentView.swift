//
//  ContentView.swift
//  WeSplit
//
//  Created by Abdulwahab Hawsawi on 02/12/2022.
//

import SwiftUI

struct ContentView: View {
	@FocusState private var isMoneyFieldInFocus: Bool
	@State private var money = 100.0
	private var userCuurency = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "SAR")
	@State private var numberOfPeopleSelector = 2 // This chooses the third option (counting from 0)
	@State private var tipPercentage = 20
	//let possibleTips = [0, 5, 10, 15, 20, 25]
	var grandTotal: Double {
		
		let tipAmount = (money / 100) * Double(tipPercentage)
		return money + tipAmount
	}
	var totalPerPerson: Double{
		
		let peopleCount = Double(numberOfPeopleSelector + 2)
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
	var body: some View {
		NavigationStack{
			Form{
				Section{
					TextField("Check Amount", value: $money, format: userCuurency)
						.keyboardType(.decimalPad)
						.focused($isMoneyFieldInFocus)
					Picker("How many people are paying?", selection: $numberOfPeopleSelector) {
						ForEach((2..<100)){
							Text("\($0)")
						}
					}
				}
				Section{
					Picker("Tip Percentage", selection: $tipPercentage){
						ForEach(0..<101){
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.navigationLink)
				}  header: {
					Text("What is the tip percentage?")
					
				}
				
				Section{
					Text(grandTotal, format: userCuurency)
				} header: {
					Text("Grand total")
				}
				
				Section{
					Text((totalPerPerson), format: userCuurency)
				} header: {
					Text("Amount per Person")
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard){
					Spacer()
					Button("Done"){
						isMoneyFieldInFocus = false
					}
				}
			}
		}
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
