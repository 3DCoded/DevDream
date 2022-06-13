//
//  Base64View.swift
//  DevDream
//
//  Created by Christopher Mattar on 6/13/22.
//

import SwiftUI

struct Base64View: View {
    
    @State var encodedText: String = ""
    @State var decodedText: String = ""
        
    var body: some View {
        VStack {
            Text("Base64 Encode/Decode")
                .font(.largeTitle)
            
            Divider()
            
            HStack {
                VStack {
                    HStack {
                        Text("Encoded:")
                        Spacer()
                        CopyPasteButton(buttonType: .copy, value: $encodedText)
                        CopyPasteButton(buttonType: .paste, value: $encodedText)
                    }
                    TextEditor(text: $encodedText)
                        .onChange(of: encodedText) { encodeInputText in
                            if let data = encodedText.data(using: .utf8) {
                                decodedText = data.base64EncodedString()
                            }
                        }
                }
                Image(systemName: "arrow.left.arrow.right")
                    .font(.system(size: 50))
                VStack {
                    HStack {
                        Text("Decoded:")
                        Spacer()
                        CopyPasteButton(buttonType: .copy, value: $decodedText)
                        CopyPasteButton(buttonType: .paste, value: $decodedText)
                    }
                    TextEditor(text: $decodedText)
                        .onChange(of: decodedText) { decodedText in
                            if let data = Data(base64Encoded: decodedText) {
                                if let string = String(data: data, encoding: .utf8) {
                                    encodedText = string
                                }
                            }
                        }
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct Base64_Previews: PreviewProvider {
    static var previews: some View {
        Base64View()
    }
}
