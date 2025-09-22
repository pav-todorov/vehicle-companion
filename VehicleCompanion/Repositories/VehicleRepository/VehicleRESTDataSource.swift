//
//  VehicleRESTDataSource.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData
internal import Combine

protocol VehicleRESTDataSourceProtocol {
    func fetchVehicles() async throws -> [Vehicle]
    func saveVehicle(_ vehicle: Vehicle) async throws
    func deleteVehicle(_ vehicle: Vehicle) async throws
}

@MainActor
final class VehicleRESTDataSource: VehicleRESTDataSourceProtocol {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchVehicles() async throws -> [Vehicle] {
        let descriptor = FetchDescriptor<Vehicle>(sortBy: [SortDescriptor(\.name)])
        return try modelContext.fetch(descriptor)
    }
    
    func saveVehicle(_ vehicle: Vehicle) async throws {
        modelContext.insert(vehicle)
    }
    
    func deleteVehicle(_ vehicle: Vehicle) async throws {
        modelContext.delete(vehicle)
    }
}
