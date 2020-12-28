//
//  ContentView.swift
//  Moonshot
//
//  Created by Roberto Gutiérrez on 21/09/20.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isLaunchDateShowing = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width:44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.isLaunchDateShowing ? mission.formattedLaunchDate : self.getCrew(mission: mission))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Switch") {
                self.isLaunchDateShowing.toggle()
            })
        }
    }
    
    func getCrew(mission: Mission) -> String {
        var memberString = ""
        
        for member in mission.crew {
            memberString = (memberString == "" ? memberString + member.name.capitalized : memberString + ", \(member.name.capitalized)")
        }
        return memberString
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
