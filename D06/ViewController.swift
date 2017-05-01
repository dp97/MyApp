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
        
        // Pan gesture.
        dragTheForm = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture))
        
        // Initialize the Animator.
        animator = UIDynamicAnimator(referenceView: self.view)
        
        // Add Gravity.
        gravity = UIGravityBehavior(items: forms)
        let direction = CGVector(dx: 0.0, dy: 1.0)
        gravity.gravityDirection = direction
        
        // Add Collision.
        collision = UICollisionBehavior(items: forms)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        // Add Ellasticity.
        elasticity = UIDynamicItemBehavior(items: forms)
        elasticity.elasticity = 0.6
        
        // Add them to Animator.
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
        print("Tapped: \(touchPoint)")
        
        //GRAVITY
        gravity.addItem(drawing)
        elasticity.addItem(drawing)
        collision.addItem(drawing)
        
        // Adding the Pan Gesture Recognizer
        drawing.isUserInteractionEnabled = true
        drawing.addGestureRecognizer(dragTheForm)
        
        form = drawing
        forms.append(drawing)
    }
    
    var form: CreateForms!
    
    // Move the Form on Screen
    func panGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
//            // Disable Gravity.
//            print("Began.")
//            for i in 0..<forms.count {
//                if forms[i].frame.contains(gesture.location(in: view)) {
//                    gravity.removeItem(forms[i])
//                    self.form = forms[i]
//                }
//            }
            gravity.removeItem(form)
            collision.removeItem(form)
            elasticity.removeItem(form)
        case .changed:
            // Move the Form.
//            self.view.bringSubview(toFront: form)
//            let translation = gesture.translation(in: self.view)
//            form.center = CGPoint(x: form.center.x + translation.x, y: form.center.y + translation.y)
//            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            let translation = gesture.translation(in: form)
            
            form.center = CGPoint(x: form.center.x + translation.x, y: form.center.y + translation.y)
            
            gesture.setTranslation(CGPoint.zero, in: self.view)
            
            print("\(form.center.x)=\(form.center.y)")
            print("t: \(translation)")
        case .ended:
            // Enable gravity.
            gravity.addItem(form)
            elasticity.addItem(form)
            collision.addItem(form)
            print("Ended.")
        case .cancelled:
            print("Cancelled")
        default:
            print("Default")
        }
    }

}

