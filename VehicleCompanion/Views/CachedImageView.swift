//
//  CachedImageView.swift
//  VehicleCompanion
//

import SwiftUI

struct CachedImageView: View {
    init(url: URL) {
        self.url = url
    }
    
    let url: URL
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        Image(uiImage: image ?? UIImage())
            .resizable()
            .task {
                image = await ImageCache.shared.loadImage(from: url)
            }
        
    }
}

#Preview {
    CachedImageView(url: URL(string:"https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026827998/-strip_-quality_60_-interlace_Plane_-resize_320x320_U__-gravity_center_-extent_320x320/place_image-image-2ea174a8-c719-45f8-bc23-d91102a96163.jpg")!)
}
