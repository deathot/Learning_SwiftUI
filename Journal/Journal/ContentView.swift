//
//  ContentView.swift
//  Journal
//
//  Created by deathot on 11/2/24.
//

import SwiftUI

//@main
//struct MyApp: App {
//    var body: some Scene {
//#if os(iOS)
//        WindowGroup {
//            TabView {
//                ContentView()
//                    .tabItem() {
//                        Lable("Journal", systemImage: "book")
//                    }
//                SettingView()
//                    .tabItem {
//                        Lable("Settings", systemImage: "gear")
//                    }
//            }
//        }
//#elseif os(macOS)
//        WindowGroup {
//            AlternativeContentView()
//        }
//        
//        Settings {
//            SettingsView()
//        }
//#endif
//    }
//}
//#Preview {
//    WindowGroup()
//}

//@main
//struct ContentView: App {
//    var body: some Scene {
//        #if os(iOS)
//        MyScene()
//        #elseif os(macOS)
//        MyAlternativeScene()
//        #endif
//    }
//}

struct ContentView: View {
    var body: some View {
//        VStack {
//            HStack {
//                Picker("Choice", selection: $choice) {
//                    choiceList()
//                }
//                Button("OK") {
//                    applyChanges()
//                }
//            }
//            .controlSize(.mini)
//            
//            HStack {
//                Picker("Choice", selection: $choice) {
//                    choiceList()
//                }
//                Button("OK") {
//                    applyChanges()
//                }
//            }
//            .controlSize(.large)
//        }
        VStack {
            HStack {
                Rectangle()
                    .foregroundColor(.blue)
                Circle()
                    .foregroundColor(.orange)
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(.green)
            }
            .padding()
            .aspectRatio(3.0, contentMode: .fit)
            HStack {
                Rectangle()
                    .foregroundColor(.blue)
                Circle()
                    .foregroundColor(.orange)
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .foregroundColor(.green)
            }
            .padding()
            .aspectRatio(2.0, contentMode: .fit)
        }
    }
}

#Preview {
    ContentView()
}
