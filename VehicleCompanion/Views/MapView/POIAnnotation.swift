//
//  POIAnnotation.swift
//  VehicleCompanion
//

import MapKit

class POIAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let poi: PoiUIModel
    
    var title: String?
    
    init(
        coordinate: CLLocationCoordinate2D,
        poi: PoiUIModel
    ) {
        self.coordinate = coordinate
        self.poi = poi
        super.init()
        
        title = poi.name
    }
}
