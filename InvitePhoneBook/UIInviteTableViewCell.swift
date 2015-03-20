//
//  UIInviteTableViewCell.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation
import UIKit

class UIInviteTableViewCell: UITableViewCell {
    private var _isChecked = false
    var check: Bool {
        get {
            return _isChecked
        }
        set {
            _isChecked = newValue
            
            accessoryView = UIImageView(image: UIImage(named: newValue ? "checkedIcon" : "uncheckedIcon")!)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        accessoryType = .Checkmark
        
        backgroundColor = UIColor.clearColor()
        
        textLabel!.font = UIFont(name: "Cervo-Thin", size: 18)
        
        check = false
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let xOffset: CGFloat = 15
        accessoryView!.frame = CGRectMake(xOffset, CGRectGetMidY(bounds)-CGRectGetMidY(accessoryView!.bounds), CGRectGetWidth(accessoryView!.bounds), CGRectGetHeight(accessoryView!.bounds))
        
        var textLabelFrame = textLabel!.frame
        textLabelFrame.origin.x = CGRectGetMaxX(accessoryView!.frame)+12
        textLabel!.frame = textLabelFrame
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}