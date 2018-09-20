//
//  APIManager.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/18/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class APIManager: NSObject {
    
    enum Router: URLRequestConvertible {
        
        static let baseURLString = BASE_URL
        
        // MARK: Functions
        case getDeliveryList([String : Int])

        // MARK: Request methods
        var method: HTTPMethod {
            switch self {
            case .getDeliveryList:
                return .get
            }
        }
        
        // MARK: Endpoints
        var path: String {
            switch self {
            case .getDeliveryList:
                return ENDPOINTS_DELIVERY_LIST
            }
        }
        
        // MARK: URLRequestConvertible
        func asURLRequest() throws -> URLRequest {
            
            let url = try Router.baseURLString.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            switch self {
                
            case .getDeliveryList(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
            
            return urlRequest
        }
    }
    
    static let sharedManager = APIManager ()
    
    //MARK: - Delivery API
    
    func makeRequestToGetDeliveryList(param: [String : Int], completion: @escaping completionHandlerWithSucessAndResultArray) {

        let realmManager = RealmManager()
        Alamofire.request(Router.getDeliveryList(param as [String : Int]))
            .responseString { response in
                
                switch response.result {
                    
                case .success(let STRING):
                    if response.response?.statusCode == 200 {
                        let JSON = (STRING as String).toJSON()
                        if let result = JSON as? NSArray {
                            var deliveryArray = [Delivery]()

                            for item in result {
                                let newDelivery = Delivery.init(data: item as! [String : AnyObject])
                                realmManager.saveObjects(objs: newDelivery)
                                deliveryArray.append(newDelivery)

                                self.makeRequestToDownloadImageForItem(item: newDelivery)
                            }
                            completion(true, deliveryArray)
                        }
                    }
                    else {
                        completion(false, nil)
                    }
                    
                case .failure(let Error):
                    print("Request failed with error: \(Error)")
                    completion(false, nil)
                }
        }
    }
    
    // Mark : - Downlaod image from server
    
    func makeRequestToDownloadImageForItem(item: Delivery) {
        let strURL:String = item.imageUrl
        Alamofire.request(strURL).responseData(completionHandler: { response in
            DataManager.sharedManager.writeData(data: response.data!, fileName: item.deliveryID+".jpg")
        })

    }
}
