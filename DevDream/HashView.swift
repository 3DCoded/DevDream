//
//  HashView.swift
//  DevDream
//
//  Created by Christopher Mattar on 6/13/22.
//

import SwiftUI
import CryptoKit

struct HashView: View {
    
    enum HashType {
        case md5
        case sha1
        case sha256
        case sha384
        case sha512
    }
    
    @State var hashType: HashType = .md5
    
    @State var inputText: String = ""
    @State var outputText: String = ""
    
    var body: some View {
        VStack {
            Text("Hasher")
                .font(.largeTitle)
            
            Divider()
            
            Picker("Hash Type:", selection: $hashType) {
                Text("MD5")
                    .tag(HashType.md5)
                Text("SHA1")
                    .tag(HashType.sha1)
                Text("SHA256")
                    .tag(HashType.sha256)
                Text("SHA384")
                    .tag(HashType.sha384)
                Text("SHA512")
                    .tag(HashType.sha512)
            }
            .pickerStyle(.segmented)
            .onChange(of: hashType) { inputText in
                computeHash()
            }
            
            HStack {
                VStack {
                    HStack {
                        Text("Input:")
                        Spacer()
                        CopyPasteButton(buttonType: .paste, value: $inputText)
                    }
                    TextEditor(text: $inputText)
                        .onChange(of: inputText) { inputText in
                            computeHash()
                        }
                }
                Image(systemName: "arrow.right")
                    .font(.system(size: 50))
                VStack {
                    HStack {
                        Text("Output:")
                        Spacer()
                        CopyPasteButton(buttonType: .copy, value: $outputText)
                    }
                    TextEditor(text: $outputText)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    func computeHash() {
        if let data = inputText.data(using: .utf8) {
            switch hashType {
            case .md5:
                outputText = Insecure.MD5.hash(data: data)
                    .map {
                    String(format: "%02hhx", $0)
                }
                    .joined()
            case .sha1:
                outputText = Insecure.SHA1.hash(data: data)
                    .map {
                    String(format: "%02hhx", $0)
                }
                    .joined()
            case .sha256:
                outputText = SHA256.hash(data: data)
                    .map {
                    String(format: "%02hhx", $0)
                }
                    .joined()
            case .sha384:
                outputText = SHA384.hash(data: data)
                    .map {
                    String(format: "%02hhx", $0)
                }
                    .joined()
            case .sha512:
                outputText = SHA512.hash(data: data)
                    .map {
                    String(format: "%02hhx", $0)
                }
                    .joined()
            }
            
        }
    }
}

struct HashView_Previews: PreviewProvider {
    static var previews: some View {
        HashView()
    }
}
