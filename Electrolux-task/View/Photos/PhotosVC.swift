//
//  ViewController.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit
import PureLayout
import Kingfisher

private let reuseIdentifier = "cell"

class PhotosVC: UIViewController {
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var photosViewModel = [PhotoVM]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.removeLoadingView()
            }
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
        let spinnerIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
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
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureCollectionView()
        configureSearchBar()
        fetchElectroluxItems()
    }
    
    // MARK: - API
    
    func fetchElectroluxItems() {
        
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            NetworkService.shared.getElectroluxItems { [weak self] response in
                guard let res = response.value else {
                    print("Couldn't fetch Electrolux items")
                    return
                }
                
                self?.photosViewModel = PhotoVM.initArray(with: res.photos.photo)
            }
        }
    }
    
    func fetchItems(with name: String) {
        
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            NetworkService.shared.getItems(with: name) { [weak self] response in
                guard let res = response.value else {
                    print("Couldn't fetch items with hashtag \(name)")
                    return
                }
                
                self?.photosViewModel = PhotoVM.initArray(with: res.photos.photo)
            }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureNavBar()
        configureSubviews()
    }
    
    func configureCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureSubviews() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0))
    }
    
    func configureNavBar() {
        navigationItem.title = "Photos"
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e. g. Electrolux"
    }
    
    func showLoadingView() {
        view.addSubview(loadingView)
        loadingView.autoCenterInSuperview()

        loadingView.addSubview(spinnerIndicatorView)
        spinnerIndicatorView.autoCenterInSuperview()
        
        spinnerIndicatorView.startAnimating()
    }

    func removeLoadingView() {
        DispatchQueue.main.async {
            self.spinnerIndicatorView.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

}

extension PhotosVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        cell.contentView.backgroundColor = .imagePlaceholderColor
        
        guard photosViewModel[indexPath.row].URL0 != nil else { return cell }

        cell.set(with: photosViewModel[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailsVC = PhotoDetailsVC(photoViewModel: photosViewModel[indexPath.row])
        navigationController?.pushViewController(photoDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 40, height: collectionView.frame.width/2 - 40)
    }
}

extension PhotosVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        fetchItems(with: searchText)
    }
}
