//
//  MapViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/10/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var locationName: UITextField!
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!{
        
        didSet{
            mapView.mapType = .standard
            
        }
    }
    
    
    func clearReg(){
        let regions = locationManager.monitoredRegions
        for region in regions{
            locationManager.stopMonitoring(for: region)
        }
        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        clearReg()
            
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPin(_ sender: UITapGestureRecognizer) {
        self.mapView.removeAnnotations(mapView.annotations)
        let location = sender.location(in: self.mapView)
        let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        let anotation = MKPointAnnotation()
        anotation.coordinate = coordinate
        anotation.title = locationName.text!
        anotation.subtitle = ""
        self.mapView.addAnnotation(anotation)
         let geoFence = CLCircularRegion(center: anotation.coordinate, radius: 10000, identifier: anotation.title!)
        
        locationManager.startMonitoring(for: geoFence)
        locationName.text! = ""
    }

}

extension MapViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            print(location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            print("nope")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
      
        print(region.identifier)
        let alert = UIAlertController(title: "Entered Location", message: "you entered \(region.identifier)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    
}
