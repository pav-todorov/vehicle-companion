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
        Group {
            switch viewModel.poiListState {
            case .loaded:
                List(viewModel.searchResults) { poi in
                    POIRow(viewModel: .init(repository: viewModel.repository, poi: poi, savedPoids: viewModel.savedPOIs))
                }
            case .noPOIs:
                PlaceholderView(
                    systemIcon: "mappin.circle",
                    title: "No suggestions found",
                    subtitle: "Pull to try again"
                )
            case .savedPOIs:
                List(viewModel.savedPOIsSearchResults) { poi in
                    POIRow(viewModel: .init(repository: viewModel.repository, poi: poi, savedPoids: viewModel.savedPOIs))
                }
            case .noSavedPOIs:
                PlaceholderView(
                    systemIcon: "plus.square.on.square",
                    title: "No saved suggestions",
                    subtitle: "Add suggestions to appear here"
                )
            case .loading:
                ProgressView()
            case .error:
                PlaceholderView(
                    systemIcon: "exclamationmark.circle",
                    title: "Something went wrong",
                    subtitle: "Please try again later"
                )
            }
        }
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
}

#Preview {
    POIList(
        viewModel: .init(
            repository: DefaultMockPlacesRepository(),
            pois: PoiUIModel.mocks()
        )
    )
}
