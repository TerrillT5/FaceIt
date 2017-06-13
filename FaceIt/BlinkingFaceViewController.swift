//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/30/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    var blinking = false {
        didSet {
             blinkIfNeeded()
        }
    }
   
    override func updateUI() {
        super.updateUI()
        blinking = expression.eyes == .squinting // if image is squinting then it will be blinking
        
    }
    
    private var canBlink = false
    private var inABlink = false
    
    private struct BlinkRate {
       
        static let closedDuration: TimeInterval = 0.5 // how long the eyes will be closed
        static let openDuration: TimeInterval = 2.5 // how long the eyes will be open
        
    }
    
    private func blinkIfNeeded() {
        if blinking && canBlink && inABlink {
            
            faceView.eyesOpen = false
            inABlink = true
            Timer.scheduledTimer(withTimeInterval: BlinkRate.closedDuration, repeats: false)  { [weak self] timer in
            self?.faceView.eyesOpen = true // open the eyes back up
                
            Timer.scheduledTimer(withTimeInterval: BlinkRate.openDuration, repeats: false)  { [weak self] timer in
            self?.inABlink = false
            self?.blinkIfNeeded()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        canBlink = true
        blinkIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
        
    }
}
