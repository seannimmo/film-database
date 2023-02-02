//
//  LoginView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/12/22.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginRequest: LoginRequest
    @State private var username = ""
    @State private var validated = false
    @State private var loginAttempted = false
    @State private var message = ""

    var body: some View {
        NavigationView {
            VStack {
                
                Text("The Film Database")
                    .font(.title)
                    .offset(y: -80)
                
                loginMessage
                
                if (!loginRequest.isLoggedIn) {
                    TextBoxView(username: $username)
                } else {
                    Text(username)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .accentColor(.red)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.001, saturation: 0.204, brightness: 0.903)/*@END_MENU_TOKEN@*/)
                        .cornerRadius(30.0)
                }
                HStack {
                    if !loginRequest.isLoggedIn {
                        skipButton
                    }
                    
                    Spacer()
                    
                    if !loginRequest.isLoggedIn {
                        loginButton
                    } else if loginRequest.isLoggedIn {
                        continueButton
                    }
                }
                .padding()
                Spacer()
            }
            .padding()
        }
    }
    
    var loginMessage: some View {
        if !validated && loginAttempted{
            return Text(message)
        } else if validated && (loginRequest.isLoggedIn){
            return Text("Login successful")
        } else if validated && loginAttempted && (!loginRequest.isLoggedIn){
            return Text("Username valid but login failed")
        } else {
            return Text(" ")
        }
    }
    
    var skipButton: some View {
        return NavigationLink(destination: FilmListView(), label: {
            Label("Skip", systemImage: "arrow.right.circle")
                .foregroundColor(.red)
        })
    }
    
    var loginButton: some View {
        return Button(action: {
            (validated, message) = validateUsername(username: username)
            loginAttempted = true
            if validated {
                loginRequest.login(username: username)
            }
        }) {
            Text("Login")
                .foregroundColor(.blue)
                .font(.headline)
        }
    }
    
    var continueButton: some View {
        return NavigationLink(destination: FilmListView(), label: {
            Text("Continue")
                .foregroundColor(.blue)
                .font(.headline)
        })
    }
}

struct TextBoxView: View {
    @Binding var username: String
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .accentColor(.red)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.001, saturation: 0.204, brightness: 0.903)/*@END_MENU_TOKEN@*/)
            .cornerRadius(30.0)
            .disableAutocorrection(true)
            .autocapitalization((.none))
    }
}

