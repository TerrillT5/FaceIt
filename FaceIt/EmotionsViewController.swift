//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/15/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    private var emotionalFaces: [(name: String , expression: FacialExpression)] = [
        ("Sad", FacialExpression(eyes: .closed, mouth: .frown)),
        ("Happy", FacialExpression(eyes: .open, mouth: .smile)),
        ("Worried", FacialExpression(eyes: .open, mouth: .smirk))
    ]

        
    @IBAction func addEmotionalFace(from segue: UIStoryboardSegue) {
        
        if let editor = segue.source as? ExpressionEditiorViewController {
            
            emotionalFaces.append((editor.name, editor.expression)) // appends to the emotional faces 
            tableView.reloadData() // updates the tableview after the expression
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotionalFaces.count
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Emotion Cell", for: indexPath)
        cell.textLabel?.text = emotionalFaces[indexPath.row].name
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
        destinationViewController = navigationController.visibleViewController ?? destinationViewController
       
        }
        
        if let faceViewController = destinationViewController as? FaceViewController,
        let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell) {
        faceViewController.expression = emotionalFaces[indexPath.row].expression // gets the expression of the emotion
        faceViewController.navigationItem.title = emotionalFaces[indexPath.row].name // sets the title on the expression view
          
        } else if destinationViewController is ExpressionEditiorViewController { // expressionsController will show
            
        if let popoverPresentationController = segue.destination.popoverPresentationController {
        popoverPresentationController.delegate = self
                
            }
        }
        
        }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle { // this asks the presentation if it wants to control the adapting behavior
        
        if traitCollection.verticalSizeClass == .compact { // if the iPhone is in portrait mode
            
            return .none
            
        } else if traitCollection.horizontalSizeClass == .compact { // if the iPhone is in landscape mode

        return .overFullScreen
    }
    
    return .none // means on a iphone 6+ or ipad
 }

}
