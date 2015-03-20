//
//  InviteModel.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class InviteModel {
    private var _data: [PBRecord]?
    private var _changeChecker: BoolValueChecker?
    
    var data: [PBRecord]? {
        return _data
    }
    
    init() {
        // Empty
    }
    
    func getTitleAttributedString() -> NSAttributedString {
        var attrText = NSMutableAttributedString(string: "invite people\nby phones", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 18)!])
        attrText.setAttributes([NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 27)!], range: NSMakeRange(14, 9))
        
        return attrText.copy() as NSAttributedString
    }
    
    func carry(value: PBRecord) {
        if _data == nil {
            _data = []
        }
        if let index = find(_data!, value) {
            _data!.removeAtIndex(index)
            if _data!.isEmpty {
                _data = nil
            }
        }
        else {
            _data!.append(value)
        }
    }
    
    func listenDataCountChange(callback: Bool -> Void) {
        if _changeChecker == nil {
            _changeChecker = BoolValueChecker(f: { ~?self._data })
        }
        _changeChecker!.isChange(callback)
    }
}

prefix operator ~? {}
prefix func ~?<T>(value: [T]?) -> Bool {
    if value != nil {
        return !value!.isEmpty
    }
    return false
}