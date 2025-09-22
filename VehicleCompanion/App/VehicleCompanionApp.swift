//
//  VehicleCompanionApp.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData

@main
struct VehicleCompanionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Vehicle.self,
            PoiUIModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var garageViewModel: GarageViewModel {
#if DEBUG
        // Needed for UI tests
        return .init(repository: DefaultMockVehicleRepository())
#else
        return .init(repository: VehicleRESTRepository(
            modelContext: sharedModelContainer.mainContext))
#endif
    }
    
    var placesViewModel: PlacesViewModel {
#if DEBUG
        // Needed for UI tests
        return .init(repository: DefaultMockPlacesRepository())
#else
        return .init(
            repository: PlacesRESTRepository(placesDataSource: PlacesRESTDataSource(
                modelContext: sharedModelContainer.mainContext)
            )
        )
#endif
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Garage(viewModel: garageViewModel)
                .tabItem {
                    Label("Garage", systemImage: "car.circle")
                }
                
                Places(viewModel: placesViewModel)
                .tabItem {
                    Label("Places", systemImage: "mappin.circle")
                }
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
