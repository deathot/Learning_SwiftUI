//
//  ItemV1.swift
//  DataProvider
//
//  Created by deathot on 12/22/24.
//

import Foundation
import SwiftData

public typealias Item = SchemaV1.Item

extension SchemaV1 {
  @Model
  public final class Item {
    public var timestamp: Date
    public var createTimestamp: Date

    public init(timestamp: Date) {
      self.timestamp = timestamp
      createTimestamp = .now
    }
  }
}
