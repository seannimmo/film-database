//
//  FilmList.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/11/22.
//

import SwiftUI

struct FilmListView: View {
    @StateObject var getFilms = GetFilms()
    @State private var inEditView: Bool = false
    @State private var isSheetShowing = false
    
    var body: some View {
        VStack {
            
            List {
                ForEach(getFilms.list, id: \._id) {film in
                    FilmItemView(name: film.name, rating: film.rating, id: film._id ?? "none")
                }
            }
            Spacer()
            Button(action: {
                getFilms.request()
            }) {
                Text("Refresh")
                    .padding()
            }
        }
        //.onAppear(perform: {getFilms.request()})
        .navigationTitle("Films")
        .navigationBarItems(trailing: HStack{
            NavigationLink(destination: EditView(inEditView: $inEditView, filmsList: getFilms.list), label: { Text("Edit")})
            Button(action: {isSheetShowing.toggle()}) {
                Text("Add")
            }
            .sheet(isPresented: $isSheetShowing) {
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {isSheetShowing.toggle()}) {
                            Text("Done")
                        }
                        .padding()
                    }
                    AddFilmView()
                }
                Spacer()
                
            }
        })
        
    }
    
}

struct FilmListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListView()
    }
}
