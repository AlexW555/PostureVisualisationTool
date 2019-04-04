//
//  PhotoEditorNavigationController.swift
//  CameraTest
//
//  Created by Josh on 09/01/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit



class PhotoEditorNavigationController: UIViewController {
    //@IBOutlet weak var browsingView: UIImageView!
    var newImage: UIImage!

    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImage.image = newImage
    }
        
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
