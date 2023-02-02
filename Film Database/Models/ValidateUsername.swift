//
//  AuthenticateUsername.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/12/22.
//

import Foundation

func validateUsername(username: String) -> (Bool, String) {
    var loginIsValid = false
    var loginMessage = ""
    
    if username == "" {
        loginMessage = "You must provide a username"
    } else if hasSpecialChars(username: username) {
        loginMessage = "Only alphanumericals are allowed"
    } else {
        loginIsValid = true
        loginMessage = "Username valid"
    }
    
    return (loginIsValid, loginMessage)
}

func hasSpecialChars(username: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: "^[A-Za-z0-9]+$")
        let numMatches = regex.numberOfMatches(in: username, range: NSRange(location: 0, length: username.utf16.count))
        if numMatches == 1 {
            return false
        }
    } catch {
        print("Invalid Regex")
    }
    
    return true
}
