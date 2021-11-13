//
//  NetworkService.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation
import Alamofire

struct NetworkService {

    static let shared = NetworkService()

    private init() { }

    func fetchElectroluxPhotos(completion: @escaping ((DataResponse<PhotoResponse, AFError>) -> Void)) {
        AF.request(Endpoint.electroluxPhotos)
            .responseDecodable(of: PhotoResponse.self, completionHandler: completion)
    }

    func fetchPhotos(withTitle title: String, completion: @escaping ((DataResponse<PhotoResponse, AFError>) -> Void)) {
        let params = ["tags": title]
        AF.request(Endpoint.photosWithHashtag, parameters: params)
            .responseDecodable(of: PhotoResponse.self, completionHandler: completion)
    }
}

// MARK: - Flickr images endpoints
extension NetworkService {
    private enum Endpoint {
        static let electroluxPhotos = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1dbf35f0c471e2a9e8a2acd90a5b38eb&tags=Electrolux&format=json&nojsoncallback=1&extras=url_o&per_page=21&page=1"
        static let photosWithHashtag = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1dbf35f0c471e2a9e8a2acd90a5b38eb&format=json&nojsoncallback=1&extras=url_o&per_page=21&page=1"
    }
}
