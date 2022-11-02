//
//  ContentView.swift
//  PaymentDivider
//
//  Created by Stefan Bayne on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    
    /*'
     First we create four variables that we are going
     to use.
     */
    @State private var totalCost = ""
    @State private var people = 4
    @State private var tipIndex = 2
    let tipPercentages =  [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80,  90, 100]
    
    /*
     Now we create the method to calculate the total cost.
     */
    
    func calculateTotal() -> Double {
        let tip = Double(tipPercentages[tipIndex])
        let orderTotal = Double(totalCost) ?? 0 // checks value, if nothing 0
        
        let finalAmount = ((orderTotal / 100 * tip) + orderTotal)
        
        return finalAmount / Double(people)
    }
    
    /*
     Here is where we create the UI.
     */
    var body: some View {
    // allows us to create screens that change around
        NavigationView {
            /*
             This is where we seen the gray background show after the title in the simulator.
             */
            Form {
                /*
                 First Edit text field created.
                 */
                Section(header: Text("Enter an amount")) {
                    // basically an edit text
                    TextField("Amount:", text: $totalCost).keyboardType(.decimalPad)
                }
                /*
                 Next Tip Percentage spinner created.
                 */
                Section(header: Text("Select a tip amount (%)")) {
                    // spinner in android/ drop down menu
                    Picker("Tip Percentage: ", selection: $tipIndex) {
                        ForEach(0 ..< tipPercentages.count, id: \.self) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(WheelPickerStyle())
                        .fixedSize()
                }
                /*
                 Determines how many people are present.
                 */
                Section(header: Text("Number of Guest Present")) {
                    Picker("Guest present:", selection: $people) {
                        ForEach(0 ..< 31, id: \.self) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(NavigationLinkPickerStyle())
                }
                Section(header: Text("Total Per Person")) {
                    //only want 2 decimal places.
                    Text("USD \(calculateTotal(), specifier: "%.2f")")
                }
            }.navigationTitle("Payment Divider")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
