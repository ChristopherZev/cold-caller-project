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
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    
    
    
}

