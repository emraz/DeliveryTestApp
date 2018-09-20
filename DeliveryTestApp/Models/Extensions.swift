//
//  Extensions.swift
//  DeliveryTestApp
//
//  Created by Mahmudul Hasan R@zib on 9/19/18.
//  Copyright © 2018 Matrix Solution Ltd. All rights reserved.
//

import UIKit

class Extensions: NSObject {

}

extension UIViewController {
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
