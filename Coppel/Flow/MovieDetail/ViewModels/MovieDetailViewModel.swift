//
//  MovieDetailViewModel.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

final class MovieDetailViewModel {
    
    var arrCompanies: Observable<[Company]> = Observable([])
    var arrVideos: Observable<[Video]> = Observable([])
    let service = ShowDetailService()
    let videoService = VideosService()
    
    func fetchShow(id: Int32) {
        
        service.getShow(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(response: let result):
                self.arrCompanies.value?.append(contentsOf: result.production_companies)
            case .failure(error: _):
                self.arrCompanies.value = []
            }
        }
        
    }
    
    func fetchVideos(id: Int32) {
        
        videoService.getVideos(id: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(response: let result):
                self.arrVideos.value?.append(contentsOf: result.results)
            case .failure(error: _):
                self.arrVideos.value = []
            }
        }
        
    }
        
    func getCompany(at index: Int) -> Company {
        arrCompanies.value?[index] ?? Company()
    }
    
    func getVideo(at index: Int) -> Video {
        arrVideos.value?[index] ?? Video()
    }
    
    func addFavorite(show: Show) {
        FavoriteManager.shared.addFavorite(show: show)
    }
    
}
