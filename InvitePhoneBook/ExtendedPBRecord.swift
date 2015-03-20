//
//  ExtendedPBRecord.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class ExtendedPBRecord: PBRecord {
    var selected = false
    
    override var description: String {
        return !firstName.isEmpty ? firstName : "[ExtendedPBRecord self]"
    }
    
    override init(value: ABRecord, name: String, lastname: String) {
        super.init(value: value, name: name, lastname: lastname)
    }
}