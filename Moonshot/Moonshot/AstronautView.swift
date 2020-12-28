//
//  AstronautView.swift
//  Moonshot
//
//  Created by Roberto Gutiérrez on 23/09/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    let matchMissions: [String]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Mission Participation History")
                        .font(.title)
                    
                    ForEach(0 ..< self.matchMissions.count) {
                        Text(self.matchMissions[$0])
                        
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions
        
        var matches = [String]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    matches.append(mission.displayName)
                }
            }
        }
        
        self.matchMissions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
