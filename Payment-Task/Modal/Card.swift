//
//  Card.swift
//  Payment-Task
//
//  Created by Macbook on 26.10.2017.
//  Copyright © 2017 Yigit Yilmaz. All rights reserved.
//

import Foundation

struct Card{
    
    var isStored: Bool?
    var holderName, cardNumber, expDate, cvc: String?
    let defaults = UserDefaults.standard
    
    init(){
        if let isStored = defaults.object(forKey: "isStored") as? Bool,
            let holderName = defaults.object(forKey: "holderName") as? String,
            let cardNumber = defaults.object(forKey: "cardNumber") as? String,
            let expDate = defaults.object(forKey: "expDate") as? String,
            let cvc = defaults.object(forKey: "cvc") as? String{
            
            self.isStored = isStored
            self.holderName = holderName
            self.cardNumber = cardNumber
            self.expDate = expDate
            self.cvc = cvc
        }else{
            self.isStored = nil
            self.holderName = nil
            self.cardNumber = nil
            self.expDate = nil
            self.cvc = nil
        }
        
    }
}
