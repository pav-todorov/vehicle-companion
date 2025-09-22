//
//  ProfileImageViewModel.swift
//  VehicleCompanion
//

import SwiftUI
import PhotosUI
import CoreTransferable
internal import Combine

enum ProfileImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}

struct ProfileImage: Transferable {
    let image: Image
    let data: Data
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let uiImage = UIImage(data: data) else {
                throw TransferError.importFailed
            }
            let image = Image(uiImage: uiImage)
            return ProfileImage(image: image, data: data)
        }
    }
}

@MainActor
class ProfileImageViewModel: ObservableObject {
    @Published var profileImageState: ProfileImageState
    @Published private var vehicle: Vehicle
    @Published var selectedImage: PhotosPickerItem? = nil {
        didSet {
            if let selectedImage {
                let progress = loadTransferable(from: selectedImage)
                profileImageState = .loading(progress)
            } else {
                profileImageState = .empty
            }
        }
    }
    
    init(profileImageState: ProfileImageState, vehicle: Vehicle) {
        self.profileImageState = profileImageState
        self.vehicle = vehicle
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.selectedImage else {
                    // TODO: handle
                    debugPrint("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.profileImageState = .success(profileImage.image)
                    self.vehicle.profileImage = profileImage.data
                case .success(nil):
                    self.profileImageState = .empty
                case .failure(let error):
                    self.profileImageState = .failure(error)
                }
            }
        }
    }
}
