//
//  Event.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import Foundation

enum EventType: String {
    case Check = "check"
    case Transaction = "transaction"
    case Ingress = "ingress"
    case Egress = "egress"
}

class Event: ObservableObject, Codable, Identifiable {
    @Published var name: String
    @Published var id: UUID
    @Published var timestamp: Date
    @Published var itemList: [UUID: Int]
    @Published var type: EventType
    @Published var submitted: Bool
    @Published var sheetA: UUID?
    @Published var sheetB: UUID?
    
    init(name: String, id: UUID, type: EventType, timestamp: Date, itemList: [UUID: Int], sheetA: UUID? = nil, sheetB: UUID? = nil, submitted: Bool = false) {
        self.name = name
        self.timestamp = timestamp
        self.type = type
        self.itemList = itemList
        self.sheetA = sheetA
        self.sheetB = sheetB
        self.submitted = submitted
        self.id = id
    }
    
    static func sample() -> Event {
        return Event(name: "Sample Event", id: UUID(), type: .Transaction, timestamp: Date(), itemList: [:])
    }
    
    static func samples(model: Zaiko) -> [Event] {
        var ret = [Event]()
        for i in 0..<5 {
            ret.append(Event(name: "Sample Event \(i)", id: UUID(), type: [.Transaction, .Check, .Ingress, .Egress].randomElement()!
                             , timestamp: Date(), itemList: [:], sheetA: model.book.randomElement()?.id, sheetB: model.book.randomElement()?.id, submitted: false))
        }
        
        return ret
    }
    
    static func empty() -> Event {
        Event(name: "", id: UUID(), type: .Transaction, timestamp: Date(), itemList: [:])
    }
    
    func reset() {
        name = ""
        id = UUID()
        type = .Transaction
        timestamp = Date()
        itemList = [:]
        submitted = false
        sheetA = nil
        sheetB = nil
    }
    
    func copy() -> Event {
        return Event(name: name, id: id, type: type, timestamp: timestamp, itemList: itemList, sheetA: sheetA, sheetB: sheetB, submitted: submitted)
    }
    
    enum ChildKeys: CodingKey {
        case name, id, timestamp, itemList, type, submitted, sheetA, sheetB
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.type = EventType(rawValue: try container.decode(String.self, forKey: .type))!
        self.itemList = try container.decode([UUID: Int].self, forKey: .itemList)
        self.sheetA = try container.decode(UUID?.self, forKey: .sheetA)
        self.sheetB = try container.decode(UUID?.self, forKey: .sheetB)
        self.submitted = try container.decode(Bool.self, forKey: .submitted)
        self.id = try container.decode(UUID.self, forKey: .sheetB)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.timestamp, forKey: .timestamp)
        try container.encode(self.itemList, forKey: .itemList)
        try container.encode(self.type.rawValue, forKey: .type)
        try container.encode(self.submitted, forKey: .submitted)
        try container.encode(self.sheetA, forKey: .sheetA)
        try container.encode(self.sheetB, forKey: .sheetB)
    }
}
