//
//  ContentView.swift
//  06Grids
//
//  Created by deathot on 10/24/24.
//

import SwiftUI

struct LazyGridView: View {
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    //    let columns = [GridItem(.adaptive(minimum: 120))]
    let rows = Array(repeating: GridItem(.fixed(100)), count: 3)
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(MockData.colors, id: \.self) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill($0.gradient)
                        .frame(width: 100)
                }
            }
        }
        .padding()
    }
}
        /*        // scrollview
         ScrollView {
         
         // every row have how many grids
         LazyVGrid(columns: columns, spacing: 40, pinnedViews: .sectionHeaders) {
         /*LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])*/
         
         // block display and add title
         Section {
         
         // traversing MocData.colors
         ForEach(MockData.colors, id: \.self) {
         RoundedRectangle(cornerRadius: 16)
         .fill($0.gradient)
         .frame(height: 100)
         }
         
         // title text
         } header: {
         Text("Favourites")
         .font(Font.custom("Pacifico-Regular", size: 45))
         //                        .font(.largeTitle.bold())
         .frame(maxWidth: .infinity, alignment: .leading)
         }
         
         Section {
         
         // traversing MocData.colors
         ForEach(MockData.colors, id: \.self) {
         RoundedRectangle(cornerRadius: 16)
         .fill($0.gradient)
         .frame(height: 100)
         }
         } header: {
         Text("Normal")
         .font(Font.custom("Pacifico-Regular", size: 45))
         //                        .font(.largeTitle.bold())
         .frame(maxWidth: .infinity, alignment: .leading)
         }
         }
         
         }
         .padding()
         //            Text("Welocme, deathot!").font(Font
         //                .custom("Pacifico-Regular", size: 40))
         }
         }*/
#Preview {
    LazyGridView()
}
