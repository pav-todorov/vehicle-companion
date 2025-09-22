//
//  POIAnnotationView.swift
//  VehicleCompanion
//

import MapKit

class POIAnnotationView: MKMarkerAnnotationView {
    
    static let ReuseID = "AnnotationViewReuseID"
    var poins: [PoiUIModel] = []
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        clusteringIdentifier = "ClusterID"
        
        if let annotation = annotation as? POIAnnotation {
            poins.append(annotation.poi)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
    }
}
