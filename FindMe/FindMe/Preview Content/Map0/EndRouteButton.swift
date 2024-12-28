//
//  EndRouteButton.swift
//  FindMe
//
//  Created by deathot on 12/24/24.
//

// EndRouteButton.swift

import SwiftUI
import MapKit

struct EndRouteButton: View {
    @Binding var routeDisplaying: Bool
    @Binding var showDetails: Bool
    @Binding var routeDestination: MKMapItem?
    @Binding var route: MKRoute?
    @Binding var cameraPostion: MapCameraPosition
    
    var body: some View {
        Button("End Route") {
            withAnimation(.snappy) {
                routeDisplaying = false
                showDetails = true
                routeDestination = nil
                route = nil
                cameraPostion = .region(.myRegion)
            }
        }
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(.red.gradient, in: .rect(cornerRadius: 15))
        .padding()
        .background(.ultraThinMaterial)
    }
}
