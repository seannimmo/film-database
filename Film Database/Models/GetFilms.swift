//
//  GetFilmsRequest.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/15/22.
//

import Foundation

class GetFilms: ObservableObject {
    @Published var list: [FilmModel] = []
    
    func request(){
        let url = URL(string: "http://192.168.0.128:8080/api/v1/films")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                DispatchQueue.main.async {
                    do{
                        self.list = try JSONDecoder().decode([FilmModel].self, from: data)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
        task.resume()
        
    }
}
