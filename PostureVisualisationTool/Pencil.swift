//
//  Pencil.swift
//  DrawingPad
//
//  Created by Josh on 15/03/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit

enum Pencil {
    case black
    case red
    case darkBlue
    case lightBlue
    case eraser

    init?(tag: Int) {
        switch tag {
        case 0:
            self = .black
        case 1:
            self = .red
        case 2:
            self = .darkBlue
        case 3:
            self = .lightBlue
        case 4:
            self = .eraser
        default:
            return nil
        }
    }
    
    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .red:
            return UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        case .darkBlue:
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1.0)
        case .lightBlue:
            return UIColor(red: 51/255.0, green: 204/255.0, blue: 1, alpha: 1.0)
        case .eraser:
            return .white
        }
    }
    
}
