//
//  LocalUsers.swift
//  Challenge5CoreDataVer
//
//  Created by Roberto Gutierrez on 25/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class Users {
    static func loadDataToCD(moc: NSManagedObjectContext) {
        loadDataFromJSON { (users) in
            DispatchQueue.main.async {
                var tempUsers = [User]()
                for user in users {
                    let newUser = User(context: moc)
                    newUser.name = user.name
                    newUser.id = user.id
                    newUser.company = user.company
                    newUser.isActive = user.isActive
                    newUser.age = Int16(user.age)
                    newUser.email = user.email
                    newUser.address = user.address
                    newUser.registered = user.registered
                    tempUsers.append(newUser)
                }
                
                for i in 0..<users.count {
                    for friend in users[i].friends {
                        let newFriend = Friend(context: moc)
                        newFriend.name = friend.name
                        newFriend.id = friend.id
                        
                        tempUsers[i].addToFriends(newFriend)
                    }
                }
                
                do {
                    try moc.save()
                } catch let error {
                    print("Could not save data \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func loadDataFromJSON(completion: @escaping ([LocalUser]) -> ()) {
        let strURL = "https://www.hackingwithswift.com/samples/friendface.json"
        guard let url = URL(string: strURL) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No response \(error?.localizedDescription ?? "No data in response")")
                return
            }
            
            if let decoderLocalUser = try? JSONDecoder().decode([LocalUser].self, from: data) {
                completion(decoderLocalUser)
            }
        }.resume()
        
    }
}
