//
//  DefaultMockRESTDataSource.swift
//  VehicleCompanion
//

import Foundation

@MainActor
class DefaultMockVehicleRESTDataSource: VehicleRESTDataSourceProtocol {
    var vehicles: [Vehicle] = Vehicle.mocks()
    
    func fetchVehicles() async throws -> [Vehicle] {
        vehicles
    }
    
    func saveVehicle(_ vehicle: Vehicle) async throws {
        vehicles.append(vehicle)
    }
    
    func deleteVehicle(_ vehicle: Vehicle) async throws {
        vehicles.removeAll(where: { $0.name == vehicle.name })
    }
}
