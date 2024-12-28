//
//  SchemaV1.swift
//  DataProvider
//
//  Created by deathot on 12/22/24.
//

import Foundation
import SwiftData

public typealias CurrentScheme = SchemaV1

public enum SchemaV1: VersionedSchema {
  public static var versionIdentifier: Schema.Version {
    .init(1, 0, 0)
  }

  public static var models: [any PersistentModel.Type] {
    [Item.self]
  }
}
