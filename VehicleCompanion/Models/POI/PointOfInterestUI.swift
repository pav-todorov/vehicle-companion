//
//  POIUIMOdel.swift
//  VehicleCompanion
//

import Foundation
import SwiftData
import MapKit

@Model
final class PoiUIModel: Equatable, Identifiable {
    init(from dto: PoiDTO) {
        id = dto.id
        name = dto.name
        url = dto.url
        primaryCategoryDisplayName = .init(rawValue: dto.primaryCategoryDisplayName) ?? .notAvailable
        rating = dto.rating
        iconUrl = URL(string: dto.iconUrl)
        loc = CLLocationCoordinate2D(latitude: dto.loc[1], longitude: dto.loc[0])
    }
    
    @Attribute(.unique) var id: Int
    var name: String
    var url: String
    var primaryCategoryDisplayName: Category
    var rating: Double?
    var iconUrl: URL?
    var loc: CLLocationCoordinate2D
    
    static func mock() -> Self {
        .init(from: PoiDTO.mock())
    }
    
    static func mocks() -> [PoiUIModel] {
        PoiDTO.mocks().map { .init(from: $0) }
    }
    
    // Equatable
    static func == (lhs: PoiUIModel, rhs: PoiUIModel)  -> Bool {
        lhs.id == rhs.id
    }
}
