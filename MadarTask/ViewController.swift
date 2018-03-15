//
//  ViewController.swift
//  MadarTask
//
//  Created by Admin on 3/12/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController ,CLLocationManagerDelegate {

    
    
    @IBOutlet weak var bankBtn: UIButton!
    var locationManager = CLLocationManager()
    
    @IBAction func toBank(_ sender: Any) {
        
        //UserDefaults.standard.object(forKey: "coordinationPlaces")
        
        performSegue(withIdentifier: "toBanks", sender: self)
        
    }
    
    
    
    @IBOutlet weak var mosqueBtn: UIButton!
    
    
    @IBAction func toMosque(_ sender: Any) {
        
        //UserDefaults.standard.set( lonString , forKey: "longitude")
        
        performSegue(withIdentifier: "toMosque", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        
//        l
        
        
    
            
        
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                
                self.initializeTheLocationManager()
                
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func initializeTheLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        let latNumber =   mosqueDataArray[indexPath.row].latitude
//        
//        let latString = NSString(format: "%.2f", latNumber)
        
       locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var location = locationManager.location?.coordinate
        
        cameraMoveToLocation(toLocation: location)
        //locationManager.stopUpdatingLocation()
        
        
        
        var coordination = "\(location?.latitude),\(location?.longitude)"
        
        UserDefaults.standard.set(coordination, forKey: "coordinationPlaces")
        print(location?.longitude)
        
        
        
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            
            let camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
            let mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 100, width: 500, height: 900), camera: camera)
           
            self.view.addSubview(mapView)
            mapView.addSubview(self.bankBtn)
            mapView.addSubview(self.mosqueBtn)
            
            
            // Creates a marker in the center of the map.
//            let marker = GMSMarker()
//            marker.position = CLLocationCoordinate2D(latitude: (toLocation?.latitude)!, longitude: (toLocation?.longitude)!)
//            
//            marker.map = mapView
            
            
        }
    }


}

