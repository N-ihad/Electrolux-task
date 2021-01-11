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

class ItemsVC: UIViewController {
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.hideActivityIndicator()
            }
        }
    }
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var loadingView: UIView = UIView()
    
    let loadingIndicatorView: UIActivityIndicatorView = {
        let loadingIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        
        return loadingIndicatorView
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 32)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavBar()
        configureCollectionView()
        configureSearchBar()
        fetchElectroluxItems()
    }
    
    // MARK: - API
    
    func fetchElectroluxItems() {
        showActivityIndicator()
        NetworkService.shared.getElectroluxItems { [weak self] response in
            guard let res = response.value else { print("Couldn't fetch Electrolux items"); return }
            self?.photos = res.photos.photo.filter { photo in return photo.urlO != nil }
        }
    }
    
    func fetchItems(with name: String) {
        showActivityIndicator()
        NetworkService.shared.getItems(with: name) { [weak self] response in
            guard let res = response.value else { print("Couldn't fetch items with hashtag \(name)"); return }
            self?.photos = res.photos.photo.filter { photo in return photo.urlO != nil }
        }
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        configureSubviews()
    }
    
    func configureCollectionView() {
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureSubviews() {
        view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0))
        
        collectionView.addSubview(loadingIndicatorView)
        loadingIndicatorView.autoPinEdge(.top, to: .bottom, of: collectionView, withOffset: 150)
        loadingIndicatorView.autoAlignAxis(toSuperviewAxis: .vertical)
        loadingIndicatorView.autoCenterInSuperviewMargins()
    }
    
    func configureNavBar() {
        navigationItem.title = "Items"
    }
    
    func configureSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "e. g. Electrolux"
    }
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor(named: "#444444")
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10

            self.spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }

}

extension ItemsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ItemCell
        cell.contentView.backgroundColor = .imagePlaceholderColor
        
        guard let url = photos[indexPath.row].urlO else { return cell }
        
        let itemViewModel = ItemViewModel(photoURL: url, photoTitle: photos[indexPath.row].title)
        cell.set(with: itemViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailsVC = PhotoDetailsVC(photo: photos[indexPath.row])
        navigationController?.pushViewController(photoDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 40, height: collectionView.frame.width/2 - 40)
    }
}

extension ItemsVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        fetchItems(with: searchText)
    }
}
