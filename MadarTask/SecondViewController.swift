//
//  SecondViewController.swift
//  MadarTask
//
//  Created by Admin on 3/14/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import GoogleMaps


class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    let latitude =   UserDefaults.standard.object(forKey: "latitde") as! String
        
    let longitude =   UserDefaults.standard.object(forKey: "longitude") as! String
        
        
        
        let mapLat = (latitude as NSString).floatValue
        let mapLong = (longitude as NSString).floatValue
        
    let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(mapLat) , longitude: CLLocationDegrees(mapLong) ,  zoom: 15)
    let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(mapLat), longitude: CLLocationDegrees(mapLong) )
        
            marker.map = mapView
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
