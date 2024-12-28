//
//  Login.swift
//  FindMe
//
//  Created by deathot on 12/5/24.
//

import SwiftUI

struct Login: View {
    
    @Binding var showSignUp: Bool
    @Binding var isLoggedIn: Bool
    // View Properties
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var showForgotPasswordView: Bool = false
    // reset password view (with new password and confimration password view)
    @State private var showResetView: Bool = false
    // optional, present if you want to ask otp for login
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""
//    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            Spacer(minLength: 0)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true,  value: $password)
                    .padding(.top, 20)
                
                Button("Forget Password?") {
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.indigo)
                .hSpacing(.trailing)
                
                // Login Button
                GradientButton(title: "Login", icon: "arrow.right") {
//                        askOTP.toggle()
                    login()
                }
                .hSpacing(.trailing)
                // Disabling until the data is entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("SignUp") {
                    showSignUp.toggle()
                }
                .fontWeight(.bold)
                .tint(.purple)
            }
            .font(.callout)
            .hSpacing()
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        // asking email id for sending reset link
        .sheet(isPresented: $showForgotPasswordView, content: {
            if #available(iOS 16.4, *) {
                // since i wanted a custom sheet corner radius
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(340)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showResetView: $showResetView)
                    .presentationDetents([.height(300)])
            }
        })
        // reseting new password
        .sheet(isPresented: $showResetView, content: {
            if #available(iOS 16.4, *) {
                // since i wanted a custom sheet corner radius
                PasswordResetView()
                    .presentationDetents([.height(340)])
                    .presentationCornerRadius(30)
            } else {
                PasswordResetView()
                    .presentationDetents([.height(340)])
            }
        })
        // otp prompt
        .sheet(isPresented: $askOTP, content: {
            if #available(iOS 16.4, *) {
                // since i wanted a custom sheet corner radius
                OTPView(otpText: $otpText, showSignUp: $showSignUp)
                    .presentationDetents([.height(340)])
                    .presentationCornerRadius(30)
            } else {
                OTPView(otpText: $otpText, showSignUp: $showSignUp)
                    .presentationDetents([.height(340)])
            }
        })
    }
    
    private func login() {
        isLoggedIn = true
    }
}

#Preview {
    ContentView()
}
