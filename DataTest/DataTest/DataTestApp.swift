//
//  DataTestApp.swift
//  DataTest
//
//  Created by deathot on 12/22/24.
//

import SwiftUI
import DataProvider
import SwiftData

@main
struct DataTestApp: App {
    
    let dataProvider = DataProvider.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.createDataHandler, dataProvider.dataHandlerCreator())
                .environment(\.createDataHandlerWithMainContext, dataProvider.dataHandlerWithMainContextCreator())
        }
        .modelContainer(dataProvider.sharedModelContainer)
    }
}
