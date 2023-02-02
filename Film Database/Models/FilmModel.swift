//
//  FilmModel.swift
//  Film Database
//
//  Created by Sean Nimmo on 8/15/22.
//

import Foundation

struct FilmModel: Codable {
    let _id: String?
    let name: String
    let rating: Int
}
