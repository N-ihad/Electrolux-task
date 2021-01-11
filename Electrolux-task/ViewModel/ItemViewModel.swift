//
//  ItemViewModel.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

class ItemViewModel {
    
    var photoURL: URL?
    var photoTitle: String
    
    init(photoURL: String, photoTitle: String) {
        self.photoURL = URL(string: photoURL) ?? nil
        self.photoTitle = photoTitle
    }
}
