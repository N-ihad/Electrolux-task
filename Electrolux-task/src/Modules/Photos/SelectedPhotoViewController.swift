//
//  SelectedPhotoViewController.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import Foundation
import UIKit

final class SelectedPhotoViewController: UIViewController {

    private let photoImageView: UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.autoSetDimensions(to: CGSize(width: 300, height: 300))
        photoImageView.backgroundColor = .imagePlaceholderColor
        photoImageView.dropShadow()
        return photoImageView
    }()

    private let photoTitleLabel: UILabel = {
        let photoTitleLabel = UILabel()
        photoTitleLabel.font = .boldSystemFont(ofSize: 18)
        photoTitleLabel.textAlignment = .center
        photoTitleLabel.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 50)
        return photoTitleLabel
    }()

    private lazy var saveImageButton: UIButton = {
        let saveImageButton = UIButton(type: .system)
        saveImageButton.setTitle("Save Image", for: .normal)
        saveImageButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        saveImageButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        saveImageButton.layer.cornerRadius = 4
        saveImageButton.setTitleColor(.white, for: .normal)
        saveImageButton.backgroundColor = .systemBlue
        saveImageButton.addTarget(self, action: #selector(onSaveImage), for: .touchUpInside)
        return saveImageButton
    }()

    init(photoViewModel: PhotoViewModel) {
        super.init(nibName: nil, bundle: nil)
        photoImageView.kf.setImage(with: photoViewModel.URL0)
        photoTitleLabel.text = photoViewModel.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }

    private func setup() {
        navigationItem.title = "Details"
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func layout() {
        view.addSubview(photoImageView)
        photoImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        photoImageView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 12)
        
        view.addSubview(photoTitleLabel)
        photoTitleLabel.autoPinEdge(.top, to: .bottom, of: photoImageView, withOffset: 15)
        photoTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        view.addSubview(saveImageButton)
        saveImageButton.autoPinEdge(.top, to: .bottom, of: photoTitleLabel, withOffset: 15)
        saveImageButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    @objc private func onSaveImage() {
        guard let image = photoImageView.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage,
                             didFinishSavingWithError error: Error?,
                             contextInfo: UnsafeRawPointer) {
        if let error = error {
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }

    private func showAlertWith(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
