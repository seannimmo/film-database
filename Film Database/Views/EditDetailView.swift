//
//  EditDetailView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/18/22.
//

import SwiftUI

struct EditDetailView: View {
    @StateObject private var service = APIService()
    @State private var isValidInput = false
    @State private var invalidMessage = ""
    @EnvironmentObject var loginRequest: LoginRequest
    
    var name: String
    var rating: Int
    @State var newRating: String = ""
    var id: String
    
    var body: some View {
        VStack{
            Text(name)
            TextField("\(rating)", text: $newRating)
                .keyboardType(.decimalPad)
                .padding()
                .accentColor(.red)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.246, brightness: 0.868)/*@END_MENU_TOKEN@*/)
                .cornerRadius(30.0)
            
            Button(action: {
                (isValidInput, invalidMessage) = validateFilm(film: name, rating: newRating)
                if(isValidInput){
                    service.updateRating(film: name, rating: Int(newRating)!, id: id, jwtToken: loginRequest.jwtToken)
                }
            }) {
                Text("Update Rating")
            }
            
            if(!isValidInput){
                Text(invalidMessage)
            } else if service.errorThrown {
                Text("Error: \(service.errorStatusCode ?? 200). \(service.errorString ?? "")")
            } else if (service.postSuccessful) {
                Text("Rating Updated Successfully!")
            }
        }
    }
}
