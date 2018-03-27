//
//  AboutUsViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 27/03/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var dogInformText: UILabel!
    @IBOutlet weak var myInformText: UILabel!
    
    //IBAction
    @IBAction func ClickAboutToMap(_ sender: Any) {
        performSegue(withIdentifier: "segueAboutToMap", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GRAYTHEME
        
        //navigationBar
        navigationBar.backgroundColor = BLUETHEME
        
        //myInformText
        myInformText.text = MYINFORM
        
        //dogInformText
        dogInformText.text = DOGINFORM
        
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
