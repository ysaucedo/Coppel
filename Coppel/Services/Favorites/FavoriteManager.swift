//
//  FavoriteManager.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

class FavoriteManager {
    
    static let shared = FavoriteManager()

    var arrFavorites = [Show]() {
        didSet {
            saveFavorites()
        }
    }
    
    private let defaults = UserDefaults.standard

    init() { arrFavorites = getFavorites() }
    
    func addFavorite(show: Show) {
        if !arrFavorites.contains(where: { $0.id == show.id} ) {
            arrFavorites.append(show)
        }
    }
    
    func removeFavorite(id: Int32) {
        arrFavorites.removeAll(where: { $0.id == id } )
    }
    
    private func getFavorites() -> [Show] {
        if let objects = UserDefaults.standard.value(forKey: Constant.favoriteNameKey) as? Data {
           let decoder = JSONDecoder()
           if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Show] {
              return objectsDecoded
           } else {
              return [Show]()
           }
        } else {
           return [Show]()
        }
    }

    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrFavorites){
            UserDefaults.standard.set(encoded, forKey: Constant.favoriteNameKey)
        }
    }
    
}
