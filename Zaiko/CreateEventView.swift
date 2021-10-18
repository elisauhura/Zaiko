//
//  EventDetailEditorView.swift
//  Zaiko
//
//  Created by Elisa Silva on 18/10/21.
//

import SwiftUI

struct CreateEventView: View {
    @ObservedObject var event: Event
    @ObservedObject var model: Zaiko
    
    var body: some View {
        Form {
            TextField("Event name", text: $event.name)
            DatePicker(selection: $event.timestamp, label: { Text("Date") })
            
            Section {
                Picker("Event Type", selection: $event.type) {
                    Text("Check").tag(EventType.Check)
                    Text("Transaction").tag(EventType.Transaction)
                    Text("Ingress").tag(EventType.Ingress)
                    Text("Egress").tag(EventType.Egress)
                }
            }
            
            Section {
                if event.type != .Ingress {
                    Picker("Source Sheet", selection: $event.sheetA) {
                        Text("None").tag(nil as UUID?)
                        ForEach(model.book) {
                            Text($0.name).tag($0.id as UUID?)
                        }
                    }
                }
                if event.type != .Check && event.type != .Egress {
                    Picker("Target Sheet", selection: $event.sheetB) {
                        Text("None").tag(nil as UUID?)
                        ForEach(model.book) {
                            Text($0.name).tag($0.id as UUID?)
                        }
                    }
                }
            }
        }
    }
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateEventView(event: Event.sample(), model: Zaiko.sample())
        }
    }
}
