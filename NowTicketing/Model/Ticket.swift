//
//  Ticket.swift
//  NowTicketing
//
//  Created by Maria Yu on 12/14/17.
//  Copyright © 2017 Maria Yu. All rights reserved.
//

import Foundation

class Ticket {
    var type: String?
    var subtext: String?
    var fares: [Fare]?
    
    init(tpe: String, text: String, fareAry: [Fare]) {
        type = tpe
        subtext = text
        fares = fareAry
    }
}
