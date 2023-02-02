//
//  AddFilmView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/15/22.
//

import SwiftUI

struct AddFilmView: View {
    @State var filmTitle = ""
    @State var filmRating = ""
    @State private var isValidInput = false
    @State private var invalidMessage = ""
    @StateObject private var postFilm = APIService()
    @EnvironmentObject var loginRequest: LoginRequest
    
    
    var body: some View {
        VStack{
            Text("Add Film")
                .font(.title)
            inputTextField(nameOfField: "Title", bindingOfField: $filmTitle)
            
            inputTextField(nameOfField: "Rating", bindingOfField: $filmRating)
                .keyboardType(.decimalPad)
            
            Button(action: {
                (isValidInput, invalidMessage) = validateFilm(film: filmTitle, rating: filmRating)
                if(isValidInput){
                    postFilm.postFilm(film: filmTitle, rating: Int(filmRating)!, jwtToken: loginRequest.jwtToken)
                }
                
            }) {
                Text("Add Film")
            }
            
            if(!isValidInput){
                Text(invalidMessage)
            } else if postFilm.errorThrown {
                Text("Error: \(postFilm.errorStatusCode ?? 200). \(postFilm.errorString ?? "")")
            } else if (postFilm.postSuccessful) {
                Text("Film Added Successfully!")
                    .onAppear {
                        self.filmTitle = ""
                        self.filmRating = ""
                    }
            }
        }
        .padding()
    }
}

struct AddFilmView_Previews: PreviewProvider {
    static var previews: some View {
        AddFilmView()
    }
}

struct inputTextField: View {
    var nameOfField: String
    var bindingOfField: Binding<String>
    
    var body: some View {
        TextField(nameOfField, text: bindingOfField)
            .padding()
            .accentColor(.red)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.246, brightness: 0.868)/*@END_MENU_TOKEN@*/)
            .cornerRadius(30.0)
    }
}

