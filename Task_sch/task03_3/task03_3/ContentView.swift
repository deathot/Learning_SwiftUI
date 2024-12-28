//
//  ContentView.swift
//  task03_3
//
//  Created by deathot on 11/17/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var showSearchView = false
    @StateObject private var mapManager = MapManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapManager.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        TextField("Search for a place", text: $searchText)
                            .padding(10)
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .onTapGesture {
                                showSearchView = true
                            }
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showSearchView) {
                MapSearchView(mapManager: mapManager)
            }
        }
    }
}
