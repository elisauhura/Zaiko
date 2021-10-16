//
//  ProductListView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductListView: View {
    let products: [Product];
    var body: some View {
        List(products) { product in
            NavigationLink(destination: ProductView(product: product)) {
                ProductCellView(product: product)
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(products: Product.samples())
    }
}
