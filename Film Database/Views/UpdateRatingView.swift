//
//  UpdateRatingView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/17/22.
//

import SwiftUI

struct UpdateRatingView: View {
    var name: String
    var id: String
    @State var rating: String
    
    var body: some View {
        Text(name)
        TextField("\(rating)", text: $rating)
            .padding()
            .accentColor(.red)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.246, brightness: 0.868)/*@END_MENU_TOKEN@*/)
            .cornerRadius(30.0)
            .padding()
        
        Button(action: {print("update button clicked")}) {
            Text("Update Rating")
        }
    }
}

struct UpdateRatingView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRatingView(name: "Hi", id: "djkj", rating: "9")
    }
}
