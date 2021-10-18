//
//  ProductEditView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductEditView: View {
    @ObservedObject var product: Product
    
    var body: some View {
        Form {
            TextField("Product Name", text: $product.name)
            TextField("Product Description", text: $product.description)
            TextField("Product Emoji", text: $product.emoji)
        }
    }
}

struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditView(product: Product.sample())
    }
}
