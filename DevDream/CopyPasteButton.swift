//
//  CopyPasteButton.swift
//  DevDream
//
//  Created by Christopher Mattar on 6/13/22.
//

import SwiftUI

struct CopyPasteButton: View {
    
    enum CopyPasteButtonType {
        case copy
        case paste
    }
    
    var buttonType: CopyPasteButtonType = .copy
    @Binding var value: String
    
    var body: some View {
        VStack {
            if buttonType == .copy {
                Button("Copy") {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(value, forType: .string)
                }
            }
            else {
                Button("Paste") {
                    if let string = NSPasteboard.general.string(forType: .string) {
                        value = string
                    }
                }
            }
        }
    }
}

struct CopyPasteButton_Previews: PreviewProvider {
    static var previews: some View {
        CopyPasteButton(value: .constant(""))
    }
}
