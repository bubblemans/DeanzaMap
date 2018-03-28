//
//  SecondViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 24/02/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import MapKit

var beginPoint = CLLocationCoordinate2D(latitude: 0,longitude: 0)
var endPoint = CLLocationCoordinate2D(latitude: 0,longitude: 0)
var beginName = ""
var endName = ""
var timer = 30

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var destination: String?
    var startPoint: String?
    var startPin: AnnotationPin!
    var endPin: AnnotationPin!

    // declare a struct to contain location
    /*
    struct Location{
        var name: String
        var x: Double
        var y: Double
    }
    var location:[Location] = []
    */
    
    // Outlet
    @IBOutlet weak var sideBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideBar: UIView!
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var blurSideBar: UIVisualEffectView!
    @IBOutlet weak var navigationBarConstraint: NSLayoutConstraint!
    @IBOutlet var mapKitView: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var popOutMessage: UITextView!
    @IBOutlet weak var popOutView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    
    // Action
    @IBAction func changeToSearchPage(_ sender: Any) {
        performSegue(withIdentifier: "segue2", sender: self)
    }
    @IBAction func ClickToAbout(_ sender: Any) {
        performSegue(withIdentifier: "segueToAbout", sender: self)
    }
    @IBAction func clickToContact(_ sender: Any) {
        performSegue(withIdentifier: "segueToContact", sender: self)
    }
    @IBAction func cacelPopOut(_ sender: Any) {
        popOutView.isHidden = true
        navigationBar.isHidden = false
    }
    
    // When click the menu button, it will slide out the sida bar.
    @IBAction func menuButton(_ sender: Any) {
        if self.sideBarConstraint.constant == 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.sideBarConstraint.constant = -175
                self.navigationBarConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        else{
            UIView.animate(withDuration: 0.2, animations: {
                self.sideBarConstraint.constant = 0
                self.navigationBarConstraint.constant = 175
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    // Swipe the screen to slid out or hide the side bar.
    @IBAction func panPerform(_ sender: UIPanGestureRecognizer) {
        
        // when the user swipe it
        if sender.state == .began || sender.state == .changed {
            
            let translation = sender.translation(in: self.view).x
            
            // swipe right
            if translation > 0{
                // swipe to the certain position
                if sideBarConstraint.constant < 10{
                    UIView.animate(withDuration: 0.2, animations: {
                        self.sideBarConstraint.constant += translation / 5
                        self.navigationBarConstraint.constant += translation / 5
                        self.view.layoutIfNeeded()
                    })
                }
            }
                
            // swipe left
            else{
                // swipe to the certain position
                if sideBarConstraint.constant > -175{
                    UIView.animate(withDuration: 0.2, animations: {
                        self.sideBarConstraint.constant += translation / 5
                        self.navigationBarConstraint.constant += translation / 5
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
            
        // when the user is done with swiping
        else if sender.state == .ended{
            
            // When the user swipe to left, make it to be swiped to the very left even though it's not be swiped enough.
            if sideBarConstraint.constant < -100{
                UIView.animate(withDuration: 0.2, animations: {
                    self.sideBarConstraint.constant = -175
                    self.navigationBarConstraint.constant = 0
                    self.view.layoutIfNeeded()
                })
            }
            
            // When the user swipe to right, make it to be swiped to clip to the margin even though it's not be swiped enough.
            else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.sideBarConstraint.constant = 0
                    self.navigationBarConstraint.constant = 175
                    self.view.layoutIfNeeded()
                })
            }
        }
        
    }
    
    /**
    This function update the timer
    */
    @objc func updateTimer(){
        if timer == 0 {
            timer = timer - 2;
            popOutView.isHidden = false
        }
        timer = timer - 1
    }
    
    /*
    func createLocationArray(){
        let library = Location(name: "library", x: 37.3203, y: -122.0467)
        let cafe = Location(name: "cafe", x: 37.320651, y: -122.04536)
        let atc = Location(name: "atc", x: 37.321018, y: -122.044512)
        let ATC = Location(name: "ATC", x: 37.321018, y: -122.044512)
        
        location.append(library)
        location.append(cafe)
        location.append(atc)
        location.append(ATC)
    }*/
    
    //switch to the search but don't show the progress bar
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let displayProgressBar = segue.destination as? ViewController{
            displayProgressBar.hideProgressBar = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Countdown timer
        var _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        //popOut
        popOutMessage.layer.cornerRadius = 7.5
        cancelButton.layer.cornerRadius = 7.5
        cancelButton.backgroundColor = UIColor.white
        popOutView.backgroundColor = BLUETHEME
        
        //popOutMessage
        popOutMessage.text = POPOUTMESSAGE
        popOutView.isHidden = true
        
        //sideBar
        sideBar.layer.shadowColor = UIColor.black.cgColor
        sideBar.layer.shadowOpacity = 1
        sideBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        sideBar.backgroundColor = UIColor(displayP3Red: 205/255, green: 206/255, blue: 205/255, alpha: 1)
        
        //sideBarConstraint
        sideBarConstraint.constant = -175
        
        //navigationBar
        navigationBar.backgroundColor = BLUETHEME
        
        
        /*
        if count == 2 {
            popOutView.isHidden = false
            navigationBar.isHidden = true
        }
        else {
            popOutView.isHidden = true
        }
        */

        //mapKitView
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsCompass = false
        mapKitView.showsBuildings = true
        mapKitView.showsUserLocation = true
        mapKitView.showsPointsOfInterest = true
        
        // Request user's current location.
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        // Get the user's location.
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        // Set up the coordinates of the start point and end point.
        var sourceCoordinates = locationManager.location?.coordinate
        var destinationCoordinates = CLLocationCoordinate2DMake(0, 0)
        
        
        if let start = startPoint{
            
            if start == "library" {
                sourceCoordinates = CLLocationCoordinate2DMake(37.3203, -122.0467)
            }
            else if start == "cafe"{
                sourceCoordinates = CLLocationCoordinate2DMake(37.320651, -122.04536)
            }
            else if start == "atc" || start == "ATC"{
                sourceCoordinates = CLLocationCoordinate2DMake(37.321018, -122.044512)
            }
            else{
                destinationCoordinates = CLLocationCoordinate2DMake(37.3203, -122.0467)
            }
        }
        
        if let destination = destination{
            if destination == "library" {
                destinationCoordinates = CLLocationCoordinate2DMake(37.3203, -122.0467)
            }
                
            else if destination == "cafe"{
                destinationCoordinates = CLLocationCoordinate2DMake(37.320651, -122.04536)
            }
            else if destination == "atc" || destination == "ATC"{
                destinationCoordinates = CLLocationCoordinate2DMake(37.321018, -122.044512)
            }
            else{
                destinationCoordinates = CLLocationCoordinate2DMake(37.3203, -122.0467)
            }
        }
        
        // Annotation pin
        if sourceCoordinates != nil && startPoint != nil && destination != nil{
            
            startPin = AnnotationPin(title: startPoint!, subtitle: "", coordinate: sourceCoordinates!)
            endPin = AnnotationPin(title: destination!, subtitle: "", coordinate: destinationCoordinates)
            
            mapKitView.addAnnotation(startPin as! MKAnnotation)
            mapKitView.addAnnotation(endPin as! MKAnnotation)
            
            // Put the coordinates we just set up into startpoint and endpoint
            let sourcePlaceMark = MKPlacemark(coordinate: sourceCoordinates!)
            let destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinates)
            
            let sourceItem = MKMapItem(placemark: sourcePlaceMark)
            let destinationItem = MKMapItem(placemark: destinationPlaceMark)
            
            // Navigation
            let directionRequest = MKDirectionsRequest()
            directionRequest.source = sourceItem
            directionRequest.destination = destinationItem
            directionRequest.transportType = .walking
            
            let directions = MKDirections(request: directionRequest)
            directions.calculate(completionHandler: {
                response, error in
                
                guard let response = response else{
                    if let error = error{
                        print("Something's wrong.")
                    }
                    return
                }
                
                let route = response.routes[0]
                self.mapKitView.add(route.polyline, level: .aboveRoads)
                
                let rekt = route.polyline.boundingMapRect
                self.mapKitView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
            })
        }
    }
    /**
     Draw the navigation line.
     */
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 1.0
        return renderer
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
