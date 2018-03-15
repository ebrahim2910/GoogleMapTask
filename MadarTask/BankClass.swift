//
//  BankClass.swift
//  MadarTask
//
//  Created by Admin on 3/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
class BankClass {
    
    var bankName  : String
    var longitude :Float
    
    var latitude :Float
    
    
    init(bankName :String, longitude :Float , latitude :Float){
        
        self.bankName = bankName
        self.longitude = longitude
        self.latitude = latitude
        
    }
    
    
    
}
