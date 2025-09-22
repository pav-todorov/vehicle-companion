//
//  PlacesRepository.swift
//  VehicleCompanion
//

import SwiftUI
internal import Combine

protocol PlacesRepository {
    func fetchPlaces() async throws -> [PoiUIModel]
    func fetchSavedPlaces() async throws -> [PoiUIModel]
    func save(_ poi: PoiUIModel) async throws
    func delete(_ poi: PoiUIModel) async throws
    func checkIfSaved(_ poi: PoiUIModel) -> Bool
    
    var contextHasChanges: Bool { get }
}

@MainActor
final class PlacesRESTRepository: PlacesRepository {
    private let placesDataSource: PlacesRESTDataSourceProtocol
    
    var contextHasChanges: Bool {
        placesDataSource.contextHasChanges
    }
    
    init(placesDataSource: PlacesRESTDataSourceProtocol) {
        self.placesDataSource = placesDataSource
    }
    
    func fetchPlaces() async throws -> [PoiUIModel] {
        try await placesDataSource.fetchPlaces().map(PoiUIModel.init(from:))
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
}

