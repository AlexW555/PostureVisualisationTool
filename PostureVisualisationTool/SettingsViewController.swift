//
//  SettingsViewController.swift
//  DrawingPad
//
//  Created by Josh on 02/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//
 import UIKit

protocol SettingsViewControllerDelegate: class {
    func SettingsViewControllerFinished(_ SettingsViewController: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var Brush_Label: UILabel!
    @IBOutlet weak var Opacity_Label: UILabel!
    @IBOutlet weak var Brush_Slider: UISlider!
    @IBOutlet weak var Opacity_Slider: UISlider!
    
    
    @IBOutlet weak var Red_Slider: UISlider!
    @IBOutlet weak var Green_Slider: UISlider!
    @IBOutlet weak var Blue_Slider: UISlider!
    
    @IBOutlet weak var Red_Label: UILabel!
    @IBOutlet weak var Green_Label: UILabel!
    @IBOutlet weak var Blue_Label: UILabel!
    
    @IBOutlet weak var Size_Label: UILabel!
    @IBOutlet weak var Size_Slider: UISlider!
    
    @IBOutlet weak var Colour_Preview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Brush_Label.text = String(format: "%.1f", brush)
        Opacity_Label.text = String(format: "%.1f", opacity)
        Red_Label.text = String(Red_Slider.value).description
        Green_Label.text = String(Green_Slider.value).description
        Blue_Label.text = String(Blue_Slider.value).description
        Size_Label.text = String(Size_Slider.value).description
        
        Brush_Slider.value = Float(brush)
        Opacity_Slider.value = Float(opacity)
        Red_Slider.value = Float(red * 255.0)
        Green_Slider.value = Float(green * 255.0)
        Blue_Slider.value = Float(blue * 255.0)
        Size_Slider.value = Float(size)
        
        drawPreview()

        // Do any additional setup after loading the view.
    }
   
    var brush: CGFloat = 1.0
    var opacity: CGFloat = 1.0
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var size: CGFloat = 10.0
    
    weak var delegate: SettingsViewControllerDelegate?
    
    @IBAction func close(_ sender: Any) {
        delegate?.SettingsViewControllerFinished(self)
    }
    
    @IBAction func Brush_Changed(_ sender: UISlider) {
        brush = CGFloat(sender.value)
        Brush_Label.text = String(format: "%.1f", brush)
        drawPreview()
    }
    @IBAction func Opacity_Changed(_ sender: UISlider) {
        opacity = CGFloat(sender.value)
        Opacity_Label.text = String(format: "%.1f", opacity)
        drawPreview()
    }
    
    @IBAction func Size_Changed(_ sender: Any) {
        size = CGFloat(Size_Slider.value)
        Size_Label.text = String(format: "%.1f", size)
        drawPreview()
    }
    @IBAction func Colour_Changed(_ sender: UISlider) {
        red = CGFloat(Red_Slider.value / 255.0)
        Red_Label.text = Int(Red_Slider.value).description
        green = CGFloat(Green_Slider.value / 255.0)
        Green_Label.text = Int(Green_Slider.value).description
        blue = CGFloat(Blue_Slider.value / 255.0)
        Blue_Label.text = Int(Blue_Slider.value).description
        drawPreview()
    }
    func drawPreview(){
       UIGraphicsBeginImageContext(Colour_Preview.frame.size)
        guard let context = UIGraphicsGetCurrentContext()
            else{
                return
        }
        context.setLineCap(.round)
        context.setLineWidth(brush)
        context.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: opacity).cgColor)
        context.move(to: CGPoint(x: 45, y: 45))
        context.addLine(to: CGPoint(x: 45, y: 45))
        context.strokePath()
        context.addArc(center: CGPoint(x: 175, y: 45), radius: size, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        context.strokePath()
        
        Colour_Preview.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
    
    

