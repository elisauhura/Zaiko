//
//  ProductCell.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product;
    var body: some View {
        HStack {
            Circle()
                .frame(width: /*@START_MENU_TOKEN@*/42.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/42.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading){
                Text(product.name)
                    .font(.body)
                Text(product.description)
                    .font(.footnote)
            }
            Spacer()
        }
        .padding(.all)
    }}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellView(product: Product(id: NSUUID(), name: "Sample", description: "A sample product"))
    }
}
