//
//  POIListViewModel.swift
//  VehicleCompanion
//

import UIKit

@MainActor
@Observable
class POIListViewModel {
    let repository: PlacesRepository
    let pois: [PoiUIModel]
    
    init(repository: PlacesRepository, pois: [PoiUIModel]) {
        self.repository = repository
        self.pois = pois
    }
    
    var error: String = ""
    
    var poiListState: POIListState = .noPOIs
    var uiImage: UIImage?
    
    var savedPOIs: [PoiUIModel] = []
    
    var searchText = ""
    var searchResults: [PoiUIModel] {
        if searchText.isEmpty {
            return pois
        } else {
            return pois.filter {
                $0.name.contains(searchText) ||
                $0.primaryCategoryDisplayName.rawValue.contains(searchText)
            }
        }
    }
    
    var savedPOIsSearchResults: [PoiUIModel] {
        if searchText.isEmpty {
            return savedPOIs
        } else {
            return savedPOIs.filter {
                $0.name.contains(searchText) ||
                $0.primaryCategoryDisplayName.rawValue.contains(searchText)
            }
        }
    }
    
    var showSavedPOIs: Bool = false
    
    
    func userDidTapFavorites() {
        showSavedPOIs.toggle()
    }
    
    func handleStateChange() {
        if showSavedPOIs {
            poiListState = savedPOIs.isEmpty ? .noSavedPOIs : .savedPOIs
        } else {
            poiListState = pois.isEmpty ? .noPOIs : .loaded
        }
    }
    
    func fetchSavedPOIs() async {
        error = ""
        poiListState = .loading
        do {
            savedPOIs =  try await repository.fetchSavedPlaces()
            handleStateChange()
        } catch {
            self.error = error.localizedDescription
            poiListState = .error
        }
    }
}
