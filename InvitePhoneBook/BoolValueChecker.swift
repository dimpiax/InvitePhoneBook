//
//  BoolValueChecker.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class BoolValueChecker {
    private var _prevValue: Bool?
    private var _f: (() -> Bool)!
    
    init(f: () -> Bool) {
        _f = f
    }
    
    func isChange(callback: (value: Bool) -> Void) {
        let value = _f()
        if _prevValue != nil && value == _prevValue { return }
        _prevValue = value
        
        callback(value: value)
    }
    
    func reset() {
        _prevValue = nil
    }
    
    deinit {
        _f = nil
    }
}