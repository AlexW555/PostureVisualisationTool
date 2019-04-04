///
//  DrawController.swift
//  DrawingPad Draw Controller
//
//  This project is the work of Alexander Wing 871807
//
//
//
//
//  Created by Alex on 15/03/2019.
//  Copyright © 2019 Alex. All rights reserved.
//
//Framework used for drawing functionality
import UIKit


class DrawController: UIViewController {
    
    //Initialising Variables
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var mode = 0
    var size: CGFloat = 10.0
    
    
    // 0 = Lines
    // 1 = Circles
    
    var newimage: UIImage!
    
    
    @IBOutlet weak var basePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basePhoto.image = newimage
        }
        
    
    
    //initalising the two layered image views
    @IBOutlet weak var tempDrawImage: UIImageView!
    @IBOutlet weak var mainImage: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
            let settingsController = navController.topViewController as? SettingsViewController else {
                return
        }
        settingsController.delegate = self
        settingsController.brush = brushWidth
        settingsController.opacity = opacity
        settingsController.size = size
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        settingsController.red = red
        settingsController.green = green
        settingsController.blue = blue
    }
    
    @IBAction func CirclePressed(_ sender: Any) {
        mode = 1
    }
    @IBAction func pencilPressed(_ sender: Any) {
        mode = 0
        guard let pencil = Pencil(tag: (sender as AnyObject).tag) else {
            return
        }
        color = pencil.color
        if pencil == .eraser {
            opacity = 1.0
        }
    }
    @IBAction func savePressed(_ sender: Any) {
        
        UIImageWriteToSavedPhotosAlbum(mainImage.image!, nil, nil, nil)
        
        //let activity = UIActivityViewController(activityItems: [mainImage.image!], applicationActivities: [])
        // present(activity, animated: true)
    }
    @IBAction func reset(_ sender: Any) {
        mainImage.image = nil
    }
    @IBAction func settings(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //free draw
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    
    func drawCircle(from fromPoint: CGPoint, to toPoint:CGPoint){
        // get the graphics context
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext()
            else{
                return
        }
        
        tempDrawImage.image?.draw(in: view.bounds)
        
        //Set the circle outline width
        context.setLineWidth(5.0)
        
        //Set the circle outline colour
        UIColor.red.set()
        
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        
        //Create a circle
        context.addArc(center: lastPoint, radius: size, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        
        context.strokePath()
        
        tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempDrawImage.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        //1
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext()
            else {
                return
        }
        tempDrawImage.image?.draw(in: view.bounds)
        //2
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        //3
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        //4
        context.strokePath()
        
        //5
        tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        tempDrawImage.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first
            else {
                return
        }
        
        //6
        swiped = true
        let currentPoint = touch.location(in: view)
        
        if mode == 0 {
            drawLine(from: lastPoint, to: currentPoint)
        }
        else{
            drawCircle(from: lastPoint, to: currentPoint)
        }
        lastPoint = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if mode == 0 {
            if !swiped {
                //draws a single point
                drawLine(from: lastPoint, to: lastPoint)
            }
            
            // Merge tempImageView into mainImageView
            UIGraphicsBeginImageContext(mainImage.frame.size)
            mainImage.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
            tempDrawImage?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
            mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            tempDrawImage.image = nil
        }
        else{
            drawCircle(from: lastPoint, to: lastPoint)
        }
    }
}

extension DrawController: SettingsViewControllerDelegate {
    func SettingsViewControllerFinished(_ SettingsViewController: SettingsViewController) {
        brushWidth = SettingsViewController.brush
        opacity = SettingsViewController.opacity
        size = SettingsViewController.size
        color = UIColor(red: SettingsViewController.red, green: SettingsViewController.green, blue: SettingsViewController.blue, alpha: opacity)
        dismiss(animated: true)
    }
}

