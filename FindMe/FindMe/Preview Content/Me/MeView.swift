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
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -290)
                .padding(.bottom, -390)
            
            VStack(alignment: .leading) {
                Text("Hi, Welcome!")
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color.gray)
                Divider()
                
                HStack {
                    Text("BigGarlic")
                        .font(.title)
                    //                Spacer()
                    Text("")
                        .font(.title)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                Divider()
                
                HStack {
                    Text("你好")
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
