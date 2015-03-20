//
//  OrderedListGenerator.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class OrderedListGenerator<T: CellDataProtocol>: ListGeneratorProtocol {
    typealias Item = T
    
    private var _list: [[T]]?
    private var _titles: [String]?
    
    var data: [[T]]? {
        return _list
    }
    
    var titles: [String]? {
        return _titles
    }
    
    var sections: Int? {
        return _list?.count
    }
    
    init() {
        // Empty
    }
    
    func generate(data: [T]?) {
        if data == nil { return }
        
        var keyDict: [String: Int] = [:]
        for value in data! {
            var index = keyDict.count
            
            // find section key
            let c = value.idLetter
            var finded = false
            for (key, value) in keyDict {
                if c == key {
                    index = value
                    finded = true
                    break
                }
            }
            if !finded {
                keyDict[c] = index
            }
        }
        
        _titles = sorted(keyDict) { $0.0 < $1.0 }.map { $0.0 }
        appendFindedValue(&_titles!, value: "#")
        _list = generateListRelatedToKeys(_titles!, data: data!)
    }
    
    private func appendFindedValue<T: Equatable>(inout arr: [T], value: T) -> Bool {
        if let index = find(arr, value) {
            arr.append(arr.removeAtIndex(index))
            return true
        }
        return false
    }
    
    private func generateListRelatedToKeys(value: [String], data: [T]) -> [[T]] {
        var list = [[T]]()
        var tempData = data
        var tempTitles = _titles!.reverse()
        var length = tempTitles.count
        while length-- > 0 {
            let value = tempTitles[length]
            tempTitles.removeAtIndex(length)
            
            var arr: [T] = []
            var length = tempData.count
            while length-- > 0 {
                let element = tempData[length]
                
                if element.idLetter == value {
                    arr.append(element)
                    tempData.removeAtIndex(length)
                }
            }
            list.append(arr)
        }
        return list
    }
}