//
//  GradientButton.swift
//  FindMe
//
//  Created by deathot on 12/6/24.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing:15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.indigo, .indigo, .indigo], startPoint:
                    .top, endPoint: .bottom), in: .capsule)
        })
    }
}

#Preview {
    ContentView()
}
