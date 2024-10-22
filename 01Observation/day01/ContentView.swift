//
//  ContentView.swift
//  day01
//
//  Created by deathot on 10/15/24.
//

import SwiftUI
import Observation

@Observable class User {
    var name: String = ""
    var jobTitle: String = ""
    var bio: String = ""
    var followerCount: Int = 0
    
    init(name: String, jobTitle: String, bio: String, followerCount: Int) {
        self.name = name
        self.jobTitle = jobTitle
        self.bio = bio
        self.followerCount = followerCount
    }
}

struct ContentView: View {
    
    var user = User(name: "deathot",
                    jobTitle: "ios Dev YouTuber",
                    bio: "My bio goes here",
                    followerCount: 1)
    
    var body: some View{
        VStack(alignment: .leading) {
            Text(user.name)
                .font(.title.bold())
            Text(user.jobTitle)
                .foregroundStyle(.secondary)
            Text("\(user.followerCount) Followers")
                .foregroundStyle(.secondary)
            Button {
                user.followerCount += 1
            } label: {
                Text("Add Follower")
            }
            .buttonStyle(.bordered)
            .padding(.top, 30)
        }
        .padding(.top, 20)
    }
}

#Preview {
    ContentView()
}
