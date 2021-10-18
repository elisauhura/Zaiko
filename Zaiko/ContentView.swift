//
//  ContentView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 2
    
    let model: Zaiko
    
    var body: some View {
        TabView(selection: $selection) {
            BookView(model: model)
                .tabItem {
                    Label("Book", systemImage: "book.closed")
                }.tag(1)
            SheetListView(model: model)
                .tabItem {
                    Label("Sheets", systemImage: "doc.plaintext")
                }.tag(2)
            Text("Reports")
                .tabItem {
                    Label("Reports", systemImage: "text.badge.checkmark")
                }.tag(3)
            ProductExplorerView(model: model)
                .tabItem {
                    Label("Products", systemImage: "bag")
                }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Zaiko.sample())
    }
}
