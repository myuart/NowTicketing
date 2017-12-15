//
//  Fare.swift
//  NowTicketing
//
//  Created by Maria Yu on 12/14/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import Foundation

class Fare {
    var description: String?
    var price: Double?
    
    init(desc: String, pr: Double) {
        description = desc
        price = pr
    }
}
