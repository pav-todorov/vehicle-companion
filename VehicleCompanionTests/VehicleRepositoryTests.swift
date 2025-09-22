//
//  VehicleCompanionTests.swift
//  VehicleCompanionTests
//

import Testing
@testable import VehicleCompanion
internal import Foundation

@MainActor
struct VehicleRepositoryTests {
    let defaultRepository: VehicleRepository = DefaultMockVehicleRepository()
    let failRepository: VehicleRepository = FailMockVehicleRepository()
    
    @Test("Test vehicle repository fetch happy path")
    func fetchVehicles() async {
        do {
            let vehicles: [Vehicle] = try await defaultRepository.fetchVehicles()
            #expect(!vehicles.isEmpty)
            #expect(vehicles.count == 10)
            #expect(vehicles.first?.make == "Ford")
            
        } catch {
            #expect(error.localizedDescription.isEmpty)
        }
    }
    
    @Test("Test vehicle repository save happy path")
    func saveVehicle() async {
        do {
            var vehicles: [Vehicle] = try await defaultRepository.fetchVehicles()
            #expect(!vehicles.isEmpty)
            #expect(vehicles.count == 10)
            
            try await defaultRepository.save(.empty())
            
            vehicles = try await defaultRepository.fetchVehicles()
            #expect(!vehicles.isEmpty)
            #expect(vehicles.count == 11)
            #expect(vehicles.last?.make == "")
        } catch {
            #expect(error.localizedDescription.isEmpty)
        }
    }
    
    @Test("Test vehicle repository delete happy path")
    func deleteVehicle() async {
        do {
            var vehicles: [Vehicle] = try await defaultRepository.fetchVehicles()
            #expect(!vehicles.isEmpty)
            #expect(vehicles.count == 10)
            
            try await defaultRepository.delete(.mocks().first!)
            
            vehicles = try await defaultRepository.fetchVehicles()
            #expect(!vehicles.isEmpty)
            #expect(vehicles.count == 9)
            #expect(vehicles.first?.make == "Toyota")
        } catch {
            #expect(error.localizedDescription.isEmpty)
        }
    }
    
    @Test("Test vehicle repository fetch throw")
    func fetchThrow() async throws {
        await #expect(throws: VehicleMockError.fetchError) {
            try await failRepository.fetchVehicles()
        }
    }
    
    @Test("Test vehicle repository save throw")
    func saveThrow() async throws {
        await #expect(throws: VehicleMockError.saveError) {
            try await failRepository.save(.empty())
        }
    }
    
    @Test("Test vehicle repository delete throw")
    func deleteThrow() async throws {
        await #expect(throws: VehicleMockError.deleteError) {
            try await failRepository.delete(.empty(), )
        }
    }
}
