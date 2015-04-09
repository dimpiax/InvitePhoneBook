//
//  PhoneBookModel.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class PhoneBookModel {
    private var _addressBook: AddressBook!
    
    private var _records: [PBRecord]?
    
    var isRequested: Bool {
        return _addressBook != nil
    }
    
    func requestBook(completion: Bool -> Void) {
        switch ABAddressBookGetAuthorizationStatus() {
            case .Authorized, .NotDetermined:
                _addressBook = AddressBook()
                completion(true)
                
            case .Restricted, .Denied:
                completion(false)
        }
    }
    
    func getRecords(completeCallback: (records: [PBRecord]?) -> Void) -> [PBRecord]? {
        if _records == nil {
            refreshRecords {[weak self] value in
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    completeCallback(records: self!._records)
                }
            }
        }
        return _records
    }
    
    func refreshRecords(completeCallback: Bool -> Void) {
        _records = nil
        
        if !isRequested {
            completeCallback(false)
            return
        }
        
        _addressBook.requestRecords {[weak self] (array, error) in
            if array != nil {
                if let data = array as? [ABRecordHolder] {
                    self!.wrapRecords(data)
                    completeCallback(true)
                }
            }
            else {
                println("requestRecords error: \(error.localizedDescription)")
                completeCallback(false)
            }
        }
    }
    
    private func wrapRecords(records: [ABRecordHolder]) {
        _records = []
        for value in records {
            _records!.append(PBRecord(value: value.rawData, name: value.name, lastname: value.lastname))
        }
    }
}