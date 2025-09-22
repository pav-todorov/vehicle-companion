//
//  DefaultMockPlacesRESTDataSource.swift
//  VehicleCompanion
//

import Foundation

@MainActor
class DefaultMockPlacesRESTDataSource: PlacesRESTDataSourceProtocol {
    var poiDTOs: [PoiDTO] = PoiDTO.mocks()
    var poiUIModels: [PoiUIModel] = PoiUIModel.mocks()
    
    func fetchPlaces() async throws -> [PoiDTO] {
        poiDTOs
    }
    
    func fetchSavedPlaces() async throws -> [PoiUIModel] {
        poiUIModels
    }
    
    func savePOI(_ poi: PoiUIModel) async throws {
        poiUIModels.append(poi)
    }
    
    func deletePOI(_ poi: PoiUIModel) async throws {
        poiUIModels.removeAll(where: { $0.name == poi.name })
    }
    
    func checkIfSaved(_ poi: PoiUIModel) -> Bool {
        poiUIModels.contains(poi)
    }
    
    var contextHasChanges: Bool {
        true
    }
}
