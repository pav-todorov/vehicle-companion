//
//  POIRowViewModel.swift
//  VehicleCompanion
//

import Foundation

@MainActor
@Observable
class POIRowViewModel {
    private let repository: PlacesRepository
    let poi: PoiUIModel
    
    var isSaved: Bool = false
    var disableSave: Bool = false
    var disableDelete: Bool = false
    var error: String = ""
    var showAlert: Bool = false
    var savedPOIs: [PoiUIModel] = []
    
    var contextHasChanges: Bool {
        repository.contextHasChanges
    }
    
    init(
        repository: PlacesRepository,
        poi: PoiUIModel,
        savedPoids: [PoiUIModel]
    ) {
        self.repository = repository
        self.poi = poi
        self.savedPOIs = savedPoids
    }
    
    func configureSwipeActions() {
        if isSaved {
            disableSave = true
            disableDelete = false
        } else {
            disableSave = false
            disableDelete = true
        }
    }
    
    func checkIfSaved() {
        isSaved = repository.checkIfSaved(poi)
        configureSwipeActions()
    }
    
    func save() async {
        error = ""
        do {
            try await repository.save(poi)
            await fetchSavedPOIs()
        } catch {
            handleError(errorMessage: error.localizedDescription)
        }
    }
    
    func delete() async {
        error = ""
        do {
            try await repository.delete(poi)
            await fetchSavedPOIs()
        } catch {
            handleError(errorMessage: error.localizedDescription)
        }
    }
    
    func fetchSavedPOIs() async {
        error = ""
        do {
            savedPOIs =  try await repository.fetchSavedPlaces()
            checkIfSaved()
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
