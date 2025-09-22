//
//  Date+Extensions.swift
//  VehicleCompanion
//

import Foundation

extension Date {
    static let yearOfFirstCar: Int = 1885
    
    static var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
}
