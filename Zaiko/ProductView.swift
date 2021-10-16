//
//  ProductView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductView: View {
    let product: Product;
    var body: some View {
        VStack {
            Circle()
                .frame(width: 96.0, height: 96.0)
                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
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
        .padding(.all)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                }) {
                    Text("Edit")
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product(id: NSUUID(), name: "Sample", description: "A sample product"))
    }
}
