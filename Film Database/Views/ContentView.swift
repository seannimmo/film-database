//
//  ContentView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginRequest = LoginRequest()
    
    
    var body: some View {
        LoginView(loginRequest: loginRequest)
            .environmentObject(loginRequest)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
