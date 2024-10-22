//
//  Expense.swift
//  04SwiftData
//
//  Created by deathot on 10/21/24.
//

import Foundation
import SwiftData

// date struct for Expnese
@Model
class Expense {
    
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
