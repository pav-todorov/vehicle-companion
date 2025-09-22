//
//  POIDetailsViewModel.swift
//  VehicleCompanion
//

import Foundation
import _MapKit_SwiftUI

@MainActor
@Observable
class POIDetailsViewModel {
    
    // MARK: - Initializers
    
    init(repository: PlacesRepository, poi: PoiUIModel) {
        self.repository = repository
        self.poi = poi
    }
    
    // MARK: - Properties
    
    private let repository: PlacesRepository
    let poi: PoiUIModel
    
    var savedPOIs: [PoiUIModel] = []
    var isSaved: Bool = false
    var error: String = ""
    var showAlert: Bool = false
    var position: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: poi.loc,
                span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.01)
            )
        )
    }
    
    // MARK: - Methods
    
    func fetchSavedPOIs() async {
        error = ""
        do {
            savedPOIs =  try await repository.fetchSavedPlaces()
        } catch {
            handleError(errorMessage: error.localizedDescription)
        }
    }
    
    func checkIfSaved() {
        isSaved = savedPOIs.contains(poi)
    }
    
    func save() async {
        error = ""
        do {
            try await repository.save(poi)
        } catch {
            handleError(errorMessage: error.localizedDescription)
        }
    }
    
    func delete() async {
        error = ""
        do {
            try await repository.delete(poi)
        } catch {
            handleError(errorMessage: error.localizedDescription)
        }
    }
    
    func userDidDismissAlert() {
        showAlert.toggle()
    }
    
    // MARK: - Helper methods
    
    private func handleError(errorMessage: String) {
        error = errorMessage
        showAlert.toggle()
    }
}
