//
//  StaticGridView.swift
//  06Grids
//
//  Created by deathot on 10/25/24.
//

import SwiftUI

struct StaticGridView: View {
    
    // init ison is false
    @State private var isOn = false
    
    var body: some View {
        
        // horizontal
        Grid(horizontalSpacing: 30, verticalSpacing: 30) {
            
            // GridRow 01
            GridRow {
                
                // roundedrectangle
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.gradient)
                    .frame(width: 130, height: 130)
                
                VStack {
                    Circle()
                        .foregroundStyle(.secondary)
                        .frame(width: 100, height: 100)
                        .padding(6)
                    Text("Circle")
                        .font(Font.custom("Pacifico-Regular", size: 20))
                }
                VStack {
                    
                    // button
                    Button("Click") {
                        //
                    }
                    .buttonStyle(.borderedProminent)
                    
                    //toggle
                    Toggle("Volume", isOn: $isOn)
                    
                    // hide lable
                        .labelsHidden()
                }
            }
            
            // divide line
            Divider()
            
            // GridRow 02
            GridRow {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.teal.gradient)
                    .frame(width: 130, height: 130)
                    .gridCellColumns(3)
            }
            .padding()
        }
    }
}

#Preview {
    StaticGridView()
}
