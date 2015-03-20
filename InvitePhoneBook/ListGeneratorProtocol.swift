//
//  ListGeneratorProtocol.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

protocol ListGeneratorProtocol {
    typealias Item
    
    var data: [[Item]]? { get }
    var titles: [String]? { get }
    
    var sections: Int? { get }
    
    func generate(data: [Item]?)
}