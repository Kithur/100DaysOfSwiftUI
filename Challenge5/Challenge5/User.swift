//
//  User.swift
//  Challenge5
//
//  Created by Roberto Gutierrez on 12/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import Foundation

struct Response: Codable {
    var users: [User]
}

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}
