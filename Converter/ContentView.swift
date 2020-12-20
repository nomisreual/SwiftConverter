//
//  ContentView.swift
//  Converter
//
//  Created by Simon Antonius Lauer on 19.12.20.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0
    @State private var output = 0
    @State private var input_value = ""
    @State private var temp = Temperatures.celsius
    
    enum Temperatures: String {
        case kelvin
        case celsius
        case fahrenheit
    }
    

    let temps = ["Celsius", "Fahrenheit", "Kelvin"]
    
    
    
    var output_value: Double {
        let chosen_in = temps[input]
        let chosen_out = temps[output]
        
        let value = Double(input_value) ?? 0
        
        switch chosen_in {
        case "Celsius":
            switch chosen_out {
            case "Celsius":
                return value
            case "Fahrenheit":
                return value * 1.8 + 32.0
            case "Kelvin":
                return value + 273.15
            default:
                return 0
            }
        case "Fahrenheit":
            switch chosen_out {
            case "Celsius":
                return (value - 32.0) * (5/9)
            case "Fahrenheit":
                return value
            case "Kelvin":
                return ((value - 32.0) * (5/9)) + 273.15
            default:
                return 0
            }
        case "Kelvin":
            switch chosen_out {
            case "Celsius":
                return value - 273.15
            case "Fahrenheit":
                return (value - 273.15) * 1.8 + 32.0
            case "Kelvin":
                return value
            default:
                return 0
            }
        default:
            return 0
        }
    }
      
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose an Input type")) {
                    Picker("Input", selection: $input) {
                        ForEach(0 ..< temps.count) {
                            Text("\(self.temps[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Choose an output type")) {
                    Picker("Output", selection: $output) {
                        ForEach(0 ..< temps.count) {
                            Text("\(self.temps[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Input", text: $input_value).keyboardType(.decimalPad)
                }
                Section(header: Text("Output")) {
                    switch output {
                    case 0:
                        Text("\(output_value, specifier: "%.2f") °C")
                    case 1:
                        Text("\(output_value, specifier: "%.2f") °F")
                    default:
                        Text("\(output_value, specifier: "%.2f") °K")
                    }
                }
                Section {
                    Picker("Choose", selection: $temp) {
                        Text("Celsius").tag(Temperatures.celsius)
                        Text("Kelvin").tag(Temperatures.kelvin)
                        Text("Fahrenheit").tag(Temperatures.fahrenheit)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(temp.rawValue.capitalized)")
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
