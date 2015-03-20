//
//  TableData.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

class TableData<T: CellDataProtocol, U: ListGeneratorProtocol where U.Item == T> {
    private var _data: [T]?
    private var _listGenerator: U?
    
    var sections: Int {
        return _listGenerator?.sections ?? 1
    }
    
    init(generator: U?) {
        _listGenerator = generator
    }
    
    func addItem(value: T) {
        if _data == nil {
            _data = []
        }
        _data!.append(value)
    }
    
    func generateList() {
        _listGenerator?.generate(_data)
    }
    
    func getItem(indexPath: NSIndexPath) -> T? {
        return _listGenerator?.data?[indexPath.section][indexPath.row] ?? _data?[indexPath.row]
    }
    
    func getRowsInSection(value: Int) -> Int {
        return _listGenerator?.data?[value].count ?? _data?.count ?? 1
    }
    
    func getTitleForHeaderInSection(value: Int) -> String? {
        return _listGenerator?.data?[value][0].idLetter
    }
    
    func getSectionIndexTitlesForTableView() -> [String]? {
        return _listGenerator?.titles?
    }
}