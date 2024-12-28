//
//  LocationSearchViewModel.swift
//  task03
//
//  Created by deathot on 11/17/24.
//

import Foundation
import MapKit

class LocationSearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [MKMapItem] = []
    @Published var annotations: [MKPointAnnotation] = []
    
    func performSearch() {
        guard !searchQuery.isEmpty else {
            searchResults = []
            return
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self?.searchResults = response.mapItems
            }
        }
    }
    
    func selectPlace(_ place: MKMapItem) {
        let annotation = MKPointAnnotation()
        annotation.title = place.name
        annotation.coordinate = place.placemark.coordinate
        annotations = [annotation]
    }
}
