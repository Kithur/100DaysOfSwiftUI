//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Roberto Gutierrez on 08/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import SwiftUI

enum FilterEnum: String, CaseIterable {
    case beginsWith = "BEGINSWITH"
        case beginsWithCaseInsensitive = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsWithCaseInsensitive = "CONTAINS[c]"
    case endsWith = "ENDSWITH"
    case endsWithCaseInsensitive = "ENDSWITH[c]"
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    @State private var filterParameter = FilterEnum.beginsWith
    let arrayOfFilters: Array<FilterEnum> = FilterEnum.allCases
    
    let descriptorsArray = [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter, descriptorsArray: descriptorsArray, filterParameter: filterParameter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }

            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? self.moc.save()
            }

            Button("Show A") {
                self.lastNameFilter = self.determineFilter(letter: "A")
            }

            Button("Show S") {
                self.lastNameFilter = self.determineFilter(letter: "S")
            }
            
            Picker("Which filter should be used?", selection: $filterParameter) {
                ForEach(arrayOfFilters, id: \.self) { filter in
                    Text("\(filter.rawValue)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    func determineFilter(letter: String) -> String {
        switch filterParameter {
        case .beginsWith:
            return letter.capitalized
        case .contains:
            return letter
        default:
            return letter.lowercased()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
