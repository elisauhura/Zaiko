//
//  ProductExplorerView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductExplorerView: View {
    let model: Zaiko
    var newProduct = Product.empty()
    
    @State var addNew: Bool = false
    
    var body: some View {
        NavigationView {
            ProductListView(model: model)
                .navigationTitle("Products")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            addNew.toggle()
                            newProduct.reset()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .popover(isPresented: $addNew) {
                    NavigationView {
                        ProductEditView(product: newProduct)
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        addNew.toggle()
                                        model.products.append(newProduct.copy())
                                    }) {
                                        Text("Add")
                                    }
                                }
                            }
                    }.frame(minWidth: 300, minHeight: 300)
                }
                         
        }
    }
}

struct ProductExplorerView_Previews: PreviewProvider {
    static var previews: some View {
        ProductExplorerView(model: Zaiko.sample())
    }
}
