//
//  ContainerForTest.swift
//  DataProvider
//
//  Created by deathot on 12/22/24.

@testable import DataProvider
import SwiftData
import Foundation

enum ContainerForTest {
    
    static func temp(_ name: String, delete: Bool = true) throws -> ModelContainer {
        let url = URL.temporaryDirectory.appending(component: name)
        if delete, FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
        
        let schema = Schema(CurrentScheme.models)
        let configuration = ModelConfiguration(url: url)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        return container
    }
}
