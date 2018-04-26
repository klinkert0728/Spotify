//
//  BaseUIViewController.swift
//  Spotify
//
//  Created by Daniel Klinkert Houfer on 4/26/18.
//  Copyright © 2018 Daniel Klinkert Houfer. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    @IBInspectable var colorNavBar:String  = "" {
        didSet {
            Appearance.colorNavigationBar(color: UIColor.colorFromString(titleColor: colorNavBar), navigationBar: navigationController?.navigationBar)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureAppearance() {
        if colorNavBar.count > 0 {
            Appearance.colorNavigationBar(color: UIColor.colorFromString(titleColor: colorNavBar), navigationBar: navigationController?.navigationBar)
        }
        
        self.navigationItem.leftBarButtonItem   = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
