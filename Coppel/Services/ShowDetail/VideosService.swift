//
//  VideosService.swift
//  Coppel
//
//  Created by Yair Israel Saucedo Herrera on 09/02/23.
//

import Foundation

final class VideosService {
    
    // MARK: - Paths
    private let getVideos: String = Constant.apiURL + "/tv/"
    
    func getVideos(id: Int32, completion: @escaping RequestCompletion<ResultVideos>) {
        
        guard let url = URL(string: "\(getVideos)\(id)/videos?api_key=\(Constant.api_key)&language=\(Constant.language)") else { return }
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {

                guard let json = data else { return }
                
                let responseString = NSString(data: json, encoding: String.Encoding.utf8.rawValue)
                print("****** response data = \(responseString!)")

                let decoder = JSONDecoder()
                let result:ResultVideos = try decoder.decode(ResultVideos.self, from: json)
                
                completion(.success(response: result))
                
                
            } catch let error {
                completion(.failure(error: error as NSError))
            }
        }
        task.resume()
        
    }
    
}
