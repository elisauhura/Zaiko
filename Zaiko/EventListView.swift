//
//  EventListView.swift
//  Zaiko
//
//  Created by Elisa Silva on 18/10/21.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var model: Zaiko
    var newEvent = Event.empty()
    
    @State var addNew = false
    
    var body: some View {
        NavigationView {
            List { ForEach(model.events.sorted { $0.timestamp < $1.timestamp }) { event in
                EventCellView(model:model, event:event)
            }}
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addNew.toggle()
                        newEvent.reset()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .popover(isPresented: $addNew) {
                CreateEventPopupView(newEvent: newEvent, model: model) {
                    addNew.toggle()
                }
            }
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(model: Zaiko.sample())
    }
}

struct EventCellView: View {
    @ObservedObject var model: Zaiko
    @ObservedObject var event: Event

    //@State var edit = false
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return NavigationLink(destination:
                        EventManageView(model: model, event: event)
                        //SheetItensView(model: model, sheet: sheet)
                        /*
        .popover(isPresented: $edit) {
            NavigationView {
                RenameSheetView(sheet: sheet)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                edit.toggle()
                            }) {
                                Text("Return")
                            }
                        }
                    }
            }.frame(minWidth: 300, minHeight: 300)
        }*/
        ) {
            HStack {
                Image(systemName: nameFor(eventType: event.type))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading) {
                    Text(event.name)
                        .font(.body)
                    Text(dateFormatter.string(from: event.timestamp))
                        .font(.footnote)
                }
                
            }
        }
    }
}

func nameFor(eventType: EventType) -> String {
    switch(eventType) {
    case .Check:
        return "text.badge.checkmark"
    case .Transaction:
        return "tray.2"
    case .Ingress:
        return "tray.and.arrow.down"
    case .Egress:
        return "tray.and.arrow.up"
    }
}


struct CreateEventPopupView: View {
    @ObservedObject var newEvent: Event
    @ObservedObject var model: Zaiko
    let dismiss: () -> ()
    
    var body: some View {
        NavigationView {
            CreateEventView(event: newEvent, model: model)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                            model.events.append(newEvent.copy())
                        }) {
                            Text("Create")
                        }
                        .disabled((newEvent.sheetA == nil &&
                                   newEvent.type != .Ingress) ||
                                  (newEvent.sheetB == nil &&
                                   newEvent.type != .Egress &&
                                   newEvent.type != .Check))
                    }
                }
        }.frame(minWidth: 300, minHeight: 500)
    }
}
