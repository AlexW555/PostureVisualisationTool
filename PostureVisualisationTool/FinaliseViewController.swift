//
//  FinaliseViewController.swift
//  DrawingPad
//
//  Created by Josh on 04/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class FinaliseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var typeOfView: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    let views = ["Front View", "Side View", "Coronal"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return views[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return views.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ClosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


