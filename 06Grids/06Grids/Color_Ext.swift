//
//  Color_Ext.swift
//  06Grids
//
//  Created by deathot on 10/24/24.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(red: Double.random(in: 0...1),
                     green: Double.random(in: 0...1),
                     blue:  Double.random(in: 0...1)
                        )
    }
}
