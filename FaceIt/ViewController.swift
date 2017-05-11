//
//  ViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/11/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        
        didSet {
            updateUI()
        }
    }
   
    var expression = FacialExpression(eyes: .closed, mouth: .frown) {
        
        didSet { // anytime something changes,
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

