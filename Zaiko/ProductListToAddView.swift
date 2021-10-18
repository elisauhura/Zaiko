//
//  ProductListToAddView.swift
//  Zaiko
//
//  Created by Elisa Silva on 18/10/21.
//

import SwiftUI

struct ProductListToAddView: View {
    @ObservedObject var model: Zaiko
    @ObservedObject var event: Event
    var handler: (Product) -> ()
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        List {
            ForEach(model
                        .products
                        .filter { !event.itemList.keys.contains($0.id) }
                        .sorted { $0.name < $1.name }) { product in
                HStack {
                    ProductCellView(product: product)
                    Button(action: {
                        handler(product)
                        self.presentation.wrappedValue.dismiss()
                    }) {
                        Text("Add")
                    }
                }
            }
        }
    }
}

struct ProductListToAddView_Previews: PreviewProvider {
    static var previews: some View {
        let model = Zaiko.sample()
        model.events[0].itemList = model.book[0].entries
        
        return NavigationView {
            ProductListToAddView(model: model, event: model.events[0], handler: {_ in})
        }
    }
}
