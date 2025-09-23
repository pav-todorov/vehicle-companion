//
//  ContentView.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData

enum GarageState: Equatable {
    case loaded
    case noSearchResults
    case noVehiclesAvailable
}

struct Garage: View {
    @State var viewModel: GarageViewModel
    
    var body: some View {
        NavigationStack {
            containedView
                .task {
                    await viewModel.fetchData()
                }
                .searchable(text: $viewModel.searchText, prompt: viewModel.searchablePrompt)
                .navigationTitle("Garage")
                .navigationDestination(for: Vehicle.self) { vehicle in
                    VehicleProfile(vehicle: vehicle, repository: viewModel.repository)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: viewModel.toggleAddCarProfileSheet) {
                            Label("Add Item", systemImage: "plus")
                        }
                        .accessibilityLabel("Add new vehicle")
                        .accessibilityHint("Tap to open the add vehicle form.")
                        .accessibilityIdentifier("add_vehicle_button")
                    }
                }
        }
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            viewModel.checkAndAssignGarageState()
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
            viewModel.checkAndAssignGarageState()
        }
        
        .sheet(isPresented: $viewModel.addCarProfileSheetIsPresented, onDismiss: {
            Task {
                await viewModel.fetchData()
            }
        }, content: {
            NavigationStack {
                VehicleProfile(repository: viewModel.repository)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(
                                "Close",
                                systemImage: "xmark",
                                action: viewModel.toggleAddCarProfileSheet
                            )
                            .labelStyle(.iconOnly)
                        }
                    }
                    .presentationDragIndicator(.visible)
            }
        })
    }
    
    private var containedView: some View {
        switch viewModel.garageState {
        case .loaded:
            AnyView (
                List {
                    ForEach(viewModel.searchResults) { item in
                        NavigationLink(value: item) {
                            HStack {
                                CircularProfileImageView(
                                    iconSize: Sizes.smallIconImage,
                                    imageSize: Sizes.smallRowImage,
                                    profileImageState:
                                        viewModel.getProfileImageState(from: item)
                                )
                                Text(item.name)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel("Vehicle: \(item.name)")
                            .accessibilityHint("Tap to view vehicle details.")
                            .accessibilityIdentifier("vehicle_row_\(item.id)")
                        }
                    }
                    .onDelete(perform: viewModel.deleteVehicles)
                }
            )
        case .noSearchResults:
            AnyView(
                PlaceholderView(
                    systemIcon: "magnifyingglass",
                    title: "Oops, no vehicles found",
                    subtitle: "Maybe try with another query"
                )
                
                .accessibilityElement(children: .combine)
                .accessibilityLabel("No vehicles found. Try a different search.")
                .accessibilityHint("Swipe down to refresh or change the query.")
                .accessibilityIdentifier("no_search_results_placeholder")
            )
        case .noVehiclesAvailable:
            AnyView(
                PlaceholderView(
                    systemIcon: "plus.square.on.square",
                    title: "No vehicles available",
                    subtitle: "Add a vehicle by tapping the plus icon"
                )
                
                .accessibilityElement(children: .combine)
                .accessibilityLabel("No vehicles available. Tap plus to add one.")
                .accessibilityHint("Tap the plus icon in the top right.")
                .accessibilityIdentifier("no_vehicles_placeholder")
            )
        }
    }
}

#Preview {
    Garage(
        viewModel: .init(
            repository: DefaultMockVehicleRepository()
        )
    )
}
