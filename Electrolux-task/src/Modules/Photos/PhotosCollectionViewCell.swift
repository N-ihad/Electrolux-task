//
//  ItemCell.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit
import Kingfisher

final class PhotosCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCell"
    private let photoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func layout() {
        contentView.addSubview(photoImageView)
        photoImageView.autoPinEdgesToSuperviewEdges()
    }
    
    func set(with photoViewModel: PhotoViewModel) {
        photoImageView.kf.setImage(
            with: photoViewModel.URL0,
            placeholder: nil,
            options: [
                .processor(DownsamplingImageProcessor(size: CGSize(width: 40, height: 40))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ])
    }
}
