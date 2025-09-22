//
//  PointOfInterestDTO.swift
//  VehicleCompanion
//

import Foundation

actor POIDto: @preconcurrency Codable {
    let pois: [PoiDTO]
}

enum Category: String, Codable {
    case attractionsAndCulture = "Attractions & Culture"
    case pointsOfInterest = "Points of Interest"
    case outdoorsAndRecreation = "Outdoors & Recreation"
    case toursAndExperiences = "Tours & Experiences"
    case foodAndDrink = "Food & Drink"
    case accommodation = "Accommodation"
    case entertainmentAndNightlife = "Entertainment & Nightlife"
    case sports = "Sports"
    case notAvailable = "N/A"
    
    var symbolName: String {
        switch self {
        case .attractionsAndCulture:
            "building.columns"
        case .pointsOfInterest:
            "star"
        case .outdoorsAndRecreation:
            "leaf"
        case .toursAndExperiences:
            "map"
        case .foodAndDrink:
            "fork.knife"
        case .accommodation:
            "bed.double"
        case .entertainmentAndNightlife:
            "music.quarternote.3"
        case .sports:
            "figure.run"
        case .notAvailable:
            "mappin.and.ellipse"
        }
    }
}

// MARK: - Pois
actor PoiDTO:
    @preconcurrency Codable,
    @preconcurrency CustomStringConvertible
{
    let id: Int
    let name, url, primaryCategoryDisplayName: String
    let rating: Double?
    let iconUrl: String
    let loc: [Double]
    
    init(id: Int, name: String, url: String, primaryCategoryDisplayName: String, rating: Double?, iconUrl: String, loc: [Double]) {
        self.id = id
        self.name = name
        self.url = url
        self.primaryCategoryDisplayName = primaryCategoryDisplayName
        self.rating = rating
        self.iconUrl = iconUrl
        self.loc = loc
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, url
        case primaryCategoryDisplayName = "primary_category_display_name"
        case rating
        case iconUrl = "v_320x320_url"
        case loc
    }
    
    static func mock() -> Self {
        .init(
            id: 22606,
            name: "Cincinnati Museum Center",
            url: "https://maps.roadtrippers.com/us/cincinnati-oh/attractions/cincinnati-museum-center",
            primaryCategoryDisplayName: "Attractions & Culture",
            rating: 4.5,
            iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026827998/-strip_-quality_60_-interlace_Plane_-resize_320x320_U__-gravity_center_-extent_320x320/place_image-image-2ea174a8-c719-45f8-bc23-d91102a96163.jpg",
            loc: [-84.537158, 39.109946]
        )
    }
    
    static func mocks() -> [PoiDTO] {
        [
            PoiDTO(
                id: 1,
                name: "Cincinnati Museum Center",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/attractions/cincinnati-museum-center",
                primaryCategoryDisplayName: Category.attractionsAndCulture.rawValue,
                rating: 4.5,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026827998/place_image-image-2ea174a8.jpg",
                loc: [-84.537158, 39.109946]
            ),
            PoiDTO(
                id: 2,
                name: "Fountain Square",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/points-of-interest/fountain-square",
                primaryCategoryDisplayName: Category.pointsOfInterest.rawValue,
                rating: 4.6,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026827999/fountain.jpg",
                loc: [-84.512024, 39.101453]
            ),
            PoiDTO(
                id: 3,
                name: "Eden Park",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/outdoors/eden-park",
                primaryCategoryDisplayName: Category.outdoorsAndRecreation.rawValue,
                rating: 4.7,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828000/eden-park.jpg",
                loc: [-84.493271, 39.116222]
            ),
            PoiDTO(
                id: 4,
                name: "Queen City Ghost Tour",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/tours/queen-city-ghost-tour",
                primaryCategoryDisplayName: Category.toursAndExperiences.rawValue,
                rating: 4.2,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828001/ghost-tour.jpg",
                loc: [-84.514275, 39.103047]
            ),
            PoiDTO(
                id: 5,
                name: "Taste of Belgium",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/food/taste-of-belgium",
                primaryCategoryDisplayName: Category.foodAndDrink.rawValue,
                rating: 4.8,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828002/taste.jpg",
                loc: [-84.512345, 39.108726]
            ),
            PoiDTO(
                id: 6,
                name: "The Lytle Park Hotel",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/hotels/lytle-park-hotel",
                primaryCategoryDisplayName: Category.accommodation.rawValue,
                rating: 4.9,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828003/lytle.jpg",
                loc: [-84.504152, 39.102828]
            ),
            PoiDTO(
                id: 7,
                name: "Bogart's Music Venue",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/music/bogarts",
                primaryCategoryDisplayName: Category.entertainmentAndNightlife.rawValue,
                rating: 4.4,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828004/bogarts.jpg",
                loc: [-84.509755, 39.131298]
            ),
            PoiDTO(
                id: 8,
                name: "Great American Ball Park",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/sports/great-american-ball-park",
                primaryCategoryDisplayName: Category.sports.rawValue,
                rating: 4.7,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828005/ballpark.jpg",
                loc: [-84.50702, 39.09788]
            ),
            PoiDTO(
                id: 9,
                name: "Mystery Spot",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/points-of-interest/mystery-spot",
                primaryCategoryDisplayName: Category.notAvailable.rawValue,
                rating: nil,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828006/mystery.jpg",
                loc: [-84.509142, 39.101723]
            ),
            PoiDTO(
                id: 10,
                name: "Cincinnati Art Museum",
                url: "https://maps.roadtrippers.com/us/cincinnati-oh/museums/cincinnati-art-museum",
                primaryCategoryDisplayName: Category.attractionsAndCulture.rawValue,
                rating: 4.6,
                iconUrl: "https://atlas-assets.roadtrippers.com/uploads/place_image/image/1026828007/art-museum.jpg",
                loc: [-84.495495, 39.113104]
            )
        ]
    }
    
    var description: String {
        """
        \nPoisDTO(
            id: \(id),
            name: \(name),
            url: \(url),
            primaryCategoryDisplayName: \(primaryCategoryDisplayName),
            rating: \(String(describing: rating)),
            iconUrl: \(iconUrl),
            loc: \(loc[0]), \(loc[1])
        )
        """
    }
}
