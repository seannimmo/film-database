//
//  LoginRequest.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/12/22.
//

import Foundation

struct LoginModel: Codable {
    var username: String
}

struct tokenModel: Codable {
    var token: String
}

class LoginRequest: ObservableObject{
    @Published var jwtToken: String?
    @Published var isLoggedIn = false
    
    func login(username: String){
        let url = URL(string: "http://192.168.0.128:8080/api/v1/login")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newLogin = LoginModel(username: username)
        let encoded = try! JSONEncoder().encode(newLogin)
        request.httpBody = encoded
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err)  in
            guard let data = data else {return}
            
            do {
                let loginToken = try JSONDecoder().decode(tokenModel.self, from: data)
                DispatchQueue.main.async{
                    self.jwtToken = loginToken.token
                    self.isLoggedIn = true
                }
            } catch {
                print("error: \(error)")
            }
        }
        task.resume()
    }
}

