//
//  Address.swift
//  addressBook
//
//  Created by Himanshu Mehta on 2020-06-16.
//  Copyright © 2020 Himanshu Mehta. All rights reserved.
//

import Foundation

class Address {
    var first: String
    var last: String
    var email: String
    var phone: Double
    
    init(first: String, last: String, email: String, phone: Double) {
        self.first = first
        self.last = last
        self.email = email
        self.phone = phone
    }
}
