//
//  Image+Extensions.swift
//  VehicleCompanion
//

import SwiftUI

extension Image {
    init?(data: Data) {
        guard let uiImage = UIImage(data: data) else { return nil }
        self = Image(uiImage: uiImage)
    }
}
