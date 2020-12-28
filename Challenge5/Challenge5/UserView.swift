//
//  UserView.swift
//  Challenge5
//
//  Created by Roberto Gutierrez on 13/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let user: User
    let userFriends: [User]
    let users: [User]
    
    var body: some View {
        Form {
            Section {
                Text(user.email + "\n" + user.address + "\nCompany: " + user.company)
                Text(user.about)
                Text(user.registered)
            }

            Section {
                List(userFriends, id: \.id) { friend in
                    NavigationLink(destination: UserView(user: friend, userFriends: self.users, users: self.users)) {
                    VStack(alignment: .leading) {
                    Text("\(friend.name)" + ", \(String(friend.age))")
                        .font(.headline)
                    Text("\(friend.company), \(friend.email)")                    }
                }
                }
            }
        }
        .navigationBarTitle(user.name + ", " + String(user.age))
    }
    
    init(user: User, userFriends: [User], users: [User]) {
        self.user = user
        self.users = users
        
        var matches = [User]()
        
        for friend in user.friends {
            if let match = userFriends.first(where: { $0.id == friend.id }) {
                matches.append(match)
            } else {
                fatalError("Missing \(friend)")
            }
        }
        
        self.userFriends = matches
    }
}

