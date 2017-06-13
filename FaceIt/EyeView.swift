//
//  EyeView.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/30/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class EyeView: UIView {

    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    var color: UIColor = .blue { didSet { setNeedsDisplay() } }

    var _eyesOpen: Bool = true { didSet { setNeedsDisplay() } } // this is the private eyes open
    
    //  eyes open does the animation
    var eyesOpen: Bool {
        
        get {
            return _eyesOpen
        }
        set {
            if newValue != _eyesOpen  {
                UIView.transition(with: self, duration: 0.5, options: [ .transitionFlipFromTop], animations: { // makes eyes blink smoother by animating the motion of the eyes
                    
                    self._eyesOpen = newValue
                })
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        var path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
            
        } else {
            
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
    }

        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke() 
        
}

}
