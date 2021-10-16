//
//  ProductExplorerView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductExplorerView: View {
    var body: some View {
        NavigationView {
            ProductListView(products: Product.samples())
                .navigationTitle("Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("Pressed")
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                         
        }
    }
}

struct ProductExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductExplorerView()
    }
}
