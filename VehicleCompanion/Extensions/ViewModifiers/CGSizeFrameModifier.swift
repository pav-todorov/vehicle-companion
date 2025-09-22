//
//  CGSizeFrameModifier.swift
//  VehicleCompanion
//

import SwiftUI

struct CGSizeFrameModifier: ViewModifier {
    let cgSize: CGSize
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: cgSize.width,
                height: cgSize.height
            )
    }
}
