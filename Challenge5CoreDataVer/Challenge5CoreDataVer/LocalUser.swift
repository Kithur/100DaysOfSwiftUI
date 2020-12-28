//
//  LocalUser.swift
//  Challenge5CoreDataVer
//
//  Created by Roberto Gutierrez on 25/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import Foundation
import SwiftUI

struct LocalUser: Codable, Identifiable {
    var id: String?
    var name: String?
    var age: Int
    var company: String?
    var isActive: Bool
    var friends: [LocalFriend]
    var email: String?
    var address: String?
    var registered: String?
}

struct LocalFriend: Codable, Identifiable {
    var id: String?
    var name: String?
}
