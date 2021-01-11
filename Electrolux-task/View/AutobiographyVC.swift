//
//  AutobiographyVC.swift
//  Electrolux-task
//
//  Created by Nihad on 1/11/21.
//

import UIKit

class AutobiographyVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavBar()
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureNavBar() {
//        let button = UIButton()
//        button.setImageWithSize(size: 20, systemImgName: "arrow.triangle.2.circlepath")
//        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
//        let barButton = UIBarButtonItem(customView: button)
//        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Autobiography"
    }

}
