//
//  ContentView.swift
//  Challenge1
//
//  Created by Roberto Gutiérrez on 31/08/20.
//  Copyright © 2020 Roberto Gutiérrez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = ""
    @State private var inputScale = 1
    @State private var outputScale = 1
    
    let tempScales = ["Kelvin", "Fahrenheit", "Celsius"]
    
    var inputTemperatureDouble: Double {
        let temperatureDouble = Double(inputTemperature) ?? 0
        return temperatureDouble
    }
    
    var outputTemperatureKelvin: Double {
        if inputScale == 0 {
            let outTemp = inputTemperatureDouble
            return outTemp
        } else if inputScale == 1 {
            let outTemp = (inputTemperatureDouble + 459.67) * (5 / 9)
            return outTemp
        } else if inputScale == 2 {
            let outTemp = inputTemperatureDouble + 273.15
            return outTemp
        }
        return 0
    }
    
    var outputTemperatureFinal: Double {
        if outputScale == 0 {
            let outTempFinal = outputTemperatureKelvin
            return outTempFinal
        } else if outputScale == 1 {
            let outTempFinal = (outputTemperatureKelvin * (9 / 5)) - 459.67
            return outTempFinal
        } else if outputScale == 2 {
            let outTempFinal = outputTemperatureKelvin - 273.15
            return outTempFinal
        }
        return 0
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("Which is the temperature to convert?", text: $inputTemperature)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Which is the input scale?")) {
                    Picker("Initial unit", selection: $inputScale) {
                        ForEach(0 ..< tempScales.count) {
                            Text("\(self.tempScales[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Which is the output scale?")) {
                    Picker("Output unit", selection: $outputScale) {
                        ForEach(0 ..< tempScales.count) {
                            Text("\(self.tempScales[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Your converted temperature is:")) {
                    Text("\(outputTemperatureFinal, specifier: "%.3f") \(tempScales[outputScale]) degrees")
                }
            }
        .navigationBarTitle("TempConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
