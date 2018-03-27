//
//  ThirdViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 14/03/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBAction func clickToAbout(_ sender: Any) {
    performSegue(withIdentifier: "segueAboutToMap", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide the status bar
    override var prefersStatusBarHidden: Bool{
        return true;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
