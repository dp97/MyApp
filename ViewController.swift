//
//  ViewController.swift
//  D06
//
//  Created by Petrov Dumitru on 4/28/17.
//  Copyright © 2017 Dumitru PETROV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties.
    var forms = [CreateForms]()
    var gravity: UIGravityBehavior!
    var animator: UIDynamicAnimator!
    var collision: UICollisionBehavior!
    var elasticity: UIDynamicItemBehavior!
    var dragTheForm: UIPanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pan gesture
        dragTheForm = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        
        // Initialize the Animator
        animator = UIDynamicAnimator(referenceView: self.view)
        
        // Add Gravity
        gravity = UIGravityBehavior(items: forms)
        let direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        
        // Add Collision
        collision = UICollisionBehavior(items: forms)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        // Add Ellasticity
        elasticity = UIDynamicItemBehavior(items: forms)
        elasticity.elasticity = 0.6
        
        animator.addBehavior(elasticity)
        animator.addBehavior(collision)
        animator.addBehavior(gravity)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        
        for form in forms {
            if form.frame.contains(touchPoint) {
                print("Upss..")
                return
            }
        }
        let drawing = CreateForms(coordinates: touchPoint)
        self.view.addSubview(drawing)
        forms.append(drawing)
        print("Tapped: \(touchPoint)")
        
        //GRAVITY
        gravity.addItem(drawing)
        elasticity.addItem(drawing)
        collision.addItem(drawing)
        drawing.isUserInteractionEnabled = true
        drawing.addGestureRecognizer(dragTheForm)
    }
    
    // Move the Form on Screen
    func panGesture(gesture: UIPanGestureRecognizer) {
        self.view.bringSubview(toFront: forms[1])
        let translation = gesture.translation(in: self.view)
        forms[1].center = CGPoint(x: forms[1].center.x + translation.x, y: forms[1].center.y + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)
    }

}

