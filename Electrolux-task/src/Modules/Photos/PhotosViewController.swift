//
//  ViewController.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit
import PureLayout
import Kingfisher

final class PhotosViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil)
    private var photosViewModel = [PhotoViewModel]() {
        didSet {
            collectionView.reloadData()
            stopLoading()
        }
    }
    
    private let loadingView: UIView = {
        let loadingView = UIView()
        loadingView.autoSetDimensions(to: CGSize(width: 80, height: 60))
        loadingView.backgroundColor = .black
        loadingView.alpha = 0.7
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()

    private let spinnerIndicatorView: UIActivityIndicatorView = {
        let spinnerIndicatorView = UIActivityIndicatorView(style: .medium)
        spinnerIndicatorView.color = .white
        return spinnerIndicatorView
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 32)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        style()
        fetchElectroluxPhotos()
    }

    private func fetchElectroluxPhotos() {
        startLoading()
        NetworkService.shared.fetchElectroluxPhotos { [weak self] response in

            guard let value = response.value else {
                print("Couldn't fetch Electrolux items")
                return
            }

            self?.photosViewModel = PhotoViewModel.initArray(with: value.photos.photo)
        }
    }

    private func fetchPhotos(withTitle title: String) {
        startLoading()
        NetworkService.shared.fetchPhotos(withTitle: title) { [weak self] response in

            guard let value = response.value else {
                print("Couldn't fetch items with hashtag \(title)")
                return
            }
            self?.photosViewModel = PhotoViewModel.initArray(with: value.photos.photo)
        }
    }

    private func setup() {
        navigationItem.title = "Photos"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self

        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e.g. Electrolux"
    }

    private func layout() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0))
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func startLoading() {
        view.addSubview(loadingView)
        loadingView.autoCenterInSuperview()

        loadingView.addSubview(spinnerIndicatorView)
        spinnerIndicatorView.autoCenterInSuperview()
        spinnerIndicatorView.startAnimating()
    }

    private func stopLoading() {
        spinnerIndicatorView.stopAnimating()
        loadingView.removeFromSuperview()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.contentView.backgroundColor = .imagePlaceholderColor

        guard photosViewModel[indexPath.row].URL0 != nil else {
            return cell
        }

        cell.set(with: photosViewModel[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhotoViewController = SelectedPhotoViewController(photoViewModel: photosViewModel[indexPath.row])
        navigationController?.pushViewController(selectedPhotoViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 40, height: collectionView.frame.width / 2 - 40)
    }
}

// MARK: - UISearchBarDelegate
extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        fetchPhotos(withTitle: text)
    }
}
