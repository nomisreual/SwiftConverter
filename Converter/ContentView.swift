//
//  ContentView.swift
//  Converter
//
//  Created by Simon Antonius Lauer on 19.12.20.
//

import SwiftUI

struct ContentView: View {
    @State private var input = Temperatures.celsius
    @State private var output = Temperatures.celsius
    @State private var input_value = ""
    
    enum Temperatures: String, Identifiable, CaseIterable {
       
        var id: String {
            self.rawValue
        }
        
        case kelvin = "Kelvin"
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
    }
    
    
    var output_value: Double {
        
        let value = Double(input_value) ?? 0
        
        switch input {
        case .celsius:
            switch output {
            case .celsius:
                return value
            case .fahrenheit:
                return value * 1.8 + 32.0
            case .kelvin:
                return value + 273.15
            }
        case .fahrenheit:
            switch output {
            case .celsius:
                return (value - 32.0) * (5/9)
            case .fahrenheit:
                return value
            case .kelvin:
                return ((value - 32.0) * (5/9)) + 273.15
            }
        case .kelvin:
            switch output {
            case .celsius:
                return value - 273.15
            case .fahrenheit:
                return (value - 273.15) * 1.8 + 32.0
            case .kelvin:
                return value
            }
        }
    }
      
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose an Input type")) {
                    Picker("Choose", selection: $input) {
                        ForEach(Temperatures.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                Section(header: Text("Choose an output type")) {
                    Picker("Choose", selection: $output) {
                        ForEach(Temperatures.allCases) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Input", text: $input_value).keyboardType(.decimalPad)
                }
                Section(header: Text("Output")) {
                    switch output {
                    case .celsius:
                        Text("\(output_value, specifier: "%.2f") °C")
                    case .kelvin:
                        Text("\(output_value, specifier: "%.2f") °K")
                    case .fahrenheit:
                        Text("\(output_value, specifier: "%.2f") °F")
                    }
                }
            }
            .navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
