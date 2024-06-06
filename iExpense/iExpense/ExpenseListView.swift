//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Abdulwahab Hawsawi on 24/04/2024.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Query var expenseListQuery: [ExpenseList]
    @Environment(\.modelContext) var modelContext
    
    var expensesList: [Expense] {
        expenseListQuery.first?.items ?? [Expense]()
    }
    
    @State private var listFilter: ExpenseType = .none
    @State private var sortingByAmount = false
    
    var filteredSortedExpenses: [Expense] {
        let filteredList = expensesList.filter {
            if listFilter == .none {
                return true
            }
            
            if $0.type == listFilter.rawValue {
                return true
            } else {
                return false
            }
        }
        
        return filteredList.sorted {
            if sortingByAmount {
                return $0.amount > $1.amount
            } else {
                return $0.name < $1.name
            }
        }
    }
    
    var body: some View {
        List {
            Picker("Type", selection: $listFilter) {
                Text("no filter".capitalized)
                    .tag(ExpenseType.none)
                
                ForEach(ExpenseType.allCases.filter{$0 == .none ? false : true}) {
                    Text($0.rawValue.capitalized)
                        .tag($0)
                }
            }
            .pickerStyle(.palette)
            
            ForEach (filteredSortedExpenses) { item in
                HStack {
                    VStack (alignment: .leading) {
                        Text("\(item.name)")
                        Text("\(item.type)")
                            .fontWeight(.light)
                    }
                    Spacer()
                    VStack {
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "SAR"))
                        /**If the amount is less than 10, color it green. Else, check if it is less than 100. If it is, color it black. Else, it is more than 100, which means color it red**/
                            .foregroundStyle(item.amount < 10 ? .green : item.amount < 100 ? .black : .red)
                    }
                }
            }
            .onDelete(perform: deleteExpense)
        }
        .toolbar {
            ToolbarItem (placement: .topBarTrailing) {
                NavigationLink {
                    AddExpense()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                Button(sortingByAmount ? "Sort by Name" : "Sort by amount") {
                    sortingByAmount.toggle()
                }
            }
        }
    }
    
    init(sortingByAmount: Bool = false, filter: ExpenseType = .none) {
        
        listFilter = filter
        self.sortingByAmount = sortingByAmount
    }
    
    func deleteExpense(at offsets: IndexSet) {
        var offsetsWithoutFilter = IndexSet()
        
        /*Because the user may apply a filter when viewing the list, the user may also perfrom
         deletion while viewing the filter
         
         This is problamatic because the array to display items when applying a filter may be
         different from the actual unfiltered array. The if-condition below will apply the correct mapping from the filtered array indices to the unfiltered array indices*/
        if !offsets.isEmpty {
            for index in offsets {
                let itemFromFilteredList = filteredSortedExpenses[index]
                let indexInOriginalList = expenseListQuery.first!.items.firstIndex(where: {$0.id == itemFromFilteredList.id})
                offsetsWithoutFilter.insert(indexInOriginalList!)
            }
            
            
        }
        expenseListQuery.first!.items.remove(atOffsets: offsetsWithoutFilter)
    }
}


#Preview {
    ExpenseListView()
}
