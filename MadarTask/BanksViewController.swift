//
//  BanksViewController.swift
//  MadarTask
//
//  Created by Admin on 3/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import CoreLocation

class BanksViewController: UIViewController , CLLocationManagerDelegate ,UITableViewDelegate  , UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!

    
    
    let locationManager = CLLocationManager()

    
    var bankDataArray = [BankClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.locationManager.requestAlwaysAuthorization()
//        
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        
//            locationManager.delegate = self
//            //locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        
//        
//        tableView.dataSource = self
//        tableView.delegate = self
//        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
//        print("locations = \(locValue.latitude) ,\(locValue.longitude)")
//        
//        var coordination = "\(locValue.latitude),\(locValue.longitude)"
        
      //let coordination =   UserDefaults.standard.object(forKey: "coordinationPlaces") as! String
        
        
        if( UserDefaults.standard.object(forKey:"coordinationPlaces") as? String != nil){
            let coordination =   UserDefaults.standard.object(forKey: "coordinationPlaces") as! String
            loadBankData(myCoordintion: coordination)

        }
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
  
    }
    
    


    func loadBankData( myCoordintion : String) {
        
        //let urlStr = UserDefaults.standard.object(forKey: "teamPlayerHref") as? String
        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(myCoordintion)&radius=5000&type=bank&key=AIzaSyBKysKgVzsjYKeRAuaqeMpEKTk_1de2Odg"
        
        var request = URLRequest(url : URL(string :url)!)
        
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration , delegate: nil , delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){(data, response , error) in
            
            if (error != nil ){
                
                
                print("error")
                
                
            } else {
                
                
                
                
                do{
                    
                    let fetchData = try JSONSerialization.jsonObject(with: data! , options:JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
                    
                    let arrJSON = fetchData["results"] as! [[String : Any]]
                    
                    
                    
                    for eachFetchBank in arrJSON {
                        
                        
                        
                        
                        let  bankName  = eachFetchBank["name"] as! String
                        
                      //  let playerPosition = eachFetchBank["position"] as! String
                        
                        
                        let geometry = eachFetchBank["geometry"] as! [String : Any]

                        let location = geometry["location"] as! [String : Any]
                        
                        let lng = location["lng"] as! Float
                        
                        let lat = location["lat"] as! Float
                        
                        
                        self.bankDataArray.append(BankClass(bankName: bankName, longitude: lng, latitude: lat))
                        
                        
                    }
                    
                    
                    
                    //print(self.playersArray[0].playerName)
                    
                    
                    self.tableView.reloadData()
                    
                    
                    
                    
                    
                    
                }
                catch{
                    
                    
                    
                    print(" error catch")
                    
                    
                }
                
            }
            
            
            
            
        }
        
        task.resume()
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankDataArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BankTableViewCell
//        
//        cell.bio.text! = bioArray[indexPath.row]
//        //cell.bio?.numberOfLines = 0
//        cell.followerName.text! = followerName[indexPath.row]
//        
//        cell.followerImage.image = followerImage[indexPath.row]
        cell.placeName.text = bankDataArray[indexPath.row].bankName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       // myIndex = indexPath.row
        
      let latNumber =   bankDataArray[indexPath.row].latitude
        
        let latString = NSString(format: "%.2f", latNumber)
        
      UserDefaults.standard.set( latString , forKey: "latitde")
        
        
        let lonNumber =   bankDataArray[indexPath.row].longitude
        let lonString = NSString(format: "%.2f", lonNumber)
        
        UserDefaults.standard.set( lonString , forKey: "longitude")
        
       performSegue(withIdentifier: "fromBank", sender: self)
    }
}
