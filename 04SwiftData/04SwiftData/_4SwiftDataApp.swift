//
//  _4SwiftDataApp.swift
//  04SwiftData
//
//  Created by deathot on 10/21/24.
//

import SwiftUI
import SwiftData

@main
struct _4SwiftDataApp: App {
    
//    let container: ModelContainer = {
//        let schema = Schema([Expense.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    } ()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(container)
        
        // manage Expense date to use in app
        .modelContainer(for: [Expense.self])
    }
}
