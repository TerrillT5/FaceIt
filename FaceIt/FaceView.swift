//
//  FaceView.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/11/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class FaceView: UIView {

    var scale: CGFloat = 0.9
    
    var eyesOpen: Bool = true // makes the eyes circular also
    
    var mouthCurvature: Double = 1.0 // 1.0 is full smile & -1.0 is full frown
    
    private var skullRadius: CGFloat {
        return min(bounds.size.width,bounds.size.height) / 2 * scale // sets the height & width of the skull
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY) // sets skullCenter to be middle of screen
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        
        // use a func to keep the center of eye in one place
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = skullRadius / Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset // place the eyes in a certain coordinate within the skull
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset // sets the eyes in the middle of the skull
            return eyeCenter // returns center of the eye
            
            }
        let eyeRadius = skullRadius / Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        
        let path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true ) // makes the eyes circular
            
        } else {
        path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = 5.0 // size of the inner eye(pupil)
        return path
        
    }
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false) // makes the skull circular
        path.lineWidth = 5.0 // how wide the skull will be
        return path
        
    }

    private func pathForMouth() -> UIBezierPath {
        
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffSet = skullRadius / Ratios.skullRadiusToMouthOffSet
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffSet,
            width: mouthWidth,
            height: mouthHeight
        )
            let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
            let path = UIBezierPath(rect: mouthRect)
        
            return path
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.blue.set() // sets the stroke color
        pathForSkull().stroke() // creates the head
        pathForEye(.left).stroke() // creates left eye
        pathForEye(.right).stroke() // creates right eye
        pathForMouth().stroke()
        pathForMouth().stroke()
    }
    
    private struct Ratios {
        // "static let" is how to make constants
        static let skullRadiusToEyeOffset: CGFloat = 3 // how close the eyes are to each other
        static let skullRadiusToEyeRadius: CGFloat = 10 // how far the eyes are to the skull
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffSet: CGFloat = 3
        
        
        
    }

}
