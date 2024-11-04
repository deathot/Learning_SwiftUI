//
//  CaptionedPhoto.swift
//  Layering_content
//
//  Created by deathot on 11/3/24.
//

import SwiftUI

struct CaptionedPhoto: View {
    // delcaring properties
    let assetName: String
    let captionText: String
    
    var body: some View {
        // part1 image
        Image(assetName)
            .resizable()
            .scaledToFit()
        // part2 caption, add a text in bottom of the image
            .overlay(alignment: .bottom) {
                Caption(text: captionText)
            }
        // rounds the corner for the imaghe
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}

// part2 caption -> text and bakcground
struct Caption: View {
    // delcaring text same as above 
    let text: String
    
    var body: some View {
        Text(text)
            .padding()
        // add an background for text
            .background(Color("TextContrast").opacity(0.75),
                        in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding()
    }
}

struct CaptionedPhoto_Previews: PreviewProvider {
    // assign the value to CaptionPhoto
    static let landscapeName = "Landscape"
    static let landscapeCaption = "This photo is wider than it is tall."
    static let portraitName = "Portrait"
    static let portraitCaption = "This photo is taller than it is wide."
    
    static var previews: some View {
        CaptionedPhoto(assetName: portraitName,
                       captionText: portraitCaption)
        CaptionedPhoto(assetName: landscapeName,
                       captionText: landscapeCaption)
    }
}
