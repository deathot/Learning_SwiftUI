//
//  MapSearchView.swift
//  task03_3
//
//  Created by deathot on 11/17/24.
//

import SwiftUI
import MapKit

struct MapSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText: String = ""
    @State private var searchResults: [MKMapItem] = []
    @ObservedObject var mapManager: MapManager
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for a place", text: $searchText, onCommit: performSearch)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                
                List(searchResults, id: \.self) { mapItem in
                    VStack(alignment: .leading) {
                        Text(mapItem.name ?? "Unknown")
                            .font(.headline)
                        Text(mapItem.placemark.title ?? "")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        mapManager.setRegion(for: mapItem)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func performSearch() {
        mapManager.search(for: searchText) { results in
            self.searchResults = results
        }
    }
}
