//
//  Helper.swift
//  Electrolux-task
//
//  Created by Nihad on 11/8/21.
//

import Foundation
import UIKit

struct Helper {
    static func makeNavigationController(image: UIImage?,
                                         rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.barTintColor = .white
        return navigationController
    }
}
