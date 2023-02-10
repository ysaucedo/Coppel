//
//  ResultShow.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import Foundation

struct ResultShow: Codable {
    let page: Int
    let results: [Show]
    let total_pages: Int
    let total_results: Int
}
