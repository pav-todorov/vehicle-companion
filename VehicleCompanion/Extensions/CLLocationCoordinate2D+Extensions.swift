//
//  CLLocationCoordinate2D+Extensions.swift
//  VehicleCompanion
//

import MapKit

extension CLLocationCoordinate2D: @retroactive Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
