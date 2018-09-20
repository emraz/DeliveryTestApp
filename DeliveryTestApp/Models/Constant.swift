//
//  Constant.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/18/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit
import RealmSwift


class Constant: NSObject {

}

typealias completionHandlerWithSucessAndResultArray = (_ success: Bool, _ resultArray:Array<Any>?) -> Void


let BASE_URL = "https://mock-api-mobile.dev.lalamove.com"
let ENDPOINTS_DELIVERY_LIST = "deliveries"
let PLACE_HOLDER_IMAGE_NAME = "place_holder.jpg"
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height


