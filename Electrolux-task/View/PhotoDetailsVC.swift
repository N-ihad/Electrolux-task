//
//  DetailVC.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation

import UIKit

class PhotoDetailsVC: UIViewController {
    
    // MARK: - Properties
    
    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.autoSetDimensions(to: CGSize(width: 300, height: 300))
        photoImageView.dropShadow()
        
        return photoImageView
    }()
    
    private let photoTitleLabel: UILabel = {
        let photoTitleLabel = UILabel()
        photoTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        photoTitleLabel.textAlignment = .center
        photoTitleLabel.autoSetDimension(.width, toSize: UIScreen.main.bounds.width-50)
        
        return photoTitleLabel
    }()
    
    // MARK: - Lifecycle
    
    init(photo: Photo) {
        super.init(nibName: nil, bundle: nil)
        
        photoImageView.kf.setImage(with: URL(string: photo.urlO!))
        photoTitleLabel.text = photo.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavBar()
        configureSubviews()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureNavBar() {
        navigationItem.title = "Details"
    }
    
    func configureSubviews() {
        view.addSubview(photoImageView)
        photoImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        photoImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 200)
        
        view.addSubview(photoTitleLabel)
        photoTitleLabel.autoPinEdge(.top, to: .bottom, of: photoImageView, withOffset: 15)
        photoTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }

}
