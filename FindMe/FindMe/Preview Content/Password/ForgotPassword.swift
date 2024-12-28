//
//  ForgotPassword.swift
//  FindMe
//
//  Created by deathot on 12/8/24.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var showResetView: Bool
    // View Properties
    @State private var emailID: String = ""
    // Environment Properties
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            // back button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 1)
            
            Text("Forgot Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("Pleaes enter your Email ID so that we can send the reset link")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)

                // SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    // your code
                    // after the link sent
                    Task {
                        dismiss()
                        try?  await Task.sleep(for: .seconds(0))
                        // showing the reset view
                        showResetView = true
                    }
                }
                .hSpacing(.trailing)
                // Disabling until the data is entered
                .disableWithOpacity(emailID.isEmpty)
            }
            .padding(.top, 20)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        // Since this is going to be a sheet
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
