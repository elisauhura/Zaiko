//
//  Product.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import Foundation

class Product: Identifiable {
    let id: NSUUID;
    var name: String;
    var description: String;
    
    init(id: NSUUID, name: String, description: String) {
        self.id = id;
        self.name = name;
        self.description = description;
    }
    
    static func sample() -> Product {
        return Product(id: NSUUID(), name: "Sample", description: "A sample product");
    }
    
    static func samples() -> [Product] {
        return [Int].init(repeating: 0, count: 10).map{ _ in return Product.sample() }
    }
}
