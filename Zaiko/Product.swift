//
//  Product.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import Foundation
import SwiftUI

class Product: Identifiable, ObservableObject, Codable {
    var id: UUID;
    @Published var name: String
    @Published var description: String
    @Published var emoji: String
    
    init(id: UUID, name: String, description: String, emoji: String) {
        self.id = id
        self.name = name
        self.description = description
        self.emoji = emoji
    }
    
    static func sample() -> Product {
        return Product(id: UUID(), name: "Sample", description: "A sample product", emoji: "📦");
    }
    
    static func samples() -> [Product] {
        let emojis = ["🎊", "🛒", "🪞"]
        
        return [0,1,2,3,4,5,6,7,8,9].map{ i in return Product(id: UUID(), name: "Product \(i)", description: "ProductDescription", emoji: emojis.randomElement()!) }
    }
    
    static func empty() -> Product {
        return Product(id: UUID(), name: "", description: "", emoji: "");
    }
    
    func reset() {
        id = UUID()
        name = ""
        description = ""
        emoji = ""
    }
    
    func copy() -> Product {
        return Product(id: id, name: name, description: description, emoji: emoji)
    }
    
    enum ChildKeys: CodingKey {
        case id, name, description, emoji
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        let uuidString = try container.decode(String.self, forKey: .id)
        self.id = UUID(uuidString: uuidString)!
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.emoji = try container.decode(String.self, forKey: .emoji)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.id.uuidString, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.emoji, forKey: .emoji)
    }
}
