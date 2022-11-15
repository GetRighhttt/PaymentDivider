//
//  ContentView.swift
//  PaymentDivider
//
//  Created by Stefan Bayne on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    
    /*
     background gradient(optional)
     */
    let backgroundColor = LinearGradient(colors: [.white,.indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
    
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
    
    private func calculateTotal() -> Double {
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
                Section(header: Text("Enter your payment amount")) {
                    // basically an edit text
                    TextField("Amount:", text: $totalCost).keyboardType(.decimalPad)
                }
                /*
                 Next Tip Percentage spinner created.
                 */
                Section(header: Text("Select percentage you'd like to tip(%)")) {
                    // spinner in android/ drop down menu
                    Picker("Choose Tip Percentage Amount: ", selection: $tipIndex) {
                        ForEach(0 ..< tipPercentages.count, id: \.self) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(NavigationLinkPickerStyle())
                        .fixedSize()
                }
                /*
                 Determines how many people are present.
                 */
                Section(header: Text("Number of Guest Present")) {
                    Picker("Choose Guest:", selection: $people) {
                        ForEach(0 ..< 100, id: \.self) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(NavigationLinkPickerStyle())
                }
                Section(header: Text("Total Per Person")) {
                    //only want 2 decimal places.
                    Text("USD \(calculateTotal(), specifier: "%.2f")")
                }
            }.navigationTitle("Payment Divider")
                .foregroundColor(.black)
                .padding()
                .background(.gray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
