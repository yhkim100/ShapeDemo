//
//  ShapeView.swift
//  ShapesDemo
//
//  Created by Kim, Young-hoon on 11/30/18.
//  Copyright © 2018 Garmin International. All rights reserved.
//

import Foundation
import UIKit

class ShapeView: UIView {
    
    let size: CGFloat = 150.0
    let lineWidth: CGFloat = 3
    var fillColor: UIColor!
    var path: UIBezierPath!
    
    init(origin: CGPoint) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        self.center = origin;
        self.backgroundColor = UIColor.clear
        self.fillColor = randomColor()
        self.path = randomPath()
        initGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.fillColor.setFill()
        self.path.fill()
        
        //randomly assign hatching
        switch arc4random() % 3 {
        case 0:
            let color = UIColor(patternImage: UIImage(named: "hatch_1")!)
            color.setFill()
            path.fill()
        case 1:
            let color = UIColor(patternImage: UIImage(named: "hatch_2")!)
            color.setFill()
            path.fill()
        default:
            //Leave out texture
            break
        }
        
        path.lineWidth = lineWidth
        UIColor.black.setStroke()
        path.stroke()
    }
    
    func initGestureRecognizers() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        addGestureRecognizer(panGR)
        
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        addGestureRecognizer(pinchGR)
        
        let rotateionGR = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
        addGestureRecognizer(rotateionGR)
    }
    
    @objc func didPan(_ panGR: UIPanGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        var translation = panGR.translation(in: self)
        translation = __CGPointApplyAffineTransform(translation, self.transform)
        
        self.center.x += translation.x
        self.center.y += translation.y
        
        panGR.setTranslation(CGPoint.zero, in: self)
    }
    
    @objc func didPinch(_ pinchGR: UIPinchGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        let scale = pinchGR.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        
        pinchGR.scale = 1.0
    }
    
    @objc func didRotate(_ rotationGR: UIRotationGestureRecognizer) {
        self.superview!.bringSubview(toFront: self)
        let rotation = rotationGR.rotation
        self.transform = self.transform.rotated(by: rotation)
        
        rotationGR.rotation = 0.0
    }
    
    //Generate and return a random color
    func randomColor() -> UIColor {
        let hue:CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(hue: hue, saturation: 0.8, brightness: 1.0, alpha: 0.8)
    }
    
    //Generate and return a random shape
    func randomPath() -> UIBezierPath {
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
        
        let shapeType = arc4random() % 3
        switch shapeType {
        case 0:
            return UIBezierPath(roundedRect: insetRect, cornerRadius: 10.0)
        case 1:
            return UIBezierPath(ovalIn: insetRect)
        default:
            return trianglePathInRect(rect: insetRect)
        }
    }
    
    func trianglePathInRect(rect:CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.move(to: CGPoint.init(x:rect.width / 2.0, y: rect.origin.y))
        path.addLine(to: CGPoint.init(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint.init(x: rect.origin.x, y: rect.height))
        path.close()

        return path
    }
}
