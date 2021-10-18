//
//  ProductView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var product: Product
    @State var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Text(product.emoji)
                .font(.system(size: 64))
                .background(
                    Circle()
                        .frame(width: 96, height: 96)
                        .foregroundColor(Color(white: 0.8))
                ).frame(width: 96, height: 96)
            Text(product.name)
                .font(.title)
                .padding(.top)
            Text(product.description)
            Text(product.id.uuidString)
                .font(.caption)
                .foregroundColor(Color.gray)
                .padding(.top)
            Spacer()
        }
        .popover(isPresented: $isEditing) {
            NavigationView {
                ProductEditView(product: product)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button(action: {
                            isEditing.toggle()
                        }) {
                            Text("Return")
                        }
                    }
            }.frame(minWidth: 300, minHeight: 300)
        }
        .padding(.all)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text("Edit")
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductView(product: Product.sample()).navigationTitle("Sample")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
