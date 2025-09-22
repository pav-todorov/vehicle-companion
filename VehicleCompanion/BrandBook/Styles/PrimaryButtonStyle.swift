//
//  PrimaryButtonStyle.swift
//  VehicleCompanion
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: Sizes.button.width)
            .frame(height: Sizes.button.height)
            .background(
                configuration.isPressed
                ? Color.primaryButtonPressed
                : Color.primaryButtonBackground
            )
            .foregroundStyle(Color.primaryButtonFont)
            .clipShape(Capsule())
            .scaleEffect(
                configuration.isPressed
                ? Sizes.buttonPressedScale
                : 1
            )
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
