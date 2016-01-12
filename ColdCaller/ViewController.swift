//
//  ViewController.swift
//  ColdCaller
//
//  Created by Christopher Zevallos on 1/9/16.
//  Copyright © 2016 ChristopherZev. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblLocation: UILabel!
   
    
    
    var locationManager = CLLocationManager()
    var myLoc = CLLocationCoordinate2D()

    @IBAction func startGps(sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let coordLoc = CLLocationCoordinate2D(latitude: 40.759 , longitude: -73.984)
        // Annotation coordinate test.
        
     
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordLoc
        annotation.title = "Cold Call Opp"
        annotation.subtitle = "Big name CEO!"
        
        mapView.addAnnotation(annotation)
        
        //Named annotation test(Cold Call Opp) and added it to mapView.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        
        print("Got Location \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)")
        
        myLoc = newLocation.coordinate
        
        locationManager.stopUpdatingLocation()
        
        lblLocation.text = "\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)"
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    
    
    
}

