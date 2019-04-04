//
//  RoundButton.swift
//  DrawingPad
//
//  Created by Josh on 02/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColour: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColour.cgColor
        }
    }
}
