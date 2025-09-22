//
//  Item.swift
//  VehicleCompanion
//

import SwiftData
import SwiftUI

enum FuelType: String, Codable, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case diesel
    case petrol
    case electric
    case hybrid
    case plugInHybrid
    case hydrogen
    case naturalGas
    case propane
    case ethanol
    case other
    
    var name: String {
        switch self {
        case .diesel: return "Diesel"
        case .petrol: return "Petrol"
        case .electric: return "Electric"
        case .hybrid: return "Hybrid"
        case .plugInHybrid: return "Plug-in Hybrid"
        case .hydrogen: return "Hydrogen"
        case .naturalGas: return "Natural Gas"
        case .propane: return "Propane"
        case .ethanol: return "Ethanol"
        case .other: return "Other"
        }
    }
}

@Model
final class Vehicle: Equatable {
    @Attribute(.externalStorage) var profileImage: Data?
    var name: String
    var make: String
    var model: String
    var year: Int
    @Attribute(.unique) var vin: String
    var fuelType: FuelType
    
    // MARK: Initializers
    init(
        profileImage: Data?,
        name: String,
        make: String,
        model: String,
        year: Int,
        vin: String,
        fuelType: FuelType
    ) {
        self.profileImage = profileImage
        self.name = name
        self.make = make
        self.model = model
        self.year = year
        self.vin = vin
        self.fuelType = fuelType
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle)  -> Bool {
        lhs.profileImage == rhs.profileImage &&
        lhs.name == rhs.name &&
        lhs.make == rhs.make &&
        lhs.model == rhs.model &&
        lhs.year == rhs.year &&
        lhs.vin == rhs.vin &&
        lhs.fuelType == rhs.fuelType
    }
    
    static func empty() -> Vehicle {
        Vehicle(
            profileImage: nil,
            name: "",
            make: "",
            model: "",
            year: Date.currentYear,
            vin: "",
            fuelType: .electric
        )
    }
    
    static func mocks() -> [Vehicle] {
        [
            Vehicle(profileImage: nil, name: "Work Truck", make: "Ford", model: "F‑150", year: 2018, vin: "1FTFW1E50JFA12345", fuelType: .diesel),
            Vehicle(profileImage: nil, name: "City Runabout", make: "Toyota", model: "Corolla", year: 2021, vin: "JTDBL40E799123456", fuelType: .petrol),
            Vehicle(profileImage: nil, name: "Electric Commuter", make: "Tesla", model: "Model 3", year: 2022, vin: "5YJ3E1EA7NF123456", fuelType: .electric),
            Vehicle(profileImage: nil, name: "Family Hybrid", make: "Honda", model: "Accord Hybrid", year: 2020, vin: "1HGCV1F18LA123456", fuelType: .hybrid),
            Vehicle(profileImage: nil, name: "Plug‑in SUV", make: "Volvo", model: "XC90 Recharge", year: 2023, vin: "YV4A22PL0N1234567", fuelType: .plugInHybrid),
            Vehicle(profileImage: nil, name: "Future Fuel Cell", make: "Toyota", model: "Mirai", year: 2024, vin: "JTDKB20U790123456", fuelType: .hydrogen),
            Vehicle(profileImage: nil, name: "Compressed Gas Van", make: "Chevrolet", model: "Express", year: 2019, vin: "1GCWGAFP0K1234567", fuelType: .naturalGas),
            Vehicle(profileImage: nil, name: "Backyard Propane", make: "Dodge", model: "Ram 1500", year: 2017, vin: "1C6RR7XTXHS123456", fuelType: .propane),
            Vehicle(profileImage: nil, name: "Ethanol Beauty", make: "Ford", model: "Mustang FFV", year: 2015, vin: "1ZVBP8CH5F5123456", fuelType: .ethanol),
            Vehicle(profileImage: nil, name: "Mystery Power", make: "Unknown", model: "Model X‑Prime", year: 2025, vin: "XXXX0000YYYY1234", fuelType: .other)
        ]
    }
    
    var isEmpty: Bool {
        self == .empty()
    }
}
