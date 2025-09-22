//
//  FailMockVehicleRepository.swift
//  VehicleCompanion
//

import Foundation

@MainActor
class FailMockVehicleRepository: VehicleRepository {
    private let vehicleDataSource: VehicleRESTDataSourceProtocol = FailMockRESTDataSource()
    
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
