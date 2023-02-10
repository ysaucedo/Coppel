//
//  Companies.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

struct Company: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
    
    init() {
        id = 0
        logo_path = ""
        name = ""
        origin_country = ""
    }
}
