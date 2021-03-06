//
//  TabBarController.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureNavBar()
        configureTabBar()
    }

    // MARK: - Helpers
    
    func configureTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
    }
    
    func configureNavBar() {
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().tintColor = .black
    }
    
    func configureViewControllers() {
        let photosVC  = PhotosVC()
        let photosNav = templateNavigationController(image: UIImage(systemName: "photo.on.rectangle"), rootViewController: photosVC)
        
        let autobiographyVC = AutobiographyVC()
        let autobiographyNav = templateNavigationController(image: UIImage(systemName: "doc.richtext"), rootViewController: autobiographyVC)
        
        viewControllers = [photosNav, autobiographyNav]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navCtrl = UINavigationController(rootViewController: rootViewController)
        navCtrl.tabBarItem.image = image
        navCtrl.navigationBar.barTintColor = .white
        
        return navCtrl
    }
    
}

