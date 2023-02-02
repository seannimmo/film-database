//
//  FilmView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/11/22.
//

import SwiftUI

struct FilmItemView: View {
    var name: String
    var rating: Int
    var id: String
    
    var fillColor: Color {
        if(rating >= 7) {
            return .green
        } else if rating >= 4 {
            return .yellow
        }
        return .red
    }
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(fillColor)
                    .frame(width: 60, height: 60)
                Text("\(rating)")
                    .bold()
                    .font(.system(size: 30))
            }
            Text(name)
        }
    }
}

struct FilmView_Previews: PreviewProvider {
    static var previews: some View {
        FilmItemView(name: "Everything Everywhere All At Once", rating: 9, id: "1")
    }
}
