//
//  ShowsService.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 08/02/23.
//

import Foundation

final class ShowsService {
    
    // MARK: - Paths
    private let getPopular: String = Constant.apiURL + "/tv/popular?"
    private let getTopRated: String = Constant.apiURL + "/tv/top_rated?"
    private let getOnTV: String = Constant.apiURL + "/tv/on_the_air?"
    private let getAiringToday: String = Constant.apiURL + "/tv/airing_today?"
    
    //MARK: - PAGINATION
    var currentPage: Int = 1
    var lastPage: Int?
    
    func getShows(typeShow: TypeShow, completion: @escaping RequestCompletion<ResultShow>) {
        
        guard let url = URL(string: "\(getCategory(typeShow: typeShow))api_key=\(Constant.api_key)&language=\(Constant.language)&page=\(currentPage)") else { return }
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            do {

                guard let json = data else { return }
                
                let responseString = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")

                let decoder = JSONDecoder()
                let result:ResultShow = try decoder.decode(ResultShow.self, from: json)
                self?.lastPage = result.total_pages
                
                completion(.success(response: result))
                
                
            } catch let error {
                completion(.failure(error: error as NSError))
            }
        }
        task.resume()
        
    }
    
    func nextPage() {
        currentPage += 1
        if isLastPage() {
            guard let lastPage = lastPage else { return }
            currentPage = lastPage
        }
    }
    
    func isFirstPage() -> Bool {
        currentPage == 1
    }
    
    func isLastPage() -> Bool {
        guard let lastPage = lastPage else { return false }
        return currentPage >= lastPage
    }
    
    private func getCategory(typeShow: TypeShow) -> String {
        switch typeShow {
        case .popular:
            return getPopular
        case .topRated:
            return getTopRated
        case .onTV:
            return getOnTV
        case .airingToday:
            return getAiringToday
        }
    }
    
    
}
