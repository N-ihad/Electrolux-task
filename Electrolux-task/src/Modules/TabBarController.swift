//
//  TabBarController.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        style()
    }

    private func setup() {
        let photosNavigationController = Helper.makeNavigationController(
            image: .photosTabBarIcon,
            rootViewController: PhotosViewController()
        )

        let autobiographyNavigationController = Helper.makeNavigationController(
            image: .autobiographyTabBarIcon,
            rootViewController: AutobiographyViewController()
        )

        viewControllers = [photosNavigationController, autobiographyNavigationController]
    }

    private func style() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black

        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = .black
    }
}
