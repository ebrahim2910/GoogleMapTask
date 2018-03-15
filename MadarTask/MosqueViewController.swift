//
//  MosqueViewController.swift
//  MadarTask
//
//  Created by Admin on 3/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class MosqueViewController: UIViewController , UITableViewDelegate  , UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var mosqueDataArray = [MosqueClass]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: .zero)

        if( UserDefaults.standard.object(forKey: "coordinationPlaces") as? String != nil){
        let coordination =   UserDefaults.standard.object(forKey: "coordinationPlaces") as! String
            
            loadMosqueData(myCoordintion: coordination)

        }
        else {
            let alert = UIAlertController(title: "Alert", message: "empty user location ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }
    
    func loadMosqueData(myCoordintion: String) {
        
      
        //31.2001,29.9187  in case  the simulator did not get location you can  use this coordintion to get Mosques

        

        
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(myCoordintion)&radius=5000&type=mosque&key=AIzaSyBKysKgVzsjYKeRAuaqeMpEKTk_1de2Odg"
        
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
                        
                        
                        
                        
                        let  mosqueName  = eachFetchBank["name"] as! String
                        
                        //  let playerPosition = eachFetchBank["position"] as! String
                        
                        
                        let geometry = eachFetchBank["geometry"] as! [String : Any]
                        
                        let location = geometry["location"] as! [String : Any]
                        
                        let lng = location["lng"] as! Float
                        
                        let lat = location["lat"] as! Float
                        
                        
                        self.mosqueDataArray.append(MosqueClass(mosqueName: mosqueName, longitude: lng, latitude: lat))
                        
                        
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
        return mosqueDataArray.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MosqueTableViewCell
      
        cell.mosqueNameLable.text = mosqueDataArray[indexPath.row].mosqueName
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // myIndex = indexPath.row
        
        
        let latNumber =   mosqueDataArray[indexPath.row].latitude
        
        let latString = NSString(format: "%.2f", latNumber)
        
        UserDefaults.standard.set( latString , forKey: "latitde")
        
        
        let lonNumber =   mosqueDataArray[indexPath.row].longitude
        
        let lonString = NSString(format: "%.2f", lonNumber)
        
        
        
        UserDefaults.standard.set( mosqueDataArray[indexPath.row].mosqueName , forKey: "palceName")
        
        UserDefaults.standard.set( lonString , forKey: "longitude")
        
        
        
        performSegue(withIdentifier: "fromMosque", sender: self)
        
    }


}
