//
//  VehicleRepository.swift
//  VehicleCompanion
//

import SwiftUI
internal import Combine
import SwiftData

protocol VehicleRepository {
    func fetchVehicles() async throws -> [Vehicle]
    func save(_ vehicle: Vehicle) async throws
    func delete(_ vehicle: Vehicle) async throws
}

@MainActor
final class VehicleRESTRepository: VehicleRepository {
    private let vehicleDataSource: VehicleRESTDataSourceProtocol
    
    init(modelContext: ModelContext) {
        vehicleDataSource = VehicleRESTDataSource(modelContext: modelContext)
    }
    
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
