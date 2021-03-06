//
//  ProductCell.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductCellView: View {
    @ObservedObject var  product: Product;
    var body: some View {
        HStack {
            Text(product.emoji)
                .font(.system(size: 32))
                .background(
                    Circle()
                        .frame(width: 42, height: 42)
                        .foregroundColor(Color(white: 0.8))
            ).frame(width: 42, height: 42)
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
        ProductCellView(product: Product.sample())
    }
}
