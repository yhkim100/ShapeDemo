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
    
    init(origin: CGPoint) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: size, height: size))
        self.center = origin;
        self.backgroundColor = UIColor.clear
        self.fillColor = randomColor()
        initGestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
        let path = UIBezierPath(roundedRect: insetRect, cornerRadius: 10)
        
        self.fillColor.setFill()
        path.fill()
        
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
    
    func randomColor() -> UIColor {
        let hue:CGFloat = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        return UIColor(hue: hue, saturation: 0.8, brightness: 1.0, alpha: 0.8)
    }
    
}
