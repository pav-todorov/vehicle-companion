//
//  POIList.swift
//  VehicleCompanion
//

import SwiftUI
import SwiftData

enum POIListState {
    case loaded
    case noSavedPOIs
    case noPOIs
    case savedPOIs
    case loading
    case error
}

struct POIList: View {
    @State var viewModel: POIListViewModel
    
    var body: some View {
        containedView
            .onChange(of: [viewModel.savedPOIs, viewModel.pois]) { _, _ in
                viewModel.handleStateChange()
            }
            .onChange(of: viewModel.showSavedPOIs) { _, _ in
                viewModel.handleStateChange()
            }
            .refreshable {
                await viewModel.fetchSavedPOIs()
            }
            .task {
                await viewModel.fetchSavedPOIs()
            }
            .searchable(text: $viewModel.searchText, prompt: "Type to search for a trip idea")
            .navigationTitle("Trip Ideas")
            .navigationDestination(for: PoiUIModel.self) { poisUIModel in
                POIDetail(viewModel: .init(repository: viewModel.repository, poi: poisUIModel))
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: viewModel.userDidTapFavorites) {
                        Label("Favorites", systemImage: viewModel.showSavedPOIs ? "star.fill" : "star")
                    }
                }
            }
    }
    
    private var containedView: some View {
        switch viewModel.poiListState {
        case .loaded:
            AnyView(
                List(viewModel.searchResults, id: \.id) { poi in
                    POIRow(viewModel: .init(repository: viewModel.repository, poi: poi, savedPoids: viewModel.savedPOIs))
                }
            )
        case .noPOIs:
            AnyView(
                PlaceholderView(
                    systemIcon: "mappin.circle",
                    title: "No suggestions found",
                    subtitle: "Pull to try again"
                )
            )
        case .savedPOIs:
            AnyView(
                List(viewModel.savedPOIsSearchResults) { poi in
                    POIRow(viewModel: .init(repository: viewModel.repository, poi: poi, savedPoids: viewModel.savedPOIs))
                }
            )
        case .noSavedPOIs:
            AnyView(
                PlaceholderView(
                    systemIcon: "plus.square.on.square",
                    title: "No saved suggestions",
                    subtitle: "Add suggestions to appear here"
                )
            )
        case .loading:
            AnyView(
                ProgressView()
            )
        case .error:
            AnyView(
                PlaceholderView(
                    systemIcon: "exclamationmark.circle",
                    title: "Something went wrong",
                    subtitle: "Please try again later"
                )
            )
        }
    }
}

#Preview {
    POIList(
        viewModel: .init(
            repository: DefaultMockPlacesRepository(),
            pois: PoiUIModel.mocks()
        )
    )
}
