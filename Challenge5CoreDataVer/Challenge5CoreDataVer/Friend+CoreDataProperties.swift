//
//  Friend+CoreDataProperties.swift
//  Challenge5CoreDataVer
//
//  Created by Roberto Gutierrez on 25/11/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: User?

    public var wrappedId: String {
        id ?? "Unknown id"
    }
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
}
