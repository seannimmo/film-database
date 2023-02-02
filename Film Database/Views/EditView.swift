//
//  EditView.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/18/22.
//

import SwiftUI

struct EditView: View {
    @Binding var inEditView: Bool
    var filmsList: [FilmModel]
    
    var body: some View {
        VStack {
//            HStack {
//                Spacer()
//                Button(action: {inEditView.toggle()}) {
//                    Text("Done")
//                        .padding()
//                }}
            List {
                ForEach(filmsList, id: \._id) {film in
                    NavigationLink(destination: EditDetailView(name: film.name, rating: film.rating, id: film._id ?? "none"), label: {
                        FilmItemView(name: film.name, rating: film.rating, id: film._id ?? "none")
                    })
                }
                
            }
            .navigationTitle("Edit")
        }
    }
}
