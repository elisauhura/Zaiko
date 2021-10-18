//
//  ProductWithSheetView.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct ProductWithSheetView: View {
    @ObservedObject var model: Zaiko
    @State var product: Product
    
    var sheets: [Sheet] {
        model.book.filter {
            $0.entries.keys.contains(product.id)
        }
    }
    
    var body: some View {
        List(sheets.sorted{ $0.name < $1.name }) { sheet in
            HStack {
                Image(systemName: "doc.plaintext")
                Text(sheet.name)
                Spacer()
                Text("\(sheet.entries[product.id]!)")
            }
        }
        .navigationTitle("\(product.emoji) \(product.name)")
    }
}

struct ProductWithSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Zaiko.sample()
        NavigationView {
            ProductWithSheetView(model: sample, product: sample.productWith(id:sample.book[0].entries.keys.first!))
        }
        
    }
}
