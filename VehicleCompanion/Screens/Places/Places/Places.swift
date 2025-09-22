//
//  Places.swift
//  VehicleCompanion
//

import SwiftUI

enum PlacesState {
    case empty
    case loaded
}

struct Places: View {
    // MARK: - Properties
    
    @State var viewModel: PlacesViewModel
    
    // MARK: - body
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.placesState {
                case .empty:
                    emptyPlaceholder
                case .loaded:
                    poiList
                }
            }
            .onChange(of: viewModel.places, { oldValue, newValue in
                if viewModel.places.isEmpty {
                    viewModel.placesState = .empty
                } else {
                    viewModel.placesState = .loaded
                }
            })
            .onAppear(perform: {
                if viewModel.places.isEmpty {
                    viewModel.placesState = .empty
                } else {
                    viewModel.placesState = .loaded
                }
            })
            .refreshable {
                await viewModel.fetchPlaces()
            }
            .task {
                await viewModel.fetchPlaces()
            }
        }
    }
    
    // MARK: - Subviews
    
    var emptyPlaceholder: some View {
        ScrollView {
            Spacer(minLength: UIScreen.screenHeight / 3)
            PlaceholderView(
                systemIcon: "mappin.circle",
                title: "No suggestions found",
                subtitle: "Pull to try again"
            )
        }
    }
    
    var poiList: some View {
        POIList(viewModel: .init(repository: viewModel.repository, pois: viewModel.places))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        map
                    } label: {
                        Label("Favorites", systemImage: "map")
                    }
                }
            }
    }
    
    var map: some View {
        MapView(places: viewModel.places, selectedPOIs: $viewModel.selectedPois)
            .onChange(of: viewModel.selectedPois, {
                viewModel.showSelectedAnnotationsSheet.toggle()
            })
            .sheet(isPresented: $viewModel.showSelectedAnnotationsSheet) {
                NavigationStack {
                    POIList(
                        viewModel: .init(
                            repository: viewModel.repository,
                            pois: viewModel.selectedPois
                        )
                    )
                }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    Places(viewModel: .init(repository: DefaultMockPlacesRepository()))
}
