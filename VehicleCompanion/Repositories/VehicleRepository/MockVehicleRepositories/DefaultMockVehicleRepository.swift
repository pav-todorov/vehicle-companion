//
//  DefaultMockVehicleRepository.swift
//  VehicleCompanion
//

import Foundation

@MainActor
class DefaultMockVehicleRepository: VehicleRepository {
    private let vehicleDataSource: VehicleRESTDataSourceProtocol = DefaultMockVehicleRESTDataSource()
    
    func fetchVehicles() async throws -> [Vehicle] {
        try await vehicleDataSource.fetchVehicles()
    }
    
    func save(_ vehicle: Vehicle) async throws {
        try await vehicleDataSource.saveVehicle(vehicle)
    }
    
    func delete(_ vehicle: Vehicle) async throws {
        try await vehicleDataSource.deleteVehicle(vehicle)
    }
}
