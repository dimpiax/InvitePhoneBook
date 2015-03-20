//
//  InviteViewControllerDelegate.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

protocol InviteViewControllerDelegate: class {
    func dataDidDefine(value: [PBRecord]?)
}