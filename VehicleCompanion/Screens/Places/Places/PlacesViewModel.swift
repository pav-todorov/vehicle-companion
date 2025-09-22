//
//  PlacesViewModel.swift
//  VehicleCompanion
//

import Foundation

@MainActor
@Observable
class PlacesViewModel {
    var repository: PlacesRepository
    var error: String = ""
    var places: [PoiUIModel] = []
    var selectedPois: [PoiUIModel] = []
    var showSelectedAnnotationsSheet: Bool = false
    var placesState: PlacesState = .empty
    
    init(repository: PlacesRepository) {
        self.repository = repository
    }
    
    func fetchPlaces() async {
        do {
            places = try await repository.fetchPlaces()
        } catch {
            self.error = error.localizedDescription
        }
    }
}
