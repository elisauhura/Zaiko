//
//  ProductCellWithCountView.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct ProductCellWithCountView: View {
    @ObservedObject var  product: Product
    var count: Int
    
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
            Text("\(count)")
                .font(.system(size: 32))
        }
        .padding(.all)
    }
}

struct ProductCellWithCountView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCellWithCountView(product: Product.sample(), count: Int.random(in: 0..<100))
    }
}
