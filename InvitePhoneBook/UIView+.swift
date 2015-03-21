//
//  UIView+.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/21/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation

extension UIView {
    func setY(value: CGFloat) {
        var finalFrame = frame
        finalFrame.origin.y = value
        frame = finalFrame
    }
}