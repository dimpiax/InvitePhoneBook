//
//  InviteViewController.swift
//  InviteViewController
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation
import UIKit

class InviteViewController: UIViewController, PhoneBookViewControllerDelegate {
    weak var delegate: InviteViewControllerDelegate?
    
    private var _inviteModel: InviteModel!
    
    private var _title: UILabel!
    private var _doneButton: UIButton!
    private var _phoneBookViewController: PhoneBookViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._inviteModel = InviteModel()
        
        view.backgroundColor = UIColor.whiteColor()
        
        // create title
        self._title = UILabel()
        _title.lineBreakMode = .ByWordWrapping
        _title.numberOfLines = 2
        _title.attributedText = _inviteModel.getTitleAttributedString()
        _title.sizeToFit()
        view.addSubview(_title)
        
        // create button of completion
        self._doneButton = UIButton.buttonWithType(.Custom) as UIButton
        _doneButton.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 18)
        _doneButton.setTitle("Send", forState: .Normal)
        _doneButton.setTitleColor(UIColor(red: 0, green: 0.48, blue: 1, alpha: 1), forState: .Normal)
        _doneButton.sizeToFit()
        _doneButton.addTarget(self, action: "doneDidTapped", forControlEvents: .TouchUpInside)
        view.addSubview(_doneButton)
        
        // view controller
        self._phoneBookViewController = PhoneBookViewController()
        _phoneBookViewController.setConfiguration(TableViewConfiguration(sectionFont: UIFont(name: "HelveticaNeue", size: 12)!))
        _phoneBookViewController.model = PhoneBookModel()
        _phoneBookViewController.delegate = self
        
        addChildViewController(_phoneBookViewController)
        view.addSubview(_phoneBookViewController.view)
        
        defineDoneButtonState()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let yOffset = topLayoutGuide.length
        let abYPosition: CGFloat = 80
        
        _title.frame = CGRectMake(20, yOffset+abYPosition/2-CGRectGetHeight(_title.bounds)/2, CGRectGetWidth(_title.bounds), CGRectGetHeight(_title.bounds))
        
        updateDoneButtonPosition(topLayoutGuide.length, height: 80)
        
        _phoneBookViewController.view.frame = CGRectMake(0, yOffset+abYPosition, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)-abYPosition-yOffset)
    }
    
    // *** METHODS
    // * FUNCTIONS    
    private func defineDoneButtonState() {
        _inviteModel.listenDataCountChange { value in
            self._doneButton.setTitle(value ? "Send" : "Cancel", forState: .Normal)
            self._doneButton.sizeToFit()
            self.updateDoneButtonPosition(self.topLayoutGuide.length, height: 80)
        }
    }
    
    private func updateDoneButtonPosition(y: CGFloat, height: CGFloat) {
        _doneButton.frame = CGRectMake(CGRectGetWidth(view.bounds)-CGRectGetWidth(_doneButton.bounds)-20, y+height/2-CGRectGetHeight(_doneButton.bounds)/2, CGRectGetWidth(_doneButton.bounds), CGRectGetHeight(_doneButton.bounds))
    }
    
    // * ACTIONS
    func doneDidTapped() {
        delegate?.dataDidDefine(_inviteModel.data?)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // * PROTOCOLS
    func cellDidSelected(value: PBRecord) {
        _inviteModel.carry(value)
        defineDoneButtonState()
    }
}