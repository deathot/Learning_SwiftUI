//
//  ContentView.swift
//  03Scroll_view
//
//  Created by deathot on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        ScrollView(.horizontal) {
            
            // horizontal arrangement
            HStack {
                ForEach(MocData.items) { item in
                    Circle()
                    
                    // circle nums in vertical and horizontal 
                        .containerRelativeFrame(.horizontal, count: verticalSizeClass == .regular ? 3 : 4, spacing: 10)
                        .foregroundStyle(item.color.gradient)
                        .scrollTransition { content, phase in content
                            
                            // change transprancy when swiping
                                .opacity(phase.isIdentity ? 1.0 : 0.1)
                            
                            // change size when swipng
                                .scaleEffect(x: phase.isIdentity ? 1.0 : 0.1,
                                             y: phase.isIdentity ? 1.0 : 0.2)
                            
                            // change angle when swiping
                                .offset(y: phase.isIdentity ? 0 : 50)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(12, for: .scrollContent)
        
        // align when swipe
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ContentView()
}

// Item instance have two argu
struct Item: Identifiable {
    let id = UUID()
    let color: Color
}

// MocData = items is a array for Item
struct MocData {
    static var items = [Item(color: .teal),
                        Item(color: .pink),
                        Item(color: .purple),
                        Item(color: .orange),
                        Item(color: .cyan),
                        Item(color: .blue),
                        Item(color: .mint),
                        Item(color: .accentColor),
                        Item(color: .cyan)
    ]
}
