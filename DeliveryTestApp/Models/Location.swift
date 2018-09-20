//
//  Location.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/18/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class Location: Object {
    @objc dynamic var lat = 0.0
    @objc dynamic var lng = 0.0
    @objc dynamic var address = ""
    
    convenience init(data: [String : AnyObject]) {
        self.init()
        
        if let lt = data["lat"] as? Double {
            self.lat = lt
        }
        if let ln = data["lng"] as? Double {
            self.lng = ln
        }
        if let adrs = data["address"] as? String {
            self.address = adrs
        }
    }

}
