//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/15/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        
        
        if let faceViewController = destinationViewController as? FaceViewController,
             let identifier = segue.identifier,
             let expression = emotionalFaces[identifier] {
                faceViewController.expression = expression
             faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle // sets the title on the expression view
          }
        }
    
    private let emotionalFaces: Dictionary<String, FacialExpression> = [
    
        "sad": FacialExpression(eyes: .closed, mouth: .frown),
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "worried": FacialExpression(eyes: .open, mouth: .smirk)
    ]
 }
