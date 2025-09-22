//
//  VehicleProfileViewModel.swift
//  VehicleCompanion
//

import Foundation
import SwiftUI

@Observable
class VehicleProfileViewModel {
    private let repository: VehicleRepository
    
    var profileImageViewModel: ProfileImageViewModel
    var vehicle: Vehicle
    var missingFields: [String] = []
    var formErrorMessage: String? = nil
    var profileImageState: ProfileImageState
    var isEditing: Bool
    var error: String = ""
    
    init(repository: VehicleRepository, vehicle: Vehicle = .empty()) {
        self.repository = repository
        self.vehicle = vehicle
        
        let profileImageState = (vehicle.isEmpty || vehicle.profileImage == nil)
        ? ProfileImageState.empty
        : ProfileImageState.success(Image(data: vehicle.profileImage!)!)
        
        self.profileImageState = profileImageState
        
        self.isEditing = !vehicle.isEmpty
        
        self.profileImageViewModel = ProfileImageViewModel(profileImageState: profileImageState, vehicle: vehicle)
    }
    
    func clearErrorWarning(for field: String) {
        missingFields.removeAll(where: { $0 == field })
    }
    
    func userTappedSave() {
        guard validateRequiredFields() else {
            return
        }
        
        if !isEditing {
            addItem()
        }
    }
    
    func validateRequiredFields() -> Bool {
        var missing: [String] = []
        
        if vehicle.name.cleaned.isEmpty { missing.append(Field.name.title) }
        if vehicle.make.cleaned.isEmpty { missing.append(Field.make.title) }
        if vehicle.model.cleaned.isEmpty { missing.append(Field.model.title) }
        if vehicle.vin.cleaned.isEmpty { missing.append(Field.vin.title) }
        
        missingFields = missing
        
        return missingFields.isEmpty
    }
    
    func addItem() {
        Task {
            do {
                try await repository.save(vehicle)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
