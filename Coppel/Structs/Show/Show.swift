//
//  Show.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import Foundation

struct Show: Codable {
    let backdrop_path: String?
    let first_air_date: String
    let id: Int32
    let name: String
    let original_language: String
    let original_name: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let vote_average: Double
    let vote_count: Int32
    
    init() {
        backdrop_path = ""
        first_air_date = ""
        id = 0
        name = ""
        original_language = ""
        original_name = ""
        overview = ""
        popularity = 0.0
        poster_path = ""
        vote_average = 0.0
        vote_count = 0
    }
    
}
