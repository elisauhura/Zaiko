//
//  Sheet.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import Foundation

class Sheet: Identifiable, ObservableObject, Codable {
    @Published var entries: [UUID: Int]
    @Published var name: String
    @Published var id: UUID
    
    init(id: UUID, name: String, entries: [UUID: Int]) {
        self.entries = entries
        self.name = name
        self.id = id
    }
    
    enum ChildKeys: CodingKey {
        case entries, name, id
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ChildKeys.self)
        self.entries = try container.decode([UUID: Int].self, forKey: .entries)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(UUID.self, forKey: .id)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ChildKeys.self)
        try container.encode(self.entries, forKey: .entries)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.id, forKey: .id)
    }
    
    static func sample() -> Sheet {
        return Sheet(id: UUID(), name: "Sample Sheet", entries: [:])
    }
    
    static func empty() -> Sheet {
        return Sheet(id: UUID(), name: "", entries: [:])
    }
    
    func copy() -> Sheet {
        return Sheet(id: self.id, name: self.name, entries: self.entries)
    }
    
    func reset() {
        self.id = UUID()
        self.name = ""
        self.entries = [:]
    }
}
