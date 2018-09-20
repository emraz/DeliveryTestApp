//
//  RealmManager.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/21/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import  RealmSwift

class RealmManager: NSObject {
    
    let realm = try? Realm()
    
    // delete table
    func deleteDatabase() {
        try! realm?.write({
            realm?.deleteAll()
        })
    }
    
    // delete particular object
    func deleteObject(objs : Object) {
        try? realm!.write ({
            realm?.delete(objs)
        })
    }
    
    //Save array of objects to database
    func saveObjects(objs: Object) {
        try? realm!.write ({
            // If update = false, adds the object
            realm?.add(objs, update: false)
        })
    }
    
    // editing the object
    func editObjects(objs: Object) {
        try? realm!.write ({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            realm?.add(objs, update: true)
        })
    }
    
    //Returs an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm!.objects(type)
    }
    
    func incrementID() -> Int {
        return (realm!.objects(Delivery.self).max(ofProperty: "deliveryID") as Int? ?? 0) + 1
    }
    
}
