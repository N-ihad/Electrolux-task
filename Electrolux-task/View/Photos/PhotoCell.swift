//
//  ItemCell.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
//        photoImageView.contentMode = .scaleAspectFit
        
        return photoImageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        configureSubviews()
    }
    
    func configureSubviews() {
        contentView.addSubview(photoImageView)
        photoImageView.autoPinEdgesToSuperviewEdges()
    }
    
    func set(with photoViewModel: PhotoVM) {
        self.photoImageView.kf.setImage(with: photoViewModel.URL0)
    }
    
}
