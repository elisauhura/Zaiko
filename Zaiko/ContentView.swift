//
//  ContentView.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 4;
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Book")
                .tabItem {
                    Label("Book", systemImage: "book.closed")
                }.tag(1)
            Text("Sheets")
                .tabItem {
                    Label("Sheets", systemImage: "doc.plaintext")
                }.tag(2)
            Text("Reports")
                .tabItem {
                    Label("Reports", systemImage: "doc.on.doc")
                }.tag(3)
            ProductExplorerView()
                .tabItem {
                    Label("Products", systemImage: "bag")
                }.tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
