//
//  ProfileViewModel.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

final class ProfileViewModel {
    
    var arrFavorites: Observable<[Show]> = Observable([])
    var user: Observable<String> = Observable(nil)
    func getUser() {
        self.user.value = UserDefaults.standard.string(forKey: Constant.userNameKey)
    }
    
    func fetchFavorites() {
        arrFavorites.value? = FavoriteManager.shared.arrFavorites
    }
    
    func getFavorite(at index: Int) -> Show {
        arrFavorites.value?[index] ?? Show()
    }
    
    func removeFavorite(by id: Int32) {
        FavoriteManager.shared.removeFavorite(id: id)
    }
    
}
