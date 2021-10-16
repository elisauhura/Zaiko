//
//  ProductEditView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ProductEditView: View {
    @State var name: String = ""
    
    var body: some View {
        Form {
            TextField(LocalizedStringKey("ProductName"), text: $name)
        }
    }
}

struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditView()
    }
}
