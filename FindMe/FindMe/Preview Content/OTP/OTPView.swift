//
//  OTPView.swift
//  FindMe
//
//  Created by deathot on 12/8/24.
//

import SwiftUI
import Alamofire

struct OTPView: View {
    
    @Binding var otpText: String
    @Binding var showSignUp: Bool
    
    func verifyOTP() {
        let otpValid = true
        
        if otpValid {
            showSignUp = false
            dismiss()
        } else {
            print("OTP Invalid")
        }
    }
    
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
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("An 6 digit code has been sent to your Email ID.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // custom otp TextField
                OTPVerificationView(otpText: $otpText)
                
                // SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    verifyOTP()
                }
                .hSpacing(.trailing)
                // Disabling until the data is entered
                .disableWithOpacity(otpText.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        // Since this is going to be a sheet
//        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
