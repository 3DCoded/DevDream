//
//  ImageConverterView.swift
//  DevDream
//
//  Created by Christopher Mattar on 6/28/22.
//

import SwiftUI

struct ImageConverterView: View {
    
    enum ImageType {
        case png
        case jpeg
    }
    
    @State var inputFiles: [URL] = []
    @State var outputType: ImageType = .png
    
    var body: some View {
        VStack {
            Text("Image Converter")
                .font(.largeTitle)
            
            Divider()
            
            HStack {
                VStack {
                    Text("Input:")
                    Button(action: {
                        let panel = NSOpenPanel()
                        panel.allowsMultipleSelection = true
                        panel.canChooseDirectories = false
                        panel.allowedContentTypes = [.image]
                        if panel.runModal() == .OK {
                            inputFiles = panel.urls
                        }
                    }) {
                        HStack {
                            Text("Choose Files")
                            Image(systemName: "filemenu.and.cursorarrow")
                        }
                    }
                    Text("\(inputFiles.count) files selected")
                    Button("Convert") {
                        let panel = NSOpenPanel()
                        panel.canChooseFiles = false
                        panel.canChooseDirectories = true
                        panel.allowsMultipleSelection = false
                        panel.title = "Save Images to Directory"
                        if panel.runModal() == .OK {
                            if let url = panel.url {
                                for inputFile in inputFiles {
                                    if let nsImage = NSImage(contentsOf: inputFile) {
                                        let (data, filename) = convert(filename: inputFile, image: nsImage, type: outputType)
                                        if let data = data {
                                            try? data.write(to: url.appendingPathComponent(filename))
                                        }
                                    }
                                }
                                NSWorkspace.shared.open(url)
                            }
                        }
                        
                    }
                    .disabled(inputFiles.count == 0)
                }
                Spacer()
                VStack {
                    Text("Output Type:")
                    Picker("", selection: $outputType) {
                        Text("PNG")
                            .tag(ImageType.png)
                        Text("JPEG")
                            .tag(ImageType.jpeg)
                    }
                    .pickerStyle(.segmented)
                }
            }
            Spacer()
        }
        .padding()
    }
    
    func convert(filename: URL, image: NSImage, type: ImageType) -> (Data?, String) {
        var mutableFilename = filename
        mutableFilename.deletePathExtension()

        switch type {
        case .png:
            return (image.png, mutableFilename.lastPathComponent + ".png")
        case .jpeg:
            return (image.jpeg, mutableFilename.lastPathComponent + ".jpeg")
        }
    }
}

extension NSBitmapImageRep {
    var png: Data? { representation(using: .png, properties: [:]) }
    var jpeg: Data? { representation(using: .jpeg, properties: [:]) }
}
extension Data {
    var bitmap: NSBitmapImageRep? { NSBitmapImageRep(data: self) }
}
extension NSImage {
    var png: Data? { tiffRepresentation?.bitmap?.png }
    var jpeg: Data? { tiffRepresentation?.bitmap?.jpeg }
}

struct ImageConverterView_Previews: PreviewProvider {
    static var previews: some View {
        ImageConverterView()
    }
}
