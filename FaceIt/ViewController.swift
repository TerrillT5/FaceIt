//
//  ViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/11/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // video ended with 48.35 left 
    @IBOutlet weak var faceView: FaceView! {
        didSet {
           
            let handler = #selector(FaceView.changeScale(byReactingTo:)) // 2. handler sends the message
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)// 3. message to the face
            faceView.addGestureRecognizer(pinchRecognizer) // 1. faceView recognizes pinches
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo:))) // sets tapRecognizer to itself
            tapRecognizer.numberOfTapsRequired = 1 // amount of taps required for view to change
            faceView.addGestureRecognizer(tapRecognizer) // makes the faceView eyes open when tapped
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness)) // cause happiness to increase
            swipeUpRecognizer.direction = .up// swiping up on view makes expression happier
            faceView.addGestureRecognizer(swipeUpRecognizer) // initiates the swipe up
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness)) // cause happiness to decrease
            swipeDownRecognizer.direction = .down // swiping down on view makes expression less happy 
            faceView.addGestureRecognizer(swipeDownRecognizer) // initiates the swipe down 
            updateUI()
            
        }
    }
    
    func increaseHappiness() {

        expression = expression.happier // makes the expression more happy. This is in the facialExpression file first
    }
    
    func decreaseHappiness() {
        
        expression = expression.sadder // makes the expression less happy. This is in the facialExpression file first
    }
    
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer) {
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .closed) ? .open : .closed // if current view eyes are closed otherwise, I'd have them closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth) // new facialExpression set
        }
    }
   
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        
        didSet { // anytime something changes, this will redraw it
            updateUI() // UI is updated
        }
    }
    
    private func updateUI()
    {
        switch expression.eyes {
            // optional chaining used so error doesn't occur if "faceView" is called before expression
        case .open:
            faceView?.eyesOpen = true
        case .closed:
            faceView?.eyesOpen = false
        case .squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0 // "??" means defaulting
        
    }
   
    private let mouthCurvatures = [FacialExpression.Mouth.grin: 0.5, .frown: -1.0,.smile:1.0, .neutral: 0.0, .smirk: -0.5 ]
    
}

