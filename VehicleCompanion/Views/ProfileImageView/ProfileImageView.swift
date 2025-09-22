//
//  ProfileImageView.swift
//  VehicleCompanion
//

import SwiftUI
import PhotosUI

struct CircularProfileImageView: View {
    var iconSize: CGFloat = Sizes.largeIconImage
    var imageSize: CGSize = Sizes.largeProfileImage
    
    @Binding var profileImageState: ProfileImageState
    
    var body: some View {
        profileImage
            .scaledToFill()
            .frame(cgSize: imageSize)
            .clipShape(Circle())
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: Color.emptyProfileLinearColors,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
    
    private var profileImage: some View {
        switch profileImageState {
        case .success(let image):
            AnyView(image.resizable())
        case .loading:
            AnyView(ProgressView())
        case .empty:
            AnyView(Image(systemName: "car")
                .font(.system(size: iconSize))
                .foregroundColor(.white))
        case .failure:
            AnyView(Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: iconSize))
                .foregroundColor(.white))
        }
    }
}

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileImageViewModel
    
    var body: some View {
        CircularProfileImageView(profileImageState: $viewModel.profileImageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.selectedImage,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                             .buttonStyle(.borderless)
            }
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    EditableCircularProfileImage(
        viewModel: .init(
            profileImageState: .empty,
            vehicle: .empty()
        )
    )
    .padding(16)
}
