//
//  PostFilm.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/16/22.
//

import Foundation

class APIService: ObservableObject {
    @Published var returnedFilmTitle: String?
    @Published var errorThrown: Bool = false
    @Published var errorStatusCode: Int?
    @Published var errorString: String?
    @Published var postSuccessful: Bool = false
    
    func postFilm(film: String, rating: Int, jwtToken: String?) {
        request(film: film, rating: rating, method: "POST", id: "", jwtToken: jwtToken)
    }
    
    func updateRating(film: String, rating: Int, id: String, jwtToken: String?) {
        request(film: film, rating: rating, method: "PUT", id: id, jwtToken: jwtToken)
    }
    
    func request(film: String, rating: Int, method: String, id: String?, jwtToken: String?) {
        let url = URL(string: "http://192.168.0.128:8080/api/v1/films")
        var request = URLRequest(url: url!)
        
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(jwtToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let newFilm = FilmModel(_id: id ?? "", name: film, rating: rating)
        let encoded = try! JSONEncoder().encode(newFilm)
        request.httpBody = encoded
        let task = URLSession.shared.dataTask(with: request) { (data, res, err)  in
            if let err = err {
                print("error: \(err)")
            }
            let res = res as? HTTPURLResponse
            if res?.statusCode != 200 {
                DispatchQueue.main.async{
                    self.errorThrown = true
                    self.errorStatusCode = res?.statusCode
                    self.errorString = HTTPURLResponse.localizedString(forStatusCode: res!.statusCode)
                }
            } else if let data = data {
                do {
                    let savedFilm = try JSONDecoder().decode(FilmModel.self, from: data)
                    print("Film Added: \(savedFilm.name)")
                    print("Rating Added: \(savedFilm.rating)")
                    DispatchQueue.main.async{
                        self.returnedFilmTitle = savedFilm.name
                        self.postSuccessful = true
                    }
                } catch {
                    print("error: \(error)")
                }
            }
        }
        task.resume()
    }
}
