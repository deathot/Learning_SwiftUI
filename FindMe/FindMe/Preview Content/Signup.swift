//
//  Signup.swift
//  FindMe
//
//  Created by deathot on 12/8/24.
//

//import SwiftUI
//import Alamofire
//
//struct Signup: View {
//    
//    @Binding var showSignUp: Bool
//    // View Properties
//    @State private var emailID: String = ""
//    @State private var password: String = ""
//    @State private var fullName: String = ""
//    // optional, present if you want to ask otp for signup
//    @State private var askOTP: Bool = false
//    @State private var otpText: String = ""
//    
//    func sendOTP(to: String) {
//        let parameters: [String: Any] = [
//            "PhoneNumber": to,
//            "TemplateCode": "your-template-code",
//            "AccessKeyId": "your api key",
//            "AccessKeySecret": "your api key"
//        ]
//        
//        // Call Aly cloud's api to send verification code
//        AF.request("https://sms.aliyuncs.com/", method: .post, parameters: parameters, encoding: URLEncoding.default)
//            .responseJSON { response in
//                switch response.result {
//                case .success(let value):
//                    print("OTP sent successfully: \(value)")
//                case .failure(let error):
//                    print("Failed to send OTP: \(error)")
//                    if let data = response.data {
//                        // Print http data
//                        if let responseString = String(data: data, encoding: .utf8) {
//                            print("Raw response data: \(responseString)")
//                        }
//                    }
//                }
//            }
//
//    }
//    
//    // Continue button handler
//    func handleSignUp() {
//        guard !emailID.isEmpty, !password.isEmpty, !fullName.isEmpty else {
//            print("Please enter full info")
//            return
//        }
//        
//        if !isValidEmail(emailID) {
//            print("invalid format")
//            return
//        }
//        
//        if password.count < 8 {
//            print("password >= 8")
//            return
//        }
//        
//        // Save info to defaultclass
//        saveUserInfoToDefaults()
//
//        // Send code
//        sendOTP(to: emailID)
//        askOTP.toggle()
//    }
//    
//    // save user info to UserDefaults
//    func saveUserInfoToDefaults() {
//        UserDefaults.standard.set(emailID, forKey: "userEmail")
//        UserDefaults.standard.set(password, forKey: "userPassword")
//        UserDefaults.standard.set(fullName, forKey: "userFullName")
//        print("User info saved")
//    }
//    
//    func isValidEmail(_ email: String) -> Bool {
//        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
//        return emailPredicate.evaluate(with: email)
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15, content: {
//            // back button
//            Button(action: {
//                showSignUp = false
//            }, label: {
//                Image(systemName: "arrow.left")
//                    .font(.title2)
//                    .foregroundStyle(.gray)
//            })
//            .padding(.top, 1)
//            
//            Text("SignUp")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 60)
//            
//            Text("Please sign up to continue")
//                .font(.callout)
//                .fontWeight(.semibold)
//                .foregroundStyle(.gray)
//                .padding(.top, -5)
//            
//            VStack(spacing: 25) {
//                // Custom Text Fields
//                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
//                
//                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
//                    .padding(.top, 20)
//                
//                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true,  value: $password)
//                    .padding(.top, 20)
//                
//                // SignUp Button
//                GradientButton(title: "Continue", icon: "arrow.right") {
//                    // Signup handler
//                    handleSignUp()
////                    askOTP.toggle()
//                }
//                .hSpacing(.trailing)
//                // Disabling until the data is entered
//                .disableWithOpacity(emailID.isEmpty || password.isEmpty || fullName.isEmpty)
//            }
//            .padding(.top, 20)
//            
//            Spacer(minLength: 0)
//            
//            HStack(spacing: 6) {
//                Text("Already have an account?")
//                    .foregroundStyle(.gray)
//                
//                Button("Login") {
//                    showSignUp = false
//                }
//                .fontWeight(.bold)
//                .tint(.purple)
//            }
//            .font(.callout)
//            .hSpacing()
//        })
//        .padding(.vertical, 15)
//        .padding(.horizontal, 25)
//        .toolbar(.hidden, for: .navigationBar)
//        // otp prompt
//        .sheet(isPresented: $askOTP, content: {
//            if #available(iOS 16.4, *) {
//                // since i wanted a custom sheet corner radius
//                OTPView(otpText: $otpText, showSignUp: $showSignUp)
//                    .presentationDetents([.height(340)])
//                    .presentationCornerRadius(30)
//            } else {
//                OTPView(otpText: $otpText, showSignUp: $showSignUp)
//                    .presentationDetents([.height(340)])
//            }
//        })
//    }
//}
//
//#Preview {
//    ContentView()
//}


import SwiftUI
import Alamofire
import CommonCrypto

struct Signup: View {
    
    @Binding var showSignUp: Bool
    // View Properties
    @State private var emailID: String = ""
    @State private var password: String = ""
    @State private var fullName: String = ""
    // optional, present if you want to ask otp for signup
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""

    func calculateSignature(parameters: [String: Any], secret: String) -> String? {
        // 将所有参数按字典排序
        let sortedParameters = parameters.sorted { $0.key < $1.key }
        
        // 拼接成查询字符串（URL 参数）
        var queryString = ""
        for (key, value) in sortedParameters {
            queryString += "\(key)=\(value)&"
        }
        queryString = String(queryString.dropLast())  // 删除最后的 '&'
        
        // 计算签名字符串
        let stringToSign = "POST&%2F&" + percentEncode(queryString)
        
        // 使用 HMAC-SHA1 计算签名
        guard let keyData = secret.data(using: .utf8),
              let stringToSignData = stringToSign.data(using: .utf8) else {
            return nil
        }
        
        var signatureData = Data(count: Int(CC_SHA1_DIGEST_LENGTH))
        
        _ = signatureData.withUnsafeMutableBytes { signatureBytes in
            stringToSignData.withUnsafeBytes { stringToSignBytes in
                CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1),
                       keyData.withUnsafeBytes { $0.baseAddress }, keyData.count,
                       stringToSignBytes.baseAddress, stringToSignData.count,
                       signatureBytes.baseAddress)
            }
        }
        
        return signatureData.base64EncodedString()
    }


    // URL 编码
    func percentEncode(_ string: String) -> String {
        let allowedCharacterSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.~")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }

    // 发送邮件
    func sendEmail(to: String) {
        // 获取当前时间（UTC 时间）
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let timestamp = dateFormatter.string(from: Date())
        
        // 生成一个唯一的 SignatureNonce
        let signatureNonce = UUID().uuidString
        
        let parameters: [String: Any] = [
            "AccountName": "你的发件邮箱",  // 你在阿里云配置的发件邮箱
            "ReplyToAddress": "true",
            "AddressType": "1",  // 发件人类型，1为系统邮件
            "ToAddress": to,  // 收件人邮箱地址
            "Subject": "欢迎注册您的账户",  // 邮件主题
            "HtmlBody": "<h1>欢迎，\(fullName)！</h1><p>感谢注册我们的应用！</p>",  // 邮件内容
            "FromAlias": "你的发件人别名",  // 发件人显示名称（可选）
            "AccessKeyId": "your api key",  // 填入你的AccessKeyId
            "Version": "2015-11-23",  // API版本
            "Action": "SingleSendMail",  // 调用发送邮件的Action
            "Timestamp": timestamp,  // 当前时间
            "SignatureNonce": signatureNonce,  // 签名随机值
            "SignatureMethod": "HMAC-SHA1"  // 签名方式
        ]
        
        // 计算签名
        guard let signature = calculateSignature(parameters: parameters, secret: "你的AccessKeySecret") else {
            print("Failed to calculate signature")
            return
        }
        
        // 添加签名到参数中
        var finalParameters = parameters
        finalParameters["Signature"] = signature
        
        // 调用阿里云邮件 API 发送邮件
        AF.request("https://dm.aliyuncs.com/", method: .post, parameters: finalParameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("邮件发送成功: \(value)")
                case .failure(let error):
                    print("邮件发送失败: \(error)")
                    if let data = response.data {
                        // 打印 HTTP 原始数据
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Raw response data: \(responseString)")
                        }
                    }
                }
            }
    }

    // Continue button handler
    func handleSignUp() {
        guard !emailID.isEmpty, !password.isEmpty, !fullName.isEmpty else {
            print("Please enter full info")
            return
        }
        
        if !isValidEmail(emailID) {
            print("invalid format")
            return
        }
        
        if password.count < 8 {
            print("password >= 8")
            return
        }
        
        // Save info to defaultclass
        saveUserInfoToDefaults()

        // 发送邮件
        sendEmail(to: emailID)
        askOTP.toggle()
    }
    
    // save user info to UserDefaults
    func saveUserInfoToDefaults() {
        UserDefaults.standard.set(emailID, forKey: "userEmail")
        UserDefaults.standard.set(password, forKey: "userPassword")
        UserDefaults.standard.set(fullName, forKey: "userFullName")
        print("User info saved")
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            // back button
            Button(action: {
                showSignUp = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 1)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 60)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 20)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true,  value: $password)
                    .padding(.top, 20)
                
                // SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right") {
                    // Signup handler
                    handleSignUp()
                }
                .hSpacing(.trailing)
                // Disabling until the data is entered
                .disableWithOpacity(emailID.isEmpty || password.isEmpty || fullName.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("Login") {
                    showSignUp = false
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
}

#Preview {
    ContentView()
}
