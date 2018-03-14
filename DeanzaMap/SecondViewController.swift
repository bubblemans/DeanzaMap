//
//  SecondViewController.swift
//  DeanzaMap
//
//  Created by Alvin Lin on 24/02/2018.
//  Copyright © 2018 Alvin Lin. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var destination: String?
    var startPoint: String?
    var startPin: AnnotationPin!
    var endPin: AnnotationPin!
    
    // Outlet
    @IBOutlet weak var sideBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideBar: UIView!
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var blurSideBar: UIVisualEffectView!
    @IBOutlet weak var navigationBarConstraint: NSLayoutConstraint!
    @IBOutlet var mapKitView: MKMapView!
    
    // Action
    @IBAction func changeToSearchPage(_ sender: Any) {
        performSegue(withIdentifier: "segue2", sender: self)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let displayProgressBar = segue.destination as? ViewController{
            displayProgressBar.hideProgressBar = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //homeButton
        //homeButton.layer.cornerRadius = 7.5
        
        //blurSideBar
        //blurSideBar.layer.cornerRadius = 7.5
        
        //sideBar
        //sideBar.layer.cornerRadius = 7.5
        sideBar.layer.shadowColor = UIColor.black.cgColor
        sideBar.layer.shadowOpacity = 1
        sideBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        sideBar.backgroundColor = UIColor(displayP3Red: 205/255, green: 206/255, blue: 205/255, alpha: 1)
        
        //sideBarConstraint
        sideBarConstraint.constant = -175
        
        //navigationBar
        navigationBar.backgroundColor = UIColor(displayP3Red: 54/255, green: 72/255, blue: 94/255, alpha: 1)
        
        //mapKitView
        mapKitView.delegate = self
        mapKitView.showsScale = true
        mapKitView.showsCompass = true
        mapKitView.showsBuildings = true
        mapKitView.showsUserLocation = true
        mapKitView.showsPointsOfInterest = true
        
        //Show the location and navigate the user to destination
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
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
            else if start == "atc" || destination == "ATC"{
                sourceCoordinates = CLLocationCoordinate2DMake(37.321018, -122.044512)
            }
            else{
                sourceCoordinates = CLLocationCoordinate2DMake(37.3203, -122.0467)
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
        
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 1.0
        
        return renderer
    }
/*
    func locationManager(_ manager: CLLocationManager, didUpdateHeading location: [CLLocation]) {
        
        let location = location[0]
        let center = location.coordinate
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        mapKitView.setRegion(region, animated: true)
        mapKitView.showsUserLocation = true
        
    }
 */
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
