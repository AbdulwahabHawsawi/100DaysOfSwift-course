//
//  ContentView.swift
//  instafilter
//
//  Created by Abdulwahab Hawsawi on 26/04/2024.
//

import SwiftUI
import PhotosUI
import StoreKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    @State private var initialImage: CIImage?
    
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    
    @State private var imageReference: PhotosPickerItem?
    
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Spacer()
                PhotosPicker(selection: $imageReference) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .onChange(of: imageReference, loadImage)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity, applyProcessing)
                }
                .padding(.vertical)
                .disabled(processedImage == nil ? true : false)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
                .disabled(processedImage == nil ? true : false)
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(to: .crystallize()) }
                Button("Edges") { setFilter(to: .edges()) }
                Button("Gaussian Blur") { setFilter(to: .gaussianBlur()) }
                Button("Pixellate") { setFilter(to: .pixellate()) }
                Button("Sepia Tone") { setFilter(to: .sepiaTone()) }
                Button("Unsharp Mask") { setFilter(to: .unsharpMask()) }
                Button("Vignette") { setFilter(to: .vignette()) }
                Button("Bokeh Blur") { setFilter(to: .bokehBlur()) }
                Button("Gloom") { setFilter(to: .gloom()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await imageReference?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            initialImage = CIImage(image: inputImage)
            currentFilter.setValue(initialImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(to filter: CIFilter) {
        currentFilter = filter
        filterCount += 1

        if filterCount >= 3 {
            requestReview()
        }
        loadImage()
    }
}


#Preview {
    ContentView()
}
