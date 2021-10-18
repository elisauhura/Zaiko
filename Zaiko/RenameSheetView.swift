//
//  RenameSheetView.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct RenameSheetView: View {
    @ObservedObject var sheet: Sheet
    
    var body: some View {
        Form {
            TextField("Sheet Name", text: $sheet.name)
        }
    }
}

struct RenameSheetView_Previews: PreviewProvider {
    static var previews: some View {
        RenameSheetView(sheet: Sheet.sample())
    }
}
