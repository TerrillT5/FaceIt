//
//  VCLoggingViewController.swift
//  FaceIt
//
//  Created by Terrill Thorne on 5/30/17.
//  Copyright © 2017 Terrill Thorne. All rights reserved.
//

import UIKit

// this class logs the view controllers life cycle method
class VCLoggingViewController: UIViewController {

    private struct LogGlobals {
        var prefix = ""
        var instanceCounts = [String: Int]()
        var lastLogTime = Date()
        var indenetationInterval: TimeInterval = 1
        var indentationString = "__"
    }
    
    private static var logGlobals = LogGlobals()
    
    private static func logPrefix(for className: String) -> String {
        
        if logGlobals.lastLogTime.timeIntervalSinceNow < -logGlobals.indenetationInterval {
            logGlobals.prefix += logGlobals.indentationString
            print("Yes")
        }
        logGlobals.lastLogTime = Date()
        return logGlobals.prefix + className
        
    }
    
    private static func bumpInstanceCount(for className: String) -> Int {
        
        logGlobals.instanceCounts[className] = (logGlobals.instanceCounts[className] ?? 0) + 1
        return logGlobals.instanceCounts[className]!
    }
    
    private var instanceCount: Int!
    
    private func logVCL(_ msg: String) {
        
        let className = String(describing: type(of:self))
        if instanceCount == nil {
            instanceCount = VCLoggingViewController.bumpInstanceCount(for: className)
            
        }
        print("\(VCLoggingViewController.logPrefix(for: className))(\(instanceCount!)) \(msg)")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logVCL("init(coder:) - created via InterfaceBuilder")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logVCL("init(nibName:bundle:) - create in code")
        
    }
    
    deinit {
        
        logVCL("left the heap")
    }
    
    override func awakeFromNib() {
        logVCL("awakeFromNib()")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logVCL("viewDidLoad()")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logVCL("viwwWillAppear(animated = \(animated))")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logVCL("viewDidAppear(animated = \(animated))")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        logVCL("viewWillDisappear(animated = \(animated))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        logVCL("didReceiveMemoryWarning()")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logVCL("viewWillLayoutSubviews()")
    }
    
    
    
    
    
}
