//
//  String+Extensions.swift
//  VehicleCompanion
//

import Foundation

extension String {
    /// Without any white spaces or new lines
    var cleaned: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
