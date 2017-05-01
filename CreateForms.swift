//
//  CreateForms.swift
//  D06
//
//  Created by Petrov Dumitru on 4/28/17.
//  Copyright © 2017 Dumitru PETROV. All rights reserved.
//

import UIKit

class CreateForms: UIView {
    
    //MARK: Properties.
    let formColor: [UIColor] = [.black,
                                .blue,
                                .brown,
                                .cyan,
                                .darkGray,
                                .gray,
                                .green,
                                .lightGray,
                                .magenta,
                                .orange,
                                .purple,
                                .red,
                                .yellow]
    let formShape: [String] = ["round", "square"]
    let height = 100
    let width = 100
    let coordinates: CGPoint
    let shape: String!

    init(coordinates: CGPoint) {
        shape = formShape[Int(arc4random_uniform(UInt32(formShape.count)))]
        let color = formColor[Int(arc4random_uniform(UInt32(formColor.count)))]
        self.coordinates = coordinates
        
        super.init(frame: CGRect(x: coordinates.x - 50, y: coordinates.y - 50, width: 100, height: 100))
        if (shape == "round") {
            self.layer.cornerRadius = self.frame.width / 2.0
            self.clipsToBounds = true
            self.layer.masksToBounds = true
        }
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return shape == "round" ? .ellipse : .rectangle
    }
}
