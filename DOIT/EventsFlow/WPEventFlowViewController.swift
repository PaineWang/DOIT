//
//  WPEventFlowViewController.swift
//  DOIT
//
//  Created by pow on 2018/1/16.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPEventFlowViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var flowTableView: UITableView!
    var eventFlowData:[EventsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateTitleLabel.text = Date().getCurrentDate() + "  " + Date().getCurrentWeek()
        
        self.title = "事件流"
        loadFlowTableView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        let model:EventsModel = EventsModel()
        model.eventsDay = "今天"
        model.userID = ""
        model.eventsDaydate = ""
        WPRequest.shared.get(requestInterface: .GetEventList, data:model) { (value:Array) in
            
            self.eventFlowData.removeAll()
            let values:Array = value
            if values.count != 0 {
                for dict:[String:Any] in values as! [[String:Any]] {
                    self.eventFlowData.append(EventsModel.dataToModel(dict))
                }
            }
            DispatchQueue.main.async {
                self.flowTableView.reloadData()
            }
            
        }
        
        
    }
    func loadFlowTableView(){
       
        flowTableView.register(UINib.init(nibName: "WPEventFlowCell", bundle: nil), forCellReuseIdentifier: "cell")
        flowTableView.rowHeight = 210
     
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventFlowData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:WPEventFlowCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! WPEventFlowCell
        cell.selectionStyle = .none
        cell.loadDataToCell(self.eventFlowData[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stroyboard:UIStoryboard = UIStoryboard.init(name: "Events", bundle:nil)
        let eventVC:UIViewController = stroyboard.instantiateViewController(withIdentifier: "EventsID")
        self.navigationController?.pushViewController(eventVC, animated: true)
     
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
