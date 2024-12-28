//
//  Main0.swift
//  FindMe
//
//  Created by deathot on 12/24/24.
//

import Foundation
import SwiftUI

struct Main0View: View {
    
    var body: some View {
        
        TabView {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Group {
                    switch tab {
                    case .map:
                        Map0View()
                    case .peopele:
                        HomeView()
                    case .chat:
                        ChatView()
                    case .me:
                        MeView()
                    }
                }
                .tag(tab)
                .tabItem {
                    Image(systemName: tab.symbol)
                    Text(tab.rawValue) 
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    Main0View()
}



