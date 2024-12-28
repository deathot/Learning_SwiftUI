//
//  HomeView.swift
//  FindMe
//
//  Created by deathot on 12/23/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    // User Location
                    if let location = locationManager.location {
                        region.center = location.coordinate
                    }
                }
                .onChange(of: locationManager.location) { newLocation in
                    if let newLocation = newLocation {
                        region.center = newLocation.coordinate
                    }
                }

            if locationManager.location == nil {
                VStack {
                    Text("Getting the location")
                        .font(.headline)
                        .foregroundColor(.white)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}







