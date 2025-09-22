//
//  ImageCacheManager.swift
//  VehicleCompanion
//

import SwiftUI
internal import Combine
import Alamofire

@MainActor
class ImageCache: ObservableObject {
    private init() {}
    
    // MARK: - Properties
    static let shared = ImageCache()
    
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    // MARK: - Methods
    func loadImage(from url: URL) async -> UIImage? {
        if let cachedImage = getFromCache(forKey: url) {
            return cachedImage
        } else {
            return await fetchImage(from: url)
        }
    }
    
    private func fetchImage(from url: URL) async -> UIImage? {
        let response = await AF.request(url, method: .get)
            .cacheResponse(using: .cache)
            .serializingData()
            .response
        
        let imageData: Data
        do {
            imageData = try response.result.get()
        } catch {
            debugPrint("❌ Fetch image error: \n\(error)")
            return nil
        }
        
        let uiImage = UIImage(data: imageData) ?? UIImage()
        
        addToCache(uiImage: uiImage, forKey: url)
        
        return uiImage
    }
    
    // MARK: - Helper methods
    private func getFromCache(forKey key: URL) -> UIImage? {
        cachedImages.object(forKey: key as NSURL)
    }
    
    private func addToCache(uiImage: UIImage, forKey key: URL) {
        cachedImages.setObject(uiImage, forKey: key as NSURL)
    }
}

