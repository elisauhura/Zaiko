//
//  SheetList.swift
//  Zaiko
//
//  Created by Elisa Silva on 17/10/21.
//

import SwiftUI

struct SheetListView: View {
    @ObservedObject var model: Zaiko
    var newSheet = Sheet.empty()
    
    @State var addNew = false
    
    var body: some View {
        NavigationView {
            List { ForEach(model.book.sorted { $0.name < $1.name }) { sheet in
                SheetCellView(model: model, sheet: sheet)
            }}
            .navigationTitle("Sheets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addNew.toggle()
                        newSheet.reset()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .popover(isPresented: $addNew) {
                NavigationView {
                    RenameSheetView(sheet: newSheet)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    addNew.toggle()
                                    model.book.append(newSheet.copy())
                                }) {
                                    Text("Add")
                                }
                            }
                        }
                }.frame(minWidth: 300, minHeight: 300)
            }
        }
    }
}

struct SheetListView_Previews: PreviewProvider {
    static var previews: some View {
        SheetListView(model: Zaiko.sample())
    }
}

struct SheetCellView: View {
    @ObservedObject var model: Zaiko
    @ObservedObject var sheet: Sheet

    @State var edit = false
    
    var body: some View {
        NavigationLink(destination:
                        SheetItensView(model: model, sheet: sheet)
                        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    edit.toggle()
                    
                }) {
                    Text("Edit")
                }
            }
        }
        .popover(isPresented: $edit) {
            NavigationView {
                RenameSheetView(sheet: sheet)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                edit.toggle()
                            }) {
                                Text("Return")
                            }
                        }
                    }
            }.frame(minWidth: 300, minHeight: 300)
        }
        ) {
            HStack {
                Image(systemName: "doc.plaintext")
                Text(sheet.name)
            }
        }
    }
}
