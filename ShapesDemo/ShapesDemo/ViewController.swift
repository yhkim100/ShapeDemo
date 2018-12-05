//
//  ViewController.swift
//  ShapesDemo
//
//  Created by Kim, Young-hoon on 11/30/18.
//  Copyright © 2018 Garmin International. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        self.view.addGestureRecognizer(tapGR)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func didTap(_ tapGR: UITapGestureRecognizer) {
        let tapPoint = tapGR.location(in: self.view)
        
        let shapeView = ShapeView(origin: tapPoint)
        
        self.view.addSubview(shapeView)
    }

}

