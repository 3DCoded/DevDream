//
//  MainView.swift
//  DevDream
//
//  Created by Christopher Mattar on 6/13/22.
//

import SwiftUI

struct MainView: View {
    
    enum ToolSelection {
        case base64
        case hash
    }
    
    @State var selectedTool: ToolSelection?
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Base64View(), tag: ToolSelection.hash, selection: $selectedTool) {
                    Label("Base64 Encode/Decode", systemImage: "square.grid.3x3.fill")
                }
                NavigationLink(destination: HashView(), tag: ToolSelection.base64, selection: $selectedTool) {
                    Label("Hasher", systemImage: "square.grid.3x3.fill")
                }
            }
            .listStyle(.sidebar)
            .frame(minWidth: 200)
            Text("Home")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
