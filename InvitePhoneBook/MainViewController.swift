//
//  MainViewController.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController, InviteViewControllerDelegate {
    private var _inviteShowButton: UIButton!
    private var _textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._inviteShowButton = UIButton.buttonWithType(.System) as! UIButton
        _inviteShowButton.setTitle("Open invite book", forState: .Normal)
        _inviteShowButton.sizeToFit()
        _inviteShowButton.addTarget(self, action: "inviteShowButtonDidTapped", forControlEvents: .TouchUpInside)
        
        self._textView = UITextView()
        _textView.textAlignment = .Center
        _textView.font = UIFont(name: "HelveticaNeue", size: 15)
        view.addSubview(_textView)
        
        view.addSubview(_inviteShowButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _inviteShowButton.center = view.center
        _inviteShowButton.setY((CGRectGetHeight(view.bounds)-CGRectGetHeight(_inviteShowButton.bounds))*0.2)
        
        _textView.center = view.center
        _textView.setY((CGRectGetHeight(view.bounds)-CGRectGetHeight(_textView.bounds))*0.5)
    }
    
    // *** METHODS
    // * ACTIONS
    func inviteShowButtonDidTapped() {
        let inviteVC = InviteViewController()
        inviteVC.delegate = self
        presentViewController(inviteVC, animated: true, completion: nil)
    }

    // * PROTOCOLS
    // InviteViewControllerDelegate
    func dataDidDefine(value: [PBRecord]?) {
        let phones = value?.map { $0.phones![0].phone }
        println("selected phones: \(phones)")
        
        var str = ""
        if phones != nil {
            str = "phones:\n\n"+("\n".join(phones!))
        }
        _textView.frame = CGRectMake(0, 0, CGRectGetWidth(view.bounds), 0)
        _textView.text = str
        _textView.sizeToFit()
    }
}