//
//  NetworkService.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    // MARK: - GET
    
    func getElectroluxItems(completion: @escaping ((DataResponse<PhotoResponse, AFError>) -> Void)) {
        AF.request(API_URLs.getElectroluxItems).responseDecodable(of: PhotoResponse.self, completionHandler: completion)
    }
    
    func getItems(with name: String, completion: @escaping ((DataResponse<PhotoResponse, AFError>) -> Void)) {
        AF.request("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1dbf35f0c471e2a9e8a2acd90a5b38eb&tags=\(name)&format=json&nojsoncallback=1&extras=url_o&per_page=21&page=1").responseDecodable(of: PhotoResponse.self, completionHandler: completion)
    }
}


extension NetworkService {
    
    private struct API_URLs {
        static let getElectroluxItems = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1dbf35f0c471e2a9e8a2acd90a5b38eb&tags=Electrolux&format=json&nojsoncallback=1&extras=url_o&per_page=21&page=1"
        
        private init() { }
    }
    
}
