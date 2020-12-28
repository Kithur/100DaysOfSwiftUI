//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Roberto Gutierrez on 11/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    //@State private var filterParameter = ".BEGINSWITH"
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, descriptorsArray: [NSSortDescriptor], filterParameter: FilterEnum, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: descriptorsArray, predicate: NSPredicate(format: "%K \(filterParameter.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
}
