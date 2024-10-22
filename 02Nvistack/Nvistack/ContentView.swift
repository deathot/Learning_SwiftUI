//
//  ContentView.swift
//  Nvistack
//
//  Created by deathot on 10/15/24.
//

import SwiftUI

struct ContentView: View {
    
    var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                 .init(name: "Playstation", imageName: "playstation.logo", color: .indigo),
                                 .init(name: "PC", imageName: "pc", color: .accentColor),
                                 .init(name: "Mobile", imageName: "iphone", color: .mint)]
    
    var games: [Game] = [.init(name: "Minecraft", rating: "99"),
                         .init(name: "League of Legends", rating: "99"),
                         .init(name: "OverWatch", rating: "99"),
                         .init(name: "SyberPunk 2077", rating: "99")]
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platforms") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }
                
                Section("Games") {
                    ForEach(games, id: \.name) {game in
                        NavigationLink(value: game) {
                            Text(game.name)
                        }
                    }
//                    Button("Add Games") {
//                        path = games
//                    }
                }
            }
            
            .navigationTitle("Gaming")
            
            .navigationDestination(for: Platform.self) { platform in
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle).bold()
                        
                        List {
                            ForEach(games, id: \.name) {game in
                                NavigationLink(value: game) {
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())
                    
                    Button("Recommended game") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go to another platform") {
                        path.append(games.randomElement()!)
                    }
                    
                    Button("Go home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

