//
//  ContentView.swift
//  Challenge5CoreDataVer
//
//  Created by Roberto Gutierrez on 25/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: UserView(userId: user.wrappedId)) {
                    VStack(alignment: .leading) {
                        Text("\(user.wrappedName)" + ", \(String(user.wrappedAge))")
                            .font(.headline)
                        Text("\(user.wrappedCompany), \(user.wrappedEmail)")
                    }
                }
            }
            .navigationBarTitle("UserList")
        }
        .onAppear{
            if self.users.isEmpty {
                print("Users is empty \(self.users)")
                Users.loadDataToCD(moc: self.moc)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
