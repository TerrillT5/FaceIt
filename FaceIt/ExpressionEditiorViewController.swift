//
//  ExpressionEditiorViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 6/7/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit


// 16th vid speaks on pausing game scenes, notifications
// "Documents directory" - store permanent data created by the user
// "Caches directory"  - stores temporary files thats not backed up by itunes 


class ExpressionEditiorViewController: UITableViewController, UITextFieldDelegate {

var name: String {
    return nameTextField.text ?? "" // if no name then returns an empty textfield
    
}
    
private let eyeChoices = [FacialExpression.Eyes.open, .closed, .squinting] // 3 choices in segmented control for eyes

private let mouthChoices = [FacialExpression.Mouth.frown, .smirk,  .neutral, .grin, .smile] // 5 choices in the segmented control for the mouth

var expression: FacialExpression {
    
    return FacialExpression(
        eyes: eyeChoices[eyeControl?.selectedSegmentIndex ?? 0], // selectedSegmentIndex is for picking things in a segment control. Eyes may not be set so we return a 0
        mouth: mouthChoices[mouthControl?.selectedSegmentIndex ?? 0]
    )
}

@IBAction func cancel(_ sender: UIBarButtonItem) {
    presentingViewController?.dismiss(animated: true)
}

@IBOutlet weak var nameTextField: UITextField!
@IBOutlet weak var eyeControl: UISegmentedControl!
@IBOutlet weak var mouthControl: UISegmentedControl!

@IBAction func updateFace() {
    
//        print("\(name) = \(expression)") // prints all the expressions when tapped
    faceViewController?.expression = expression // sets the expression of the FacialExpression
}

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder() // makes return key close the keyboard
   
    return true
}

private var faceViewController: BlinkingFaceViewController?

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "Embed Face" {
    faceViewController = segue.destination as? BlinkingFaceViewController // grabs the view controller of the face view
    faceViewController?.expression  = expression    // updates face view expression right away

    }
}

override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if identifier == "Add Emotion", name.isEmpty {
        
        return false
        
    } else {
        
        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender) // gives super class a chance to return something
    }
}

override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 1 {
        handleUnnamedFace()
        return tableView.bounds.size.width // makes table a square so image can stretch
        
    } else {
      
        return super.tableView(tableView, heightForRowAt: indexPath)
        
    }
}

private func handleUnnamedFace() {
    
    let alert = UIAlertController(title: "Invalid Face", message: "Name required for face", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
    self.nameTextField?.text = alert.textFields?.first?.text // saves the name that the user has entered 
    self.performSegue(withIdentifier: "Add Emotion", sender: nil) // adds name to the emotion segue
    }))
    alert.addTextField(configurationHandler: nil)
    present(alert, animated: true)

}

override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
   
    if let popoverPresentationController = navigationController?.popoverPresentationController {
    if popoverPresentationController.arrowDirection != .unknown {
            
    navigationItem.leftBarButtonItem = nil // removes the cancel button from the pop over presemtation on ipad
        
        }
    }
    
    var size = tableView.minimumSize(forSection: 0)
    size.height -= tableView.heightForRow(at: IndexPath(row: 1, section: 0)) // keeps the size consistently a square when shrunked
    size.height += size.width  // square in the new smaller size
    preferredContentSize = size // tells the system how big the mvc should be
  }
}

extension UITableView {
    
func minimumSize(forSection section: Int) -> CGSize {
    
// this forces a cell to be created for every row in that section
// this is only usuable for small tables
    var width: CGFloat = 0
    var height: CGFloat = 0
    for row in 0..<numberOfRows(inSection: section) {
        
        let indexPath = IndexPath(row: row, section: section)
        
        if let cell = cellForRow(at: indexPath) ?? dataSource?.tableView(self, cellForRowAt: indexPath) {
        
        let cellSize = cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        width = max(width, cellSize.width)
        height += heightForRow(at: indexPath)
    
        }
        
        }
    
    return CGSize(width: width, height: height)

    }
    
    func heightForRow(at indexPath: IndexPath? = nil) -> CGFloat {
    
    
    if indexPath != nil, let height = delegate?.tableView?(self, heightForRowAt: indexPath!) {
        return height
        
    } else {
        
        return rowHeight
    }
    
}

 }

