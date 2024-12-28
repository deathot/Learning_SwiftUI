//
//  MapManager.swift
//  task03_3
//
//  Created by deathot on 11/17/24.
//

import Foundation
import MapKit

class MapManager: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    func search(for query: String, completion: @escaping ([MKMapItem]) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let response = response {
                completion(response.mapItems)
            } else {
                completion([])
            }
        }
    }
    
    func setRegion(for mapItem: MKMapItem) {
        region = MKCoordinateRegion(
            center: mapItem.placemark.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}
