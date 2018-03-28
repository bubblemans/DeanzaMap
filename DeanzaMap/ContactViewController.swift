//
//  ContactViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 16/03/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController{

    let link = ["facebook", "instagram", "github"]
    //IBOutlet
    @IBOutlet weak var navigationBar: UIView!

    //IBAction
    @IBAction func clickConToMap(_ sender: Any) {
        performSegue(withIdentifier: "segueConToMap", sender: self)
    }
    @IBAction func clickToGithub(_ sender: Any) {
        if let url = NSURL(string: "https://github.com/bubblemans"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    @IBAction func clickToInstagram(_ sender: Any) {
        if let url = NSURL(string: "https://www.instagram.com/hong_yeh1846/"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    @IBAction func clickToFacebook(_ sender: Any) {
        if let url = NSURL(string: "https://www.facebook.com/fa.ke.169"){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = GRAYTHEME
        
        //navigationBar
        navigationBar.backgroundColor = BLUETHEME
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide the status bar
    override var prefersStatusBarHidden: Bool{
        return true;
    }
}
