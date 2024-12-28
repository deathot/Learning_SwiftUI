//
//  ContentView.swift
//  FindMe
//
//  Created by deathot on 12/5/24.
//

import SwiftUI

struct ContentView: View {
    
    // View Properties
    @State private var showSignUp: Bool = false
    // keyboard status
    @State private var iskeyboardShowing: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        
        ZStack {
            if !isLoggedIn && !showSignUp {
                Login(showSignUp: $showSignUp, isLoggedIn: $isLoggedIn)
                    .transition(.move(edge: .trailing))
            }
            
            if showSignUp {
                Signup(showSignUp: $showSignUp)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
            if isLoggedIn {
                Main0View()
                    .transition(.move(edge: .trailing))
                    .zIndex(0)
            }
            
        }
        .overlay {
            if !isLoggedIn {
                // ios17 bounce animations
                if #available(iOS 17, *) {
                    // since this project support ios 16 too
                    CircleView()
                        .animation(.smooth(duration: 0.95, extraBounce: 0), value: showSignUp)
                        .animation(.smooth(duration: 0.95, extraBounce: 0), value: iskeyboardShowing)
                } else {
                    CircleView()
                        .animation(.easeInOut(duration: 0.45), value: showSignUp)
                        .animation(.easeInOut(duration: 0.45), value: iskeyboardShowing)
                }
            }
        }
    }
    
    // Moving Blurred background
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.indigo, .indigo, .indigo], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
        // Moving when the signup pages Loads/Dismisses
            .offset(x: showSignUp ? 90 : -90, y: -400 - (iskeyboardShowing ? 200 : 0))
            .blur(radius: 90)
            .hSpacing(showSignUp ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    ContentView()
}
