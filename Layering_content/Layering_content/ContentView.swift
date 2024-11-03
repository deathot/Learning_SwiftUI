//
//  ContentView.swift
//  Layering_content
//
//  Created by deathot on 11/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CaptionedPhoto(assetName: "Pink_Peony", captionText: "A cluster of bright pink peonies with yello stamens")
        }
    }
}

#Preview {
    ContentView()
}
