//
//  SearchBar.swift
//  task03
//
//  Created by deathot on 11/17/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onCommit: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search for a place...", text: $searchText, onCommit: onCommit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: onCommit) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(8)
                    .background(Color(.systemGray4))
                    .cornerRadius(10)
            }
            .padding(.trailing, 8)
        }
        .padding(.vertical, 10)
    }
}
