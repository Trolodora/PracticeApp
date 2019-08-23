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


struct PreferencesKeys {
    static let savedItems = "savedItems"
}

class MapViewController: UIViewController {
    //MARK - Properties
    
    var pins = [UserPin]()
    @IBOutlet weak var locationName: UITextField!
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.mapType = .standard
        }
    }
    //MARK - Funcs
    @IBAction func removePins(_ sender: Any) {
        for pin in pins{
            mapView.removeAnnotation(pin)
        }
        pins.removeAll()
        stopMonitoring()
        saveAllPins()
    }
    //MARK - REGIONS
    func regions(with pin: UserPin) -> CLCircularRegion{
        let region = CLCircularRegion(center: pin.coordinate, radius: pin.radius, identifier: pin.title!)
        return region
    }
    
    
    func monitoreRegion(pin: UserPin){
        let fenceRegion = regions(with: pin)
        locationManager.startMonitoring(for: fenceRegion)
    }
    
    func stopMonitoring(){
        let regions = locationManager.monitoredRegions
        for region in regions{
            
            locationManager.stopMonitoring(for: region)
        }
        
    }
    
    func add(_ pin:UserPin){
        pins.append(pin)
        mapView.addAnnotation(pin)
        locationName.text! = ""
        monitoreRegion(pin: pin)
        saveAllPins()
    }
    
    func loadAllPins() {
        pins.removeAll()
        let allpins = UserPin.allPins()
        allpins.forEach { add($0) }
    }
    func saveAllPins(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(pins)
            UserDefaults.standard.set(data, forKey: PreferencesKeys.savedItems)
        } catch {
            print("error encoding geotifications")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        loadAllPins()
    }
    //MARK - Adding pin to map
    @IBAction func addPin(_ sender: UITapGestureRecognizer) {
        if locationName.text != ""{
            let location = sender.location(in: self.mapView)
            let coordinate = self.mapView.convert(location, toCoordinateFrom: self.mapView)
            let radius = 10000.0
            let title = locationName.text!
            let pin = UserPin(coordinate: coordinate,  title: title, radius: radius)
            add(pin)
            
        }
        else{
            print("nope")
        }
    }
    
}
//MARK - Delegation
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
        print("you entered\(region.identifier)")
        let alert = UIAlertController(title: "You entered location", message: "You entered \(region.identifier)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated:true)
    }
    
}
