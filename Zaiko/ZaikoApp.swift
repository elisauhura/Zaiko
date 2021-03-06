//
//  ZaikoApp.swift
//  Zaiko
//
//  Created by Elisa Silva on 16/10/21.
//

import SwiftUI

@main
struct ZaikoApp: App {
    var model: Zaiko
    
    init() {
        if let data = UserDefaults.standard.object(forKey: "Zaiko") as? Data,
         let model = Zaiko.decode(data: data) {
            self.model = model
        } else {
            self.model = Zaiko.empty()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .onReceive(NotificationCenter.default.publisher(for: UIScene.willDeactivateNotification), perform: {
                    _ in
                    UserDefaults.standard.setValue(model.encoded, forKey: "Zaiko")
                })
        }
    }
}
