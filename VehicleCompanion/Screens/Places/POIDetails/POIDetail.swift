//
//  POIDetail.swift
//  VehicleCompanion
//

import SwiftUI
import _MapKit_SwiftUI
import _SwiftData_SwiftUI

struct POIDetail: View {
    
    // MARK: - Properties
    
    @SwiftUI.Environment(\.openURL) var openURL
    @State var viewModel: POIDetailsViewModel
    
    // MARK: - body
    
    var body: some View {
        Form {
            miniMapSection
            detailsSection
            openInBrowser
        }
        .navigationTitle(viewModel.poi.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchSavedPOIs()
            viewModel.checkIfSaved()
        }
        .onChange(of: viewModel.isSaved) { oldValue, newValue in
            if newValue {
                Task {
                    await viewModel.save()
                }
            } else {
                Task {
                    await viewModel.delete()
                }
            }
        }
        .onAppear {
            viewModel.checkIfSaved()
        }
        .alert(
            "Something went wrong. Please, try again later",
            isPresented: $viewModel.showAlert
        ) {
            alertButton
        }
    }
    
    // MARK: Subviews
    
    private var miniMapSection: some View {
        Section {
            Map(initialPosition: viewModel.position) {
                Annotation(viewModel.poi.name, coordinate: viewModel.poi.loc) {
                    if let iconUrl = viewModel.poi.iconUrl {
                        CachedCircularIconView(iconUrl: iconUrl)
                            .accessibilityElement()
                            .accessibilityLabel(Text(viewModel.poi.name))
                            .accessibilityHint(Text("Tap to select \(viewModel.poi.name)"))
                    }
                }
            }
            .frame(height: 160)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .allowsHitTesting(false)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
    
    private var detailsSection: some View {
        Section {
            HStack {
                Text("Category")
                    .foregroundStyle(Color.gray)
                Spacer()
                Image(systemName: viewModel.poi.primaryCategoryDisplayName.symbolName)
                    .resizable()
                    .frame(width: 15, height:15)
                Text(viewModel.poi.primaryCategoryDisplayName.rawValue)
            }
            HStack {
                Text("Rating")
                    .foregroundStyle(Color.gray)
                
                Spacer()
                Spacer()
                
                StarRatingsView(rating: viewModel.poi.rating ?? 0.0)
            }
            
            Toggle("Save for later", isOn: $viewModel.isSaved)
                .foregroundStyle(Color.gray)
        } header: {
            Text("Details")
        }
    }
    
    private var openInBrowser: some View {
        Section {
            Button {
                openAssignedURL()
            } label: {
                Label("Open in browser", systemImage: "safari")
            }
            .buttonStyle(SecondaryButtonStyle())
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
    }
    
    private var alertButton: some View {
        Button("Close") {
            viewModel.userDidDismissAlert()
        }
    }
    
    
    // MARK: - Helper methods
    
    private func openAssignedURL() {
        openURL(URL(string: viewModel.poi.url)!)
    }
}

#Preview {
    NavigationStack {
        POIDetail(
            viewModel: .init(
                repository: DefaultMockPlacesRepository(),
                poi: .mock()
            )
        )
    }
}
