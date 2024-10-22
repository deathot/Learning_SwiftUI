//
//  SwiftUIView01.swift
//  Formtask.swift
//
//  Created by deathot on 10/17/24.
//

import SwiftUI

import SwiftUI

struct FirstView: View {
    @State private var dataToPass = "Hi, Welcome."
    @State private var bindingData = "Hi, Welcome."
    @State private var Name = "肖国豪"
    @State private var StuID = "221409040425"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("First View")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Data to Pass:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(dataToPass)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    
                    Text("Binding Data:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(bindingData)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    
                    Text("Name:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(Name)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    
                    Text("StuID:")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text(StuID)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .padding(.horizontal, 20)
                
                VStack(spacing: 20) { // 两个按钮之间的垂直间距
                    // NavigationLink to SecondViewByProperty
                    NavigationLink(destination: SecondViewByProperty(receivedData: dataToPass)) {
                        Text("Go to Second View (By Property)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 20)
                    
                    // NavigationLink to SecondViewByBinding
                    NavigationLink(destination: SecondViewByBinding(receivedData: $bindingData)) {
                        Text("Go to Second View (By Binding)")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 20)
                    

                }
                
                Spacer()
            }
            .navigationTitle("First View")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(UIColor.systemGray5)]), startPoint: .top, endPoint: .bottom)
            )
        }
    }
}
//use property view
struct SecondViewByProperty: View {
    var receivedData: String
    @State private var name = ""
    @State private var stdid = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Second View (By Property)")
                        .font(.title)
                }
                
                Section {
                    Text("Received Data: \(receivedData)")
                        .font(.title2)
                        .padding()
                }
                
                Section {
                    TextField("Enter your name", text: $name)
                        .font(.title2)
                    Text("Your name is \(name)")
                        .font(.title2)
                    TextField("Enter your Student ID", text: $stdid)
                        .font(.title2)
                    Text("Your Student ID is \(stdid)")
                        .font(.title2)
                }
            }
            .navigationTitle("Second View")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

//use binding
struct SecondViewByBinding: View {
    @Binding var receivedData: String
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Second View (By Binding)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            TextField("Edit Binding Data", text: $receivedData)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 3)
                .padding([.leading, .trailing], 20)
            
            VStack {
                Text("Updated Binding Data:")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(receivedData)
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .shadow(radius: 3)
            }
            .padding([.leading, .trailing], 20)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
            .preferredColorScheme(.dark)
    }
}
