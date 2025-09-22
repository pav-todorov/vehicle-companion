//
//  DefaultMockPlacesRepository.swift
//  VehicleCompanion
//

import Foundation

@MainActor
class DefaultMockPlacesRepository: PlacesRepository {
    private let placesDataSource: PlacesRESTDataSourceProtocol = DefaultMockPlacesRESTDataSource()
    
    func fetchPlaces() async throws -> [PoiUIModel] {
        try await placesDataSource.fetchPlaces().map({ .init(from: $0) })
    }
    
    func fetchSavedPlaces() async throws -> [PoiUIModel] {
        try await placesDataSource.fetchSavedPlaces()
    }
    
    func save(_ poi: PoiUIModel) async throws {
        try await placesDataSource.savePOI(poi)
    }
    
    func delete(_ poi: PoiUIModel) async throws {
        try await placesDataSource.deletePOI(poi)
    }
    
    func checkIfSaved(_ poi: PoiUIModel) -> Bool {
        placesDataSource.checkIfSaved(poi)
    }
    
    var contextHasChanges: Bool {
        placesDataSource.contextHasChanges
    }
}
