//
//  ContentView.swift
//  HelloWorld
//
//  Created by deathot on 10/14/24.
//

import SwiftUI

struct MeView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 400)
            
            CircleImage()
                .offset(y: -290)
                .padding(.bottom, -390)
            
            VStack(alignment: .leading) {
                Text("Hello, World!")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color.gray)
                Divider()
                
                HStack {
                    Text("Sweet")
                        .font(.title)
                    //                Spacer()
                    Text("Honey.")
                        .font(.title)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                Divider()
                
                HStack {
                    Text("Gat, BigGarlic")
                        .font(.title2)
                    Text(":)")
                        .font(.title)
                }
                
            }
            
            .padding()
            
            Spacer()
        }
        
    }
    
}

#Preview {
    MeView()
}
