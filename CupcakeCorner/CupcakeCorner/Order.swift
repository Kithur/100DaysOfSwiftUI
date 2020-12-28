//
//  Order.swift
//  CupcakeCorner
//
//  Created by Roberto Gutiérrez on 03/10/20.
//

import Foundation

struct OrderStr: Codable {
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        /*
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
        */
        case order
    }
        
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order = OrderStr()
    
    /*@Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    */
    
    var hasValidAddress: Bool {
        if order.name.isEmpty || order.streetAddress.isEmpty || order.city.isEmpty || order.zip.isEmpty || isItWhitespace(object: order.name) || isItWhitespace(object: order.streetAddress) || isItWhitespace(object: order.city) || isItWhitespace(object: order.zip) {
                return false
        }
        
        return true
    }
    
    var cost: Double {
        var cost = Double(order.quantity) * 2
        cost += Double(order.type) / 2
        
        if order.extraFrosting {
            cost += Double(order.quantity)
        }
        
        if order.addSprinkles {
            cost += Double(order.quantity) / 2
        }
        
        return cost
    }
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        order = try container.decode(OrderStr.self, forKey: .order)
        /*type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)*/
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
        /*
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip) */
    }
    
    func isItWhitespace(object: String) -> Bool {
        let array = object.components(separatedBy: " ")
        
        if array.isEmpty || array[0] == "" {
            return true
        }
        
        return false
    }
}
