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
    
    
    //created a variable destination to show directions.
    
    var destination:MKMapItem = MKMapItem()
    
    

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
    }
    
    
    
    //Segemented Control func for Standard, Sattelite, Hybrid views.
    @IBAction func segmentControl(sender: AnyObject) {
        
        switch sender.selectedSegmentIndex{
        case 1:
            mapView.mapType = MKMapType.SatelliteFlyover
            
        case 2:
            mapView.mapType = MKMapType.HybridFlyover
            
        default:
            mapView.mapType = MKMapType.Standard
        
        }
        
    }


    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        
        print("Got Location \(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)", terminator: "")
        
        myLoc = newLocation.coordinate
        
        locationManager.stopUpdatingLocation()
        
        lblLocation.text = "\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)"
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
        
    }
    // This IBaction Func is for add a pin to the mapView.
    @IBAction func addPin(sender: UILongPressGestureRecognizer) {
        
        let location = sender.locationInView(self.mapView)
        //Lets one know where the user touched on the mapView.
        let coordLoc = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        //Converts touched point to coordinate.
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordLoc
        annotation.title = "newPin"
        annotation.subtitle = "Big name COO!"
        //Annotation settings for a new pin using the coordinate above.
        
        //created a place mark from the coordinate above and a map item.
        
        let placeMark = MKPlacemark(coordinate: coordLoc, addressDictionary: nil)
        
        
        //This is need when we need to get a direction.
        
        destination = MKMapItem(placemark: placeMark)
        
        
        
        self.mapView.removeAnnotations(mapView.annotations)
        //Only comment back in if you want to add only one pin at a time.
        
        self.mapView.addAnnotation(annotation)
    
        
    }
    // IBAction func showDirections added to Directions button.
    //Prints instructions on console.
    @IBAction func showDirections(sender: AnyObject) {
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        
        
        request.destination = destination
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { (response, error ) -> Void in

            
            if error != nil {
                print("Error \(error)", terminator: "")
            
            } else {
                
                let overlays = self.mapView.overlays
                
                self.mapView.removeOverlays(overlays)
                
                for route in response!.routes
                    {
                        self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                        
                        for next in route.steps
                        {
                            print(next.instructions)
                        }
                    
                    }
            }
    
        }
    
    }
    
    //Adds route path&color to map.
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayPathRenderer!
        {
            let draw = MKPolylineRenderer(overlay: overlay)
            draw.strokeColor = UIColor.redColor()
            draw.lineWidth = 3.0
            return draw
            
    
        }
    
    

}










