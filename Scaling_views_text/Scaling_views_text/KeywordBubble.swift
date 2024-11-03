//
//  KeywordBubble.swift
//  Scaling_views_text
//
//  Created by deathot on 11/3/24.
//

import SwiftUI

// section 1 //

// define KeywordBubbleDefualtPadding view
struct KeywordBubbleDefualtPadding: View {
    // label's text and symbol's name is properties to reusable
    let keyword: String
    let symbol: String
    
    @ScaledMetric(relativeTo: .title) var paddingwidth = 14.5
    var body: some View {
        Label(keyword, systemImage: symbol)
            .font(.title)
            .foregroundColor(.white)
            .padding(paddingwidth)
            .background(.purple.opacity(0.95), in: Capsule())
    }
}

// use KeywordBubbleDefualtPadding above
struct KeywordBubbleDefualtPadding_Previews: PreviewProvider {
    // custom texts
    static let keywords = ["chives", "fern-leaf lavender"]
    static var previews: some View {
        VStack {
            // pass a text(word) for each lable's text
            ForEach(keywords, id: \.self) { word in
                KeywordBubbleDefualtPadding(keyword: word, symbol: "leaf")
            }
        }
    }
}
