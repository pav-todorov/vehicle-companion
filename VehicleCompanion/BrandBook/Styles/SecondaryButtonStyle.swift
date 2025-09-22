//
//  SecondaryButtonStyle.swift
//  VehicleCompanion
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: Sizes.button.width)
            .frame(height: Sizes.button.height)
            .background(
                configuration.isPressed
                ? Color.secondaryButtonPressed
                : Color.secondaryButtonBackground
            )
            .foregroundStyle(Color.secondaryButtonFont)
            .overlay(Capsule()
                .strokeBorder(
                    configuration.isPressed
                    ? Color.secondaryButtonPressed
                    : Color.secondaryButtonBorder,
                    lineWidth: 1
                )
            )
            .clipShape(Capsule())
            .scaleEffect(
                configuration.isPressed
                ? Sizes.buttonPressedScale
                : 1
            )
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
