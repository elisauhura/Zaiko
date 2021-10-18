//
//  BookView.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct BookView: View {
    @ObservedObject var model: Zaiko
    @State var refresh: Bool = false
    
    var entries: [UUID:Int] {
        model.bookEntries()
    }
    var uuids: [UUID] {
        Array(entries.keys).sorted {
            model.productWith(id: $0).name < model.productWith(id: $1).name
        }
    }
    
    var body: some View {
        NavigationView {
            List(uuids) { uuid in
                NavigationLink(destination:
                    ProductWithSheetView(model: model, product: model.productWith(id: uuid))
                ) {
                    ProductCellWithCountView(product: model.productWith(id: uuid), count: entries[uuid]!)
                }
            }
            .opacity(refresh ? 1.0 : 1.0)
            .navigationTitle("Inventory")
            .onAppear {
                refresh.toggle()
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView(model: Zaiko.sample())
    }
}
