//
//  PhotoViewController.swift
//  CameraTest
//
//  Created by Josh on 29/12/2018.
//  Copyright © 2018 Alex. All rights reserved.
//
import Foundation
import UIKit

class PhotoViewController: UIViewController {

    var takenPhoto:UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
        
    }
    
      
    @IBAction func goBack(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //    if segue.identifier == "toPhotoEditor" {
     //      let dvc = segue.destination as! PhotoEditorNavigationController
       //     dvc.imageView = imageView;
        //}
    //}


    @IBAction func openEditor(_ sender: Any) {
        performSegue(withIdentifier: "PhotoEditor", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : DrawController = segue.destination as! DrawController
        destVC.newimage = takenPhoto
    }
}
