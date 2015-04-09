//
//  PBRecord.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class PBRecord: CellDataProtocol, Printable, Equatable {
    let recordID: ABRecordID
    
    let rawValue: ABRecord
    
    private var _firstName: String!
    private var _lastName: String!
    
    private var _title: String!
    private var _unknownTitle = false
    
    var description: String {
        return !firstName.isEmpty ? firstName : "[PBRecord self]"
    }
    
    var idLetter: String {
        return _unknownTitle ? "#" : String(title[title.startIndex])
    }
    
    var title: String {
        return _title
    }
    
    var firstName: String {
        return _firstName
    }
    
    var lastName: String {
        return _lastName
    }
    
    private var _phones: [(label: String, phone: String)]?
    var phones: [(label: String, phone: String)]? {
        if _phones != nil { return _phones! }
        
        let phonesList: ABMultiValueRef? = ABRecordCopyValue(rawValue, kABPersonPhoneProperty)?.takeRetainedValue()
        if phonesList != nil {
            for i in 0..<ABMultiValueGetCount(phonesList) {
                let multiValueCopy = ABMultiValueCopyLabelAtIndex(phonesList, i)?.takeRetainedValue() as? String
                if multiValueCopy != nil {
                    let label = ABAddressBookCopyLocalizedLabel(multiValueCopy).takeRetainedValue() as! String
                    let phone = ABMultiValueCopyValueAtIndex(phonesList, i).takeRetainedValue() as! String
                    
                    if _phones == nil {
                        _phones = []
                    }
                    _phones!.append((label: label, phone: phone))
                }
            }
        }
        return _phones
    }
    
    var image: UIImage? {
        if ABPersonHasImageData(rawValue) {
            return UIImage(data: ABPersonCopyImageDataWithFormat(rawValue, kABPersonImageFormatThumbnail).takeRetainedValue())
        }
        return nil
    }
    
    init(value: ABRecord) {
        recordID = ABRecordGetRecordID(value)
        rawValue = value
    }
    
    init(value: ABRecord, name: String, lastname: String) {
        recordID = ABRecordGetRecordID(value)
        rawValue = value
        
        _firstName = name
        _lastName = lastname
        
        defineTitle()
    }
    
    private func defineTitle() {
        _unknownTitle = false
        
        var title: String = ""
        if !firstName.isEmpty {
            title += "\(firstName) "
        }
        if !lastName.isEmpty {
            title += "\(lastName) "
        }
        if !title.isEmpty {
            title = title.substringToIndex(advance(title.startIndex, count(title)-1))
        }
        else {
            _unknownTitle = true
            title = phones?[0].phone ?? "Unknown"
        }
        _title = title
    }
}

func ==(lhs: PBRecord, rhs: PBRecord) -> Bool {
    return lhs.recordID == rhs.recordID
}