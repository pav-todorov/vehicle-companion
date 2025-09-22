//
//  PlacesRESTDataSource.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData
internal import Combine
import Alamofire

protocol PlacesRESTDataSourceProtocol {
    func fetchPlaces() async throws -> [PoiDTO]
    func fetchSavedPlaces() async throws -> [PoiUIModel]
    func savePOI(_ poi: PoiUIModel) async throws
    func deletePOI(_ poi: PoiUIModel) async throws
    func checkIfSaved(_ poi: PoiUIModel) -> Bool
    
    var contextHasChanges: Bool { get }
}

@MainActor
@Observable
final class PlacesRESTDataSource: PlacesRESTDataSourceProtocol {
    private var modelContext: ModelContext
    
    var contextHasChanges: Bool {
        modelContext.hasChanges
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchPlaces() async throws -> [PoiDTO] {
        let response = await AF.request(AppConfig.tripIdeasURL!, interceptor: .retryPolicy)
        // Caching customization.
            .cacheResponse(using: .cache)
        // Validate response code and Content-Type.
            .validate()
            .serializingDecodable(POIDto.self)
            .response
        
        return try response.result.get().pois
    }
    
    func fetchSavedPlaces() async throws -> [PoiUIModel] {
        let descriptor = FetchDescriptor<PoiUIModel>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func savePOI(_ poi: PoiUIModel) async throws {
        modelContext.insert(poi)
    }
    
    func deletePOI(_ poi: PoiUIModel) async throws {
        modelContext.delete(poi)
    }
    
    func checkIfSaved(_ poi: PoiUIModel) -> Bool {
        if let _ : PoiUIModel = modelContext.registeredModel(for: poi.id) {
            return true
        }
    return false
    }
}
