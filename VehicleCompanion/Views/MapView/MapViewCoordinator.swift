//
//  MapViewCoordinator.swift
//  VehicleCompanion
//

import MapKit

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? MKClusterAnnotation {
            
            // TODO: handle gracefully
            let selection = annotation.memberAnnotations as! [POIAnnotation]
            parent.selectedPOIs = selection.map({ $0.poi })
        } else {
            if let annotation = view.annotation as? POIAnnotation {
                parent.selectedPOIs = [annotation.poi]
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? POIAnnotation else { return nil }
        
        return POIAnnotationView(annotation: annotation, reuseIdentifier: POIAnnotationView.ReuseID)
    }
}
