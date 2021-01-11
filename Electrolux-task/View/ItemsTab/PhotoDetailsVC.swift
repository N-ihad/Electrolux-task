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
    
    private lazy var saveImageButton: UIButton = {
        let saveImageButton = UIButton(type: .system)
        saveImageButton.setTitle("Save Image", for: .normal)
        saveImageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        saveImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        saveImageButton.layer.cornerRadius = 4
        saveImageButton.setTitleColor(.white, for: .normal)
        saveImageButton.backgroundColor = .systemBlue
        saveImageButton.addTarget(self, action: #selector(saveImageToUserPhotoLibrary), for: .touchUpInside)
        
        return saveImageButton
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
        
        print("Tapped on the First Tab full-screen image")
        configureUI()
        configureNavBar()
        configureSubviews()
    }
    
    // MARK: - Selectors
    
    @objc func saveImageToUserPhotoLibrary() {
        guard let inputImage = photoImageView.image else { print("Image not found!"); return }
        UIImageWriteToSavedPhotosAlbum(inputImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
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
        photoImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 170)
        
        view.addSubview(photoTitleLabel)
        photoTitleLabel.autoPinEdge(.top, to: .bottom, of: photoImageView, withOffset: 15)
        photoTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        view.addSubview(saveImageButton)
        saveImageButton.autoPinEdge(.top, to: .bottom, of: photoTitleLabel, withOffset: 15)
        saveImageButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}
