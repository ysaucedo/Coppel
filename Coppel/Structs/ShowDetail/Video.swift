//
//  Video.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

struct Video: Codable {
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int32
    var type: String
    var official: Bool
    var published_at: String
    var id: String
    
    init() {
        iso_639_1 = ""
        iso_3166_1 = ""
        name = ""
        key = ""
        site = ""
        size = 0
        type = ""
        official = false
        published_at = ""
        id = ""
    }
    
}
