//
//  Photo.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

struct PhotoResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}

struct Photo: Codable {

    let title: String
    let urlO: String?
    let heightO, widthO: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case urlO = "url_o"
        case heightO = "height_o"
        case widthO = "width_o"
    }
}
