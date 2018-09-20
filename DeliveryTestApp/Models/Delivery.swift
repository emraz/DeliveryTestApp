//
//  Delivery.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/18/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class Delivery: Object {
    
    @objc dynamic var deliveryID = ""
    @objc dynamic var descrption = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var location: Location?
    
    convenience init(data: [String : AnyObject]) {
        self.init()
        
        if let dID = data["id"] as? Int {
            self.deliveryID = String(dID)
        }
        
        if let dsc = data["description"] as? String {
            self.descrption = dsc
        }
        
        if let imgURL = data["imageUrl"] as? String {
            self.imageUrl = imgURL
        }
        
        if let lctn = data["location"] as? [String : AnyObject] {
            
            let itm = Location.init(data: lctn)
            self.location = itm
        }
    }
}
