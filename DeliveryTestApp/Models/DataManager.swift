//
//  DataManager.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/20/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    static let sharedManager = DataManager()
    
    private var imageFileDirectory: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func writeData(data: Data, fileName: String) {
        let fileURL = imageFileDirectory.appendingPathComponent(fileName)
        if(!FileManager.default.fileExists(atPath: fileURL.path)) {
            do {
                try data.write(to: fileURL)
                //print("Saved")
            } catch let error as NSError {
                print("Write Error: \(error.localizedDescription)")
            }
        }
    }
    
    func readData(fileName: String) -> Data {
        var storeData = Data()
        let fileURL = imageFileDirectory.appendingPathComponent(fileName)
        do {
            storeData = try Data(contentsOf: fileURL)
        }  catch let error as NSError {
            print("Read Error: \(error.localizedDescription)")
        }
        return storeData
    }
    
    // fetch all the objects in table
    func getAllObjects() -> [Delivery]{
        let realmManager = RealmManager()

        var deliveryArr = [Delivery]()
        if let objects = realmManager.getObjects(type: Delivery.self) {
            for element in objects {
                if let delivery = element as? Delivery {
                    deliveryArr.append(delivery)
                }
            }
        }
        return deliveryArr
    }
    
}
