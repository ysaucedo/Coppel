//
//  MoviesViewModel.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import UIKit

public enum TypeShow {
    case popular
    case topRated
    case onTV
    case airingToday
}

protocol LoaderProtocol: AnyObject {
    func startLoading()
    func finishLoading()
}

final class MoviesViewModel {
    
    var arrShows: Observable<[Show]> = Observable([])
    var scrollActivate:Bool = false
    let service = ShowsService()
    weak var loaderProtocol: LoaderProtocol?

    var typeShow: TypeShow? {
        didSet {
            arrShows.value = []
            service.currentPage = 1
            service.lastPage = nil
            fetchShows()
        }
    }
    
    func fetchShows() {
        
        if service.isLastPage() { return }
        guard let typeShow = typeShow else { return }
        loaderProtocol?.startLoading()
        service.getShows(typeShow: typeShow) { [weak self] result in
            guard let self = self else { return }
            defer { self.loaderProtocol?.finishLoading() }
            switch result {
            case .success(response: let result):
                self.scrollActivate = false
                self.arrShows.value?.append(contentsOf: result.results)
            case .failure(error: _):
                if self.service.isFirstPage() {
                    self.arrShows.value = []
                }
            }
        }
        
    }
    
    func getShow(at index: Int) -> Show {
        arrShows.value?[index] ?? Show()
    }
    
    func addFavorite(show: Show) {
        FavoriteManager.shared.addFavorite(show: show)
    }
    
    func instanciateProfile() -> UIViewController {
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .pageSheet
        return vc
    }

    func instanciateDetail() -> UIViewController {
        let vc = MovieDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        return vc
    }
    
    func instanciateLoader() -> UIViewController {
        let vc = LoaderViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
}
