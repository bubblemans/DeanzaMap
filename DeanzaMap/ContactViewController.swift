//
//  ContactViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 16/03/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    
    @IBAction func clickConToMap(_ sender: Any) {
        performSegue(withIdentifier: "segueConToMap", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
