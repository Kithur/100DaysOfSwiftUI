//
//  ContentView.swift
//  Challenge4
//
//  Created by Roberto Gutiérrez on 29/09/20.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let id = UUID()
    let name: String
    var totalPracticeTime: String
    let description: String
}

class Activities: ObservableObject {
    @Published var activities: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    init() {
        if let activities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
                return
            }
        }
        
        self.activities = []
    }
    
}

struct ContentView: View {
    @ObservedObject var activities = Activities()
    @State private var isAddingShowing = false
    
    var body: some View {
        NavigationView {
            List(activities.activities) { activity in
                NavigationLink(destination: DescriptionView(activity: activity)) {
                    VStack(alignment: .leading) {
                        Text("\(activity.name)")
                            .font(.headline)
                        Text("Time: \(activity.totalPracticeTime)")
                    }
                }
                /*ForEach(activities.activities) { activity in
                    VStack(alignment: .leading) {
                        Text("\(activity.name)")
                            .font(.headline)
                        Text("Time: \(activity.totalPracticeTime)")
                    }
                }*/
            }
            .navigationBarTitle("HabitTracker")
            .navigationBarItems(trailing: Button(action: {
                    self.isAddingShowing = true
            })  {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isAddingShowing) {
                AddView(activities: self.activities)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
