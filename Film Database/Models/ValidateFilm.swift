//
//  ValidateFilm.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/15/22.
//

import Foundation

func validateFilm(film: String, rating: String) -> (Bool, String){
    var isValidInput = true
    var inputMessage = ""
    
    if film.isEmpty {
        isValidInput = false
        inputMessage = "Enter a film \n"
    }
    if rating.isEmpty {
        isValidInput = false
        inputMessage = inputMessage + "Enter a rating"
    } else if ratingIsNotNumberBetweenOneAndTen(rating: rating) {
        isValidInput = false
        inputMessage = inputMessage + "Rating must be number from 1 to 10"
    }
    
    return (isValidInput, inputMessage)
}

func ratingIsNotNumberBetweenOneAndTen(rating: String) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: "^[0-9]+$")
        let numMatches = regex.numberOfMatches(in: rating, range: NSRange(location: 0, length: rating.utf16.count))
        if numMatches == 1 {
            if Int(rating)! > 0 && Int(rating)! <= 10 {
                return false
            }
        }
    } catch {
        print("Invalid Regex")
    }
    return true
}
