//
//  PhoneBookViewController.swift
//  InvitePhoneBook
//
//  Created by Pilipenko Dima on 3/20/15.
//  Copyright (c) 2015 dimpiax. All rights reserved.
//

import Foundation
import UIKit

class PhoneBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var model: PhoneBookModel!
    
    var delegate: PhoneBookViewControllerDelegate?
    
    private var _tableView: UITableView!
    private var _data: TableData<ExtendedPBRecord, OrderedListGenerator<ExtendedPBRecord>>?
    private var _configuration: TableViewConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._tableView = UITableView(frame: CGRectZero, style: .Plain)
        _tableView.registerClass(UIInviteTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        _tableView.backgroundColor = UIColor(white: 0.92, alpha: 1)
        _tableView.sectionHeaderHeight = 22
        _tableView.rowHeight = 44
        
        _tableView.sectionIndexTrackingBackgroundColor = UIColor(white: 0.9, alpha: 1)
        _tableView.sectionIndexColor = UIColor(red: 0.55, green: 0.61, blue: 0.87, alpha: 1)
        _tableView.sectionIndexBackgroundColor = _tableView.backgroundColor
        
        _tableView.dataSource = self
        _tableView.delegate = self
        view.addSubview(_tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let records = model.getRecords(didRecordsPrepared)
        if records != nil {
            didRecordsPrepared(records)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        _tableView.frame = view.bounds
    }
    
    // *** METHODS
    // * FUNCTIONS
    func setConfiguration(value: TableViewConfiguration) {
        _configuration = value
    }
    
    private func didRecordsPrepared(records: [PBRecord]?) {
        if records == nil {
            _data = nil
        }
        else {
            let phoneRecords = records!.filter { $0.phones != nil && !$0.phones!.isEmpty }
            
            let g = OrderedListGenerator<ExtendedPBRecord>()
            _data = TableData<ExtendedPBRecord, OrderedListGenerator<ExtendedPBRecord>>(generator: g)
            for value in phoneRecords {
                _data!.addItem(ExtendedPBRecord(value: value.rawValue, name: value.firstName, lastname: value.lastName))
            }
            _data!.generateList()
        }
        _tableView.reloadData()
    }
    
    // * PROTOCOLS
    // UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UIInviteTableViewCell
        cell.check = _data?.getItem(indexPath)?.selected ?? false
        cell.textLabel!.text = _data?.getItem(indexPath)?.title ?? "no data for index: \(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _data?.getRowsInSection(section) ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _data?.sections ?? 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _data?.getTitleForHeaderInSection(section)
    }
    
    // UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        view.contentView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        
        let labelOffset: CGFloat = 14
        let label = UILabel(frame: CGRectMake(labelOffset, 0, CGRectGetWidth(tableView.bounds)-labelOffset, tableView.sectionHeaderHeight))
        label.font = _configuration?.sectionFont ?? UIFont(name: "HelveticaNeue", size: 15)!
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        view.contentView.addSubview(label)
        
        view.textLabel.hidden = true
        
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let data = _data {
            let value = data.getItem(indexPath)!
            data.getItem(indexPath)!.selected = !value.selected
            
            delegate?.cellDidSelected(value)
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: value.selected ? .Bottom : .Top)
        }
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [AnyObject]! {
        return _data?.getSectionIndexTitlesForTableView()
    }
}