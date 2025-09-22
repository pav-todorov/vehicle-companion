//
//  POIRow.swift
//  VehicleCompanion
//

import SwiftUI

struct POIRow: View {
    @State var viewModel: POIRowViewModel
    
    var body: some View {
        NavigationLink(value: viewModel.poi) {
            HStack(spacing: 8) {
                if let iconURL = viewModel.poi.iconUrl {
                    CachedCircularIconView(iconUrl: iconURL)
                }
                
                VStack(alignment: .leading) {
                    
                    Text(viewModel.poi.name)
                        .fontWeight(.bold)
                    
                    HStack {
                        Image(systemName: viewModel.poi.primaryCategoryDisplayName.symbolName)
                        Text(viewModel.poi.primaryCategoryDisplayName.rawValue)
                    }
                    
                    HStack {
                        HStack(spacing: 2) {
                            StarRatingsView(rating: viewModel.poi.rating ?? 0.0)
                        }
                        Text(String(viewModel.poi.rating ?? 0.0))
                    }
                    .font(.subheadline)
                }
                
                if viewModel.isSaved {
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(Color.yellow)
                }
            }
        }
        .onAppear {
            viewModel.checkIfSaved()
        }
        .swipeActions(edge: .trailing, disabled: $viewModel.disableDelete) {
            Button("Delete", systemImage: "trash") {
                Task {
                    await viewModel.delete()
                }
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading, disabled: $viewModel.disableSave) {
            Button("Save", systemImage: "star.fill") {
                Task {
                    await viewModel.save()
                }
            }
            .tint(.yellow)
        }
        .onChange(of: viewModel.contextHasChanges) { _, _ in
            viewModel.checkIfSaved()
        }
    }
}

#Preview {
    POIRow(
        viewModel: .init(
            repository: DefaultMockPlacesRepository(),
            poi: .mock(),
            savedPoids: PoiUIModel.mocks()
        )
    )
}
