//
//  VSizes.swift
//  VehicleCompanion
//

import Foundation

struct Sizes {
    // MARK: - Initializers
    private init() {}
    
    // MARK:  - Properties
    
    // MARK: Padding
    static let pV16: CGFloat = 16
    
    // MARK: Buttons
    
    /// width: infinity
    /// height: 32
    static let button: CGSize = .init(width: .infinity, height: 40)
    
    ///
    static let buttonPressedScale: CGFloat = 0.98
    
    // MARK: Images
    
    /// width: 40
    /// height: 40
    static let smallRowImage: CGSize = .init(width: 40, height: 40)
    
    static let smallRowImageFrame: CGSize = .init(width: 43, height: 43)
    
    /// width: 100
    /// height: 100
    static let largeProfileImage: CGSize = .init(width: 100, height: 100)
    
    /// 16 x 16
    static let smallIconImage: CGFloat = 16
    
    /// 50 x 50
    static let largeIconImage: CGFloat = 40
}
