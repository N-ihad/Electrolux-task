//
//  ItemViewModel.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

struct PhotoVM {
    
    var URL0: URL?
    var title: String
    
    init(url: String, title: String) {
        self.URL0 = URL(string: url) ?? nil
        self.title = title
    }
    
    static func initArray(with photos: [Photo]) -> [PhotoVM] {
        var photosViewModel = [PhotoVM]()
        
        for photo in photos {
            if let url = photo.urlO {
                photosViewModel.append(PhotoVM(url: url, title: photo.title))
            }
        }
        
        return photosViewModel
    }
}
