//
//  ProductListView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var model: Zaiko
    
    var body: some View {
        List(model.products) { product in
            NavigationLink(destination: ProductView(product: product)) {
                ProductCellView(product: product)
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(model: Zaiko.sample())
    }
}
