//
//  ItemViewModel.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

struct PhotoViewModel {
    
    var URL0: URL?
    var title: String
    
    init(url: String, title: String) {
        self.URL0 = URL(string: url)
        self.title = title
    }
    
    static func initArray(with photos: [Photo]) -> [PhotoViewModel] {
        var photosViewModel = [PhotoViewModel]()

        for photo in photos where photo.urlO != nil {
            photosViewModel.append(PhotoViewModel(url: photo.urlO!, title: photo.title))
        }

        return photosViewModel
    }
}
