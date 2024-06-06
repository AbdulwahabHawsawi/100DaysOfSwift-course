//
//  MeView.swift
//  Hot Prospects
//
//  Created by Abdulwahab Hawsawi on 25/04/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("email") private var email = "you@yoursite.com"
    @State private var qrCode = UIImage()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $email)
                    .textContentType(.emailAddress)
                    .font(.title)
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQRCode)
            .onChange(of: name, updateQRCode)
            .onChange(of: email, updateQRCode)
            
            Image(uiImage: qrCode)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(email)")
    }
}

#Preview {
    MeView()
}
