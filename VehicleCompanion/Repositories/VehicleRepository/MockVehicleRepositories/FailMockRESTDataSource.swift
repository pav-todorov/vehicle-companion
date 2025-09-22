//
//  FailMockRESTDataSource.swift
//  VehicleCompanion
//

import Foundation

enum VehicleMockError: Error {
    case fetchError
    case saveError
    case deleteError
}

@MainActor
class FailMockRESTDataSource: VehicleRESTDataSourceProtocol {
    func fetchVehicles() async throws -> [Vehicle] {
        throw VehicleMockError.fetchError
    }
    
    func saveVehicle(_ vehicle: Vehicle) async throws {
        throw VehicleMockError.saveError
    }
    
    func deleteVehicle(_ vehicle: Vehicle) async throws {
        throw VehicleMockError.deleteError
    }
}
