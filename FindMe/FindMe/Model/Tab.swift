//
//  Tab.swift
//  FindMe
//
//  Created by deathot on 12/24/24.
//

enum Tab: String, CaseIterable {
    
    case map = "Map"
    case peopele = "People"
    case chat = "Chat"
    case me = "Me"
    
    var symbol: String {
        
        switch self {
        case .map:
            "macbook.and.iphone"
        case .peopele:
            "figure.2.arms.open"
        case .chat:
            "circle.grid.2x2.fill"
        case .me:
            "person.circle.fill"
            
        }
    }
    
}
