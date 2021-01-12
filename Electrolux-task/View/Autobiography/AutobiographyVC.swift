//
//  AutobiographyVC.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit

class AutobiographyVC: UIViewController {
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let scrollViewContentView: UIView = {
        let scrollViewContentView = UIView()
        
        return scrollViewContentView
    }()
    
    private let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.autoSetDimensions(to: CGSize(width: 144, height: 195))
        profileImageView.backgroundColor = .imagePlaceholderColor
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.dropShadow()
        
        return profileImageView
    }()
    
    private let firstNameLabel: UILabel = {
        let firstNameLabel = UILabel()
        firstNameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        firstNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        return firstNameLabel
    }()
    
    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        lastNameLabel.font = UIFont.boldSystemFont(ofSize: 18)

        return lastNameLabel
    }()
    
    private let biographyTitleLabel: UILabel = {
        let biographyTitleLabel = UILabel()
        biographyTitleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        biographyTitleLabel.text = "BIO"
        
        return biographyTitleLabel
    }()
    
    private let biographyLabel: UILabel = {
        let biographyLabel = UILabel()
        biographyLabel.numberOfLines = 0
        biographyLabel.lineBreakMode = .byWordWrapping
        
        
        return biographyLabel
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        let profileViewModel = ProfileVM(photoURL: Profile.testProfile.avatarURL,
                                                firstName: Profile.testProfile.firstName,
                                                lastName: Profile.testProfile.lastName,
                                                biography: Profile.testProfile.biography)
        
        setUpBiography(with: profileViewModel)
        configureNavBar()
        configureSubviews()
    }
    
    func setUpBiography(with viewModel: ProfileVM) {
        profileImageView.kf.setImage(with: viewModel.avatarURL)
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        biographyLabel.text = viewModel.biography
    }
    
    func configureNavBar() {
        navigationItem.title = "Autobiography"
    }
    
    func configureSubviews() {
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewSafeArea()
        
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.autoPinEdgesToSuperviewEdges()
        scrollViewContentView.autoMatch(.width, to: .width, of: scrollView)
        
        scrollViewContentView.addSubview(profileImageView)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        profileImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)

        let hStack = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        hStack.alignment = .leading
        hStack.axis = .horizontal
        hStack.distribution = .fill
        hStack.spacing = 3

        scrollViewContentView.addSubview(hStack)
        hStack.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        hStack.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 16)
        hStack.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -16)
        
        scrollViewContentView.addSubview(biographyTitleLabel)
        biographyTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        biographyTitleLabel.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 22)
        
        scrollViewContentView.addSubview(biographyLabel)
        biographyLabel.autoPinEdge(.top, to: .bottom, of: biographyTitleLabel, withOffset: 20)
        biographyLabel.autoPinEdge(.left, to: .left, of: scrollViewContentView, withOffset: 24)
        biographyLabel.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -24)
        biographyLabel.autoPinEdge(.bottom, to: .bottom, of: scrollViewContentView)
    }

}
