//
//  CaseIterable+Extensions.swift
//  VehicleCompanion
//

import Foundation

extension CaseIterable where Self: Equatable {
    func next() -> Self? {
        let all = Self.allCases
        let index = all.firstIndex(of: self)!
        let next = all.index(after: index)
        
        // Check for out of bounds
        if next == all.endIndex {
            return nil
        }
        
        return all[next]
    }
}
