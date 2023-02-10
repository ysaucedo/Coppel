//
//  ResultShowDetail.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

struct ResultShowDetail: Codable {
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
    let production_companies: [Company]
}
