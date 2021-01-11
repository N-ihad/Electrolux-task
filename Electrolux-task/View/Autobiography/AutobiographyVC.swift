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

        navigationItem.title = "Autobiography"
    }

}
