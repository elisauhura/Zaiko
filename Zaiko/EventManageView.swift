//
//  EventManageView.swift
//  Zaiko
//
//  Created by Elisa Silva on 18/10/21.
//

import SwiftUI

struct EventManageView: View {
    @ObservedObject var model: Zaiko
    @ObservedObject var event: Event
    
    @State var addProduct: Bool = false
    @State var editQuantity: Bool = false
    @State var showingAlert: Bool = false
    @State var uuid: UUID = UUID()
    
    var uuids: [UUID] {
        event.itemList.keys.sorted { model.productWith(id: $0).name < model.productWith(id: $1).name }
    }
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        
        return List {
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
            if !event.submitted {
                Text("In progress")
            } else {
                Text("Submitted")
            }
            
            if(event.type != .Ingress) {
                Section("Source") {
                    SheetCellView(model: model, sheet: model.sheetWith(id: event.sheetA!))
                }
            }
            
            if(event.type != .Egress && event.type != .Check) {
                Section("Target") {
                    SheetCellView(model: model, sheet: model.sheetWith(id: event.sheetB!))
                }
            }
            
            Section("Products") {
                ForEach(uuids) { id in
                    let product = model.productWith(id: id)
                    let count = event.itemList[id]!
                    
                    HStack {
                        Text(product.emoji)
                            .font(.system(size: 32))
                            .background(
                                Circle()
                                    .frame(width: 42, height: 42)
                                    .foregroundColor(Color(white: 0.8))
                        ).frame(width: 42, height: 42)
                        VStack(alignment: .leading){
                            Text(product.name)
                                .font(.body)
                            Text(product.description)
                                .font(.footnote)
                        }
                        Spacer()
                        if(!event.submitted) {
                            Button(action: {
                                uuid = id
                                editQuantity.toggle()
                            }) {
                                Text("\(count)")
                                    .font(.system(size: 32))
                            }
                        } else {
                            Text("\(count)")
                                .font(.system(size: 32))
                        }
                        
                    }
                    .padding(.all)
                }.onDelete { indexSet in
                    let ids = uuids
                    let toRemove = indexSet.map{ ids[$0] }
                    toRemove.forEach { event.itemList.removeValue(forKey: $0) }
                }
            }
            
            if !event.submitted {
                Button(action: {
                    if checkIfCanSubmitEvent() {
                        submitEvent()
                    } else {
                        showingAlert.toggle()
                    }
                }) {
                    Text("Submit")
                }.alert("Event could not be submitted", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !event.submitted {
                    NavigationLink(destination: ProductListToAddView(model: model, event: event, handler: {
                        event.itemList[$0.id] = 0
                        addProduct.toggle()
                    }), isActive: $addProduct) {
                        Image(systemName: "plus")
                    }
                }
            }
        }.popover(isPresented: $editQuantity) {
            NavigationView {
                Form {
                    Stepper("\(event.itemList[uuid] ?? 0)", onIncrement: {
                        event.itemList[uuid] = 1 +  (event.itemList[uuid] ?? 0)
                    }, onDecrement: {
                        event.itemList[uuid] = max(-1 + (event.itemList[uuid] ?? 0), 0)
                    })
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button(action: {
                                event.itemList.removeValue(forKey: uuid)
                                editQuantity.toggle()
                            }) {
                                Text("Delete")
                            }
                            Button(action: {
                                editQuantity.toggle()
                            }) {
                                Text("Return")
                            }
                        }
                    }
                }
            }.frame(minWidth: 300, minHeight: 300)
        }
    }
    
    func checkIfCanSubmitEvent() -> Bool {
        if(event.type == .Egress || event.type == .Transaction) {
            let sheetA = model.sheetWith(id: event.sheetA!)
            for productId in event.itemList.keys {
                if !sheetA.entries.keys.contains(productId) ||
                    sheetA.entries[productId]! < event.itemList[productId]! {
                    return false
                }
            }
        }
        return true
    }
    
    func submitEvent() {
        if(event.type == .Check) {
            let sheet = model.sheetWith(id: event.sheetA!)
            for productId in event.itemList.keys {
                sheet.entries[productId] = event.itemList[productId]
            }
        } else {
            if(event.type != .Ingress) {
                let src = model.sheetWith(id: event.sheetA!)
                for productId in event.itemList.keys {
                    src.entries[productId] = src.entries[productId]! - event.itemList[productId]!
                }
            }
            if(event.type != .Egress) {
                let tgt = model.sheetWith(id: event.sheetB!)
                for productId in event.itemList.keys {
                    tgt.entries[productId] = (tgt.entries[productId] ?? 0) + event.itemList[productId]!
                }
            }
        }
        
        event.submitted = true
    }
}

struct EventManageView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Zaiko.sample()
        model.events[0].itemList = model.book[0].entries
        
        return NavigationView {
            EventManageView(model: model, event: model.events[0])
        }
        
    }
}
