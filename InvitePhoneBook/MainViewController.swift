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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._inviteShowButton = UIButton.buttonWithType(.System) as UIButton
        _inviteShowButton.setTitle("Open invite book", forState: .Normal)
        _inviteShowButton.sizeToFit()
        _inviteShowButton.addTarget(self, action: "inviteShowButtonDidTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(_inviteShowButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _inviteShowButton.center = view.center
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
    }
}