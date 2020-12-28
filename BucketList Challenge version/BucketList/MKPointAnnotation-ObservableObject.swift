//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Roberto Gutierrez on 21/12/20.
//  Copyright © 2020 Roberto Gutierrez. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unkwnown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unkwnown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
