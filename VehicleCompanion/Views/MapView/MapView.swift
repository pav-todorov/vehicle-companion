//
//  MapView.swift
//  VehicleCompanion
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var places: [PoiUIModel]
    @Binding var selectedPOIs: [PoiUIModel]
    @State var annotations: [POIAnnotation] = []
    
    var mapRect: MKCoordinateRegion {
        getCoordinateRegion()
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView()
        
        view.delegate = context.coordinator
        view.setRegion(mapRect, animated: false)
        view.mapType = .standard
        
        return view
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        resetViewAnnotations(uiView)
        uiView.addAnnotations(toMapAnnotations(locations: places))
    }
    
    // Helper methods
    func resetViewAnnotations(_ uiView: MKMapView) {
        guard !uiView.annotations.isEmpty else { return }
        
        uiView.removeAnnotations(uiView.annotations)
    }
    
    func toMapAnnotations(locations: [PoiUIModel]) -> [POIAnnotation] {
        locations.map { POIAnnotation(coordinate: $0.loc, poi: $0) }
    }
    
    func getCoordinateRegion() -> MKCoordinateRegion{
        let northEastCoordinate = CLLocationCoordinate2D(latitude: 39.113254, longitude: -84.494260)
        let southWestCoordinate = CLLocationCoordinate2D(latitude: 39.079888, longitude: -84.540499)
        
        // -84.494260, 39.113254 - taken from task URL
        let pointNorthEast: MKMapPoint = .init(northEastCoordinate)
        
        // -84.540499, 39.079888 - taken from task URL
        let pointSouthWest: MKMapPoint = .init(southWestCoordinate)
        
        var antimeridianOverflow: Double {
            (northEastCoordinate.longitude > southWestCoordinate.longitude) ? 0 : MKMapSize.world.width
        }
        
        let originX: Double  = pointSouthWest.x
        let originY: Double = pointNorthEast.y
        let width: Double = (pointNorthEast.x - pointSouthWest.y) + antimeridianOverflow
        let height: Double = pointSouthWest.y - pointNorthEast.y
        
        return MKCoordinateRegion(.init(x: originX, y: originY, width: width, height: height))
    }
}
