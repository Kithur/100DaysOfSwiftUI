//
//  AddView.swift
//  Challenge4
//
//  Created by Roberto Gutiérrez on 29/09/20.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities = Activities()
    @State private var name = ""
    @State private var hours = "0"
    @State private var minutes = "00"
    @State private var description = ""
    
    static let hourOptions = ["00", "1", "2", "3", "4"]
    static let minuteOptions = ["00", "15", "30", "45"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity name", text: $name)
                Picker("Hours", selection: $hours) {
                    ForEach(Self.hourOptions, id: \.self) {
                        Text($0)
                    }
                }
                Picker("Minutes", selection: $minutes) {
                    ForEach(Self.minuteOptions, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add a new activity")
            .navigationBarItems(trailing: Button("Save") {
                if name != "" && description != "" {
                    let activity = Activity(name: self.name, totalPracticeTime: "\(self.hours):\(self.minutes)", description: self.description)
                    self.activities.activities.append(activity)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
