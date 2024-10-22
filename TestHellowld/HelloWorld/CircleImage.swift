//
//  CircleImage.swift
//  HelloWorld
//
//  Created by deathot on 10/14/24.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("catpg")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.gray, lineWidth: 3)
            }
//            .shadow(radius: 10)
    }
}

#Preview {
    CircleImage()
}
