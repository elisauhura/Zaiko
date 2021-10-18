//
//  Zaiko.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import Foundation
import SwiftUI

class Zaiko: ObservableObject, Codable {
    @Published var products: [Product]
    @Published var book: [Sheet] = []
    @Published var events: [Event] = []
    
    init(products: [Product], book: [Sheet], events: [Event]) {
        self.products = products
        self.book = book
        self.events = events
    }
    
    static func sample() -> Zaiko {
        let sampleProducts = Product.samples()
        var sheets = [Sheet]()
        for i in 0..<5 {
            var entries = [UUID: Int]()
            for _ in 0..<3 {
                entries[sampleProducts.randomElement()!.id] = Int.random(in: 1...10)
            }
            sheets.append(Sheet(id: UUID(), name: "Sheet \(i)", entries: entries))
        }
        let ret = Zaiko(products: sampleProducts, book: sheets, events: [])
        
        ret.events = Event.samples(model: ret)
        
        return ret
    }
    
    static func empty() -> Zaiko {
        return Zaiko(products: [], book: [], events: [])
    }
    
    func append(_ product: Product) {
        self.objectWillChange.send()
        self.products.append(product)
    }
    
    enum ChildKeys: CodingKey {
        case products, book, events
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.products = try container.decode([Product].self, forKey: .products)
        self.book = try container.decode([Sheet].self, forKey: .book)
        self.events = try container.decode([Event].self, forKey: .events)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.products, forKey: .products)
        try container.encode(self.book, forKey: .book)
        try container.encode(self.events, forKey: .events)
    }
    
    var encoded: Data {
        get {
            let enconder = JSONEncoder()
            let data = try! enconder.encode(self)
            return data
        }
    }
    
    static func decode(data: Data) -> Zaiko? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Zaiko.self, from: data)
    }
    
    func productWith(id: UUID) -> Product {
        return products.filter { $0.id == id }.first!
    }
    
    func sheetWith(id: UUID) -> Sheet {
        return book.filter { $0.id == id }.first!
    }
    
    func itensFor(sheet: Sheet) -> [UUID] {
        return Array(sheet.entries.keys).sorted {
            productWith(id: $0).name < productWith(id: $1).name
        }
    }
    
    func bookEntries() -> [UUID: Int] {
        var entries: [UUID: Int] = [:]
        for sheet in book {
            for (key, value) in sheet.entries {
                entries[key] = (entries[key] ?? 0) + value
            }
        }
        
        return entries
    }
}
