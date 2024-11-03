//
//  ContentView.swift
//  07Pie&Dount_Charts
//
//  Created by deathot on 10/31/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pie chart goes here")
            }
            .padding()
            .navigationTitle("Revenue")
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

struct RevenueStream: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct MockData {
    static var revenueStreams: [RevenueStream] = [
        .init(name: "Adc", value: 806),
        .init(name: "Top", value: 805),
        .init(name: "Mid", value: 850),
        .init(name: "Sup", value: 763)
    ]
}
