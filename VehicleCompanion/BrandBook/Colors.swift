//
//  VColors.swift
//  VehicleCompanion
//

import SwiftUI

extension Color {
    // MARK: - Properties
    
    // MARK: Buttons
    
    /// Default accent color with 70% alpha
    static let primaryButtonPressed: Color = Color.accentColor.opacity(0.7)
    
    /// Default accent
    static let primaryButtonBackground: Color = .accentColor
    
    ///
    static let secondaryButtonPressed: Color = .accentColor.opacity(0.2)
    
    ///
    static let secondaryButtonBackground: Color = Color.white
    
    static let secondaryButtonBorder: Color = .accentColor
    static let secondaryButtonBorderPressed: Color = .accentColor.opacity(0.7)
    
    
    // MARK: Fonts
    
    /// Red with 50% alpha
    static let errorFont: Color = .red.opacity(0.5)
    
    /// Default gray
    static let placeholderFont: Color = .gray
    
    static let primaryButtonFont: Color = .white
    static let secondaryButtonFont: Color = .accentColor
    
    // MARK: Icons
    
    /// Default accent color at the top and teal at the bottom
    static let emptyProfileLinearColors: [Color] = [.accentColor, .teal]
}
