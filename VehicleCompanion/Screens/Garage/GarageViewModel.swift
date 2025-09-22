//
//  GarageViewModel.swift
//  VehicleCompanion
//

import SwiftUI
internal import Combine

@MainActor
@Observable
class GarageViewModel {
    
    // MARK: - Properties
    
    let repository: VehicleRepository
    let searchablePrompt: LocalizedStringKey = "Type to search for a vehicle"
    
    var vehicles: [Vehicle] = []
    var addCarProfileSheetIsPresented: Bool = false
    var garageState: GarageState = .noVehiclesAvailable
    var searchText = ""
    var error = ""
    
    var searchResults: [Vehicle] {
        if searchText.isEmpty {
            return vehicles
        } else {
            return vehicles.filter {
                $0.name.contains(searchText) ||
                $0.make.contains(searchText) ||
                $0.model.contains(searchText) ||
                $0.vin.contains(searchText) ||
                $0.fuelType.name.contains(searchText) ||
                String($0.year).contains(searchText)
            }
        }
    }
    
    // MARK: - Initializers
    
    init(repository: VehicleRepository) {
        self.repository = repository
    }
    
    // MARK: - Methods
    
    func fetchData() async {
        do {
            vehicles = try await repository.fetchVehicles()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func save(_ vehicle: Vehicle) async {
        do {
            try await repository.save(vehicle)
            await fetchData()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func toggleAddCarProfileSheet() {
        addCarProfileSheetIsPresented.toggle()
    }
    
    func deleteVehicles(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                Task {
                    do {
                        try await repository.delete(vehicles[index])
                        await fetchData()
                    } catch {
                        self.error = error.localizedDescription
                    }
                }
            }
        }
    }
    
    func getProfileImageState(from vehicle: Vehicle) -> Binding<ProfileImageState> {
        guard let profileImage = vehicle.profileImage,
              let image = Image(data: profileImage) else {
            return .constant(.empty)
        }
        return .constant(.success(image))
    }
    
    func checkAndAssignGarageState() {
        if !searchText.isEmpty && searchResults.isEmpty {
            garageState = .noSearchResults
        } else if vehicles.isEmpty {
            garageState = .noVehiclesAvailable
        } else {
            garageState = .loaded
        }
    }
}
