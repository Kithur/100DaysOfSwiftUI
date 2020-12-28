//
//  UserView.swift
//  Challenge5CoreDataVer
//
//  Created by Roberto Gutierrez on 27/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var fetchRequest: FetchRequest<User>
    var user: User? { fetchRequest.wrappedValue.first }
    
    var body: some View {
        Form {
            Section(header: Text("Personal info")) {
                Text("Email: " + (user?.wrappedEmail ?? "Unkwnown email") + "\n")
                Text("Address: " + (user?.wrappedAddress ?? "Unkwnon address"))
                Text("\nCompany: " + (user?.wrappedCompany ?? "Unkwnown company"))
                Text("Registered: " + (user?.wrappedRegistered ?? "Unknown registration date"))
            }
            
            Section(header: Text("Friends")) {
                List(user?.friendsArray ?? [], id: \.wrappedId) { friend in
                    NavigationLink(destination: UserView(userId: friend.wrappedId)) {
                        Text(friend.wrappedName)
                    }
                }
            }
        }
        .navigationBarTitle((user?.wrappedName ?? "Unkwnown user") + ", \(user?.wrappedAge ?? 0)")
    }
    
    init(userId: String) {
        fetchRequest = FetchRequest<User>(entity: User.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %@", "id", userId))
    }
}

