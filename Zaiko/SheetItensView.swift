//
//  SheetItensView.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct SheetItensView: View {
    @ObservedObject var model: Zaiko
    @ObservedObject var sheet: Sheet
    
    var body: some View {
        List(model.itensFor(sheet:sheet)) { uuid in
            ProductCellWithCountView(product: model.productWith(id: uuid), count: sheet.entries[uuid]!)
        }.navigationBarTitle(sheet.name)
    }
}

struct SheetItensView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Zaiko.sample()
        NavigationView {
            SheetItensView(model: model, sheet: model.book.randomElement()!)
        }
    }
}

extension UUID: Identifiable {
    public typealias ID = String
    
    public var id: ID {
        return uuidString
    }
}
