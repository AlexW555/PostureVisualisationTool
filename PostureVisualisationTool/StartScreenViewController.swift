//
//  StartScreenViewController.swift
//  CameraTest
//
//  Created by Josh on 09/01/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit

class StartScreenViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    @IBAction func start(_ sender: Any) {
        navigateToMainInterface()
    }
    
    private func navigateToMainInterface() {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
   
        guard let mainNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController") as?
            MainNavigationController else {
            return
        }
        present(mainNavigationVC, animated: true, completion: nil)
    }
}
