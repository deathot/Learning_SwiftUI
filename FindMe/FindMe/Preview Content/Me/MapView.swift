//
//  MapView.swift
//  HelloWorld
//
//  Created by deathot on 10/14/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map(initialPosition: .region(region))
    }
    
    private var region: MKCoordinateRegion{
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.84_286, longitude: 116.366_868),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.6)
        )
    }
}

#Preview {
    MapView()
}
