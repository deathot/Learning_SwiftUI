//
//  MocData.swift
//  06Grids
//
//  Created by deathot on 10/24/24.
//

import SwiftUI

struct MockData {
    static var colors: [Color] {
        var array: [Color] = []
        for _ in 0..<30 { array.append(Color.random) }
        return array
    }
}
