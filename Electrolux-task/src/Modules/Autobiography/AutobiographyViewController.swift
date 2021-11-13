//
//  AutobiographyVC.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit

final class AutobiographyViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let scrollViewContentView = UIView()
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
        firstNameLabel.font = .boldSystemFont(ofSize: 18)
        return firstNameLabel
    }()

    private let lastNameLabel: UILabel = {
        let lastNameLabel = UILabel()
        lastNameLabel.setContentHuggingPriority(.required, for: .horizontal)
        lastNameLabel.font = .boldSystemFont(ofSize: 18)
        return lastNameLabel
    }()
    
    private let biographyTitleLabel: UILabel = {
        let biographyTitleLabel = UILabel()
        biographyTitleLabel.font = .boldSystemFont(ofSize: 28)
        biographyTitleLabel.text = "BIO"
        return biographyTitleLabel
    }()

    private let biographyLabel: UILabel = {
        let biographyLabel = UILabel()
        biographyLabel.numberOfLines = 0
        biographyLabel.lineBreakMode = .byWordWrapping
        return biographyLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        style()
    }

    private func setup() {
        navigationItem.title = "Autobiography"
        let profileViewModel = AutobiographyViewModel(
            photoURL: Profile.testProfile.avatarURL,
            firstName: Profile.testProfile.firstName,
            lastName: Profile.testProfile.lastName,
            biography: Profile.testProfile.biography
        )
        setupBiography(with: profileViewModel)
    }

    private func layout() {
        view.addSubview(scrollView)
        scrollView.autoPinEdgesToSuperviewSafeArea()

        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.autoPinEdgesToSuperviewEdges()
        scrollViewContentView.autoMatch(.width, to: .width, of: scrollView)

        scrollViewContentView.addSubview(profileImageView)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        profileImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)

        let horizontalStackView = UIStackView(arrangedSubviews: [firstNameLabel, lastNameLabel])
        horizontalStackView.alignment = .leading
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 3

        scrollViewContentView.addSubview(horizontalStackView)
        horizontalStackView.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        horizontalStackView.autoPinEdge(.left, to: .right, of: profileImageView, withOffset: 16)
        horizontalStackView.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -16)

        scrollViewContentView.addSubview(biographyTitleLabel)
        biographyTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        biographyTitleLabel.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 22)

        scrollViewContentView.addSubview(biographyLabel)
        biographyLabel.autoPinEdge(.top, to: .bottom, of: biographyTitleLabel, withOffset: 20)
        biographyLabel.autoPinEdge(.left, to: .left, of: scrollViewContentView, withOffset: 24)
        biographyLabel.autoPinEdge(.right, to: .right, of: scrollViewContentView, withOffset: -24)
        biographyLabel.autoPinEdge(.bottom, to: .bottom, of: scrollViewContentView)
    }

    private func style() {
        view.backgroundColor = .white
    }

    private func setupBiography(with viewModel: AutobiographyViewModel) {
        profileImageView.kf.setImage(with: viewModel.avatarURL)
        firstNameLabel.text = viewModel.firstName
        lastNameLabel.text = viewModel.lastName
        biographyLabel.text = viewModel.biography
    }
}
