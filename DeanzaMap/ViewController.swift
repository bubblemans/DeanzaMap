//
//  ViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 21/02/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit

var count = 0
class ViewController: UIViewController{
    
    //Local variables
    var minValue = 0
    let maxValue = 100
    var loading = Timer()
    var hideProgressBar: Bool?
    
    //IBOutlets
    @IBOutlet weak var loadingBar: UIProgressView!
    @IBOutlet weak var loadingPercent: UILabel!
    @IBOutlet weak var percentSign: UILabel!    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchBarStartPoint: UITextField!
    
    
    //IBAction
    
    @IBAction func clickToNextPage(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    /*
    func addCount(){
        count = count + 1
    }*/
    
    /**
    The function update the progress bar.
    */
    @objc func updater(){
        spinner.startAnimating()
        if minValue != maxValue {
            minValue += 1
            loadingPercent.text = "\(minValue)"
            loadingBar.progress = Float(minValue) / Float(maxValue)
        }
        else{
            minValue = 0
            loading.invalidate()
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
            loadingBar.isHidden = true
            loadingPercent.isHidden = true
            percentSign.isHidden = true
            searchButton.isHidden = false
            searchBar.isHidden = false
            searchBarStartPoint.isHidden = false
        }
    }
 
    /**
     This function pass startpoint and endpoint input by users to SecondViewController
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SecondViewController{
            destination.destination = searchBar.text
        }
        
        if let start = segue.destination as? SecondViewController{
            start.startPoint = searchBarStartPoint.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background color setting
        view.backgroundColor = GRAYTHEME

        //loadingBar
        loadingBar.tintColor = .black
        loadingBar.trackTintColor = .white
        loadingBar.setProgress(0, animated: false)
        loading = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updater), userInfo: nil, repeats: true)
        
        //spinner
        spinner.color = .white
        
        //searchButton
        searchButton.isHidden = true
        searchButton.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        searchButton.layer.cornerRadius = 7.5
        
        //searchBar
        searchBar.isHidden = true
        searchBar.layer.cornerRadius = 7.5
        searchBar.placeholder = "Where to go?"
        
        //searchBarStartPoint
        searchBarStartPoint.isHidden = true
        searchBarStartPoint.placeholder = "Your location"
        
        //Hide the progressBar
        if hideProgressBar == true {
            loading.invalidate()
            spinner.stopAnimating()
            spinner.isHidden = true
            loadingBar.isHidden = true
            loadingPercent.isHidden = true
            percentSign.isHidden = true
            searchButton.isHidden = false
            searchBar.isHidden = false
            searchBarStartPoint.isHidden = false
        }
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true;
    }
}
