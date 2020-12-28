//
//  ContentView.swift
//  Challenge5
//
//  Created by Roberto Gutierrez on 12/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: UserView(user: user, userFriends: self.users, users: self.users)) {
                    VStack(alignment: .leading) {
                        Text("\(user.name)" + ", \(String(user.age))")
                            .font(.headline)
                        Text("\(user.company), \(user.email)")
                    }
                }
            }
            .navigationBarTitle("UserList")
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("We have data")
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    print("We decoded the data")
                    DispatchQueue.main.async {
                        print("We are returning main thread")
                        self.users = decodedResponse
                        debugPrint(self.users)
                    }
                    return
                }
            }
            print("There was an error: \(error?.localizedDescription ?? "Unkwnown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
