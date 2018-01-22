//
//  WPEventTabelView.swift
//  DOIT
//
//  Created by WANG on 2018/1/13.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPEventTabelView: UIView ,UITableViewDataSource,UITableViewDelegate{

    
    var eventsDataSourcue:[EventsModel] = Array()
    
    lazy var tabelView:UITableView = {
        let table:UITableView = UITableView.init(frame:self.bounds)
        table.register(UINib.init(nibName: "WPEventsCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.rowHeight = 52
        let ref:UIRefreshControl = UIRefreshControl.init()
        let select:Selector = NSSelectorFromString("refreshData:")
        ref.addTarget(MainViewController(), action:select, for: .valueChanged)
        ref.attributedTitle = NSAttributedString.init(string: "正在加载")
        ref.tintColor = MAINREDCOLOR
        table.addSubview(ref)
        self.addSubview(table)
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tabelView.dataSource = self
        self.tabelView.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.eventsDataSourcue.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:WPEventsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WPEventsCell
       cell.loadDataForModel(model: self.eventsDataSourcue[indexPath.row])
        return cell
        
    }
  
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        WPRequest.shared.post(requestInterface: .RemoveEvents, data: self.eventsDataSourcue[indexPath.row]) { (value) in
         
            if (value as! String).isEqual("OK") {
                self.eventsDataSourcue.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .middle)
                }
            }
        }
        
    }
    
   
    
}

