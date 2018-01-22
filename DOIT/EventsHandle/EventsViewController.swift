//
//  EventsViewController.swift
//  DOIT
//
//  Created by WANG on 2018/1/13.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    
    
    var opencellRowCount:CGFloat = 1
    @IBOutlet weak var eventTableView: UITableView!
    var eventsDetailsModel:EventsModel = EventsModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        prepare()
        
    }
    
    func prepare() {
        
        if (self.navigationController?.viewControllers.first?.isMember(of: MainViewController.self))! {
            self.title = "事件详情"
            self.navigationController?.navigationBar.tintColor = MAINREDCOLOR
            
        }else if (self.navigationController?.viewControllers.first?.isMember(of: WPEventFlowViewController.self))! {
            self.title = "事件详情"
            self.navigationController?.navigationBar.tintColor = MAINREDCOLOR
            let eventOwenrButton:UIButton = UIButton.init(frame: CGRect.init(origin:CGPoint.init(x: UIScreen.main.bounds.size.width - 50, y:0), size: CGSize.init(width: 40, height: 40)))
            eventOwenrButton.layer.cornerRadius = 5
            eventOwenrButton.layer.masksToBounds = true
            eventOwenrButton.setBackgroundImage(UIImage.init(named: "userIMG.jpg"), for: .normal)
            eventOwenrButton.addTarget(self, action: #selector(eventOwenrButton_Action(_:)), for: .touchUpInside)
           self.navigationController?.navigationBar.addSubview(eventOwenrButton)
           
            let DOITButton:UIButton = UIButton.init(frame:CGRect.init(x: eventOwenrButton.frame.origin.x - 65, y: 0, width: 60, height: 40))
            DOITButton.setTitle("DOIT", for: .normal)
            DOITButton.setTitleColor(MAINREDCOLOR, for: .normal)
            DOITButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            DOITButton.addTarget(self, action: #selector(doitEvent_Action(_:)), for: .touchUpInside)
            self.navigationController?.navigationBar.addSubview(DOITButton)
            
        }else{
            self.title = "新建事件"
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "撤销", style:.done, target: self, action: #selector(goBack_Action(_:)))
              self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "DOIT", style:.done, target: self, action: #selector(doitEvent_Action(_:)))
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
         self.tabBarController?.tabBar.isHidden = false
    }
}
//MARK: - ACTION -
extension EventsViewController {
    
    @objc func goBack_Action(_ sender: UIBarButtonItem) {
        
        if (self.navigationController?.isMember(of: UINavigationController.self))! {
            self.navigationController?.popViewController(animated: true)
            print("恢复数据")
            
        }else{
            print("清空不记录，不保存数据")
            self.dismiss(animated: true)
        }
    }
    @objc func doitEvent_Action(_ sender:UIButton)  {
        
        
        
        WPRequest.shared.post(requestInterface: .AddEvents, data:self.eventsDetailsModel) { (value) in
           
            if (value as! String).isEqual("OK"){
                
                self.dismiss(animated: true, completion:nil)
                
            }
           
            }
      
        
        
        
    }
    
    @objc func eventOwenrButton_Action(_ sender:UIButton) {
      
        print("查看发起人的信息")
        
        
    }
    
    
    @IBAction func publicEventsSwitvh_Action(_ sender: UISwitch) {
        
        self.opencellRowCount = self.opencellRowCount == 2 ? 1 : 2
        if self.opencellRowCount == 2 {
            WPLocation.shared.start()
                WPLocation.shared.locationBlock = {
                    (value:String) ->Void in
                    self.eventsDetailsModel.eventsAddress = value
                    DispatchQueue.main.async {
                        
                        self.eventTableView.reloadRows(at: [IndexPath.init(row: 1, section: 2)], with: .bottom)
                        
                    }
                }
        }
        self.eventTableView.reloadSections([2], with: .right)
    }
    
    
}
//MARK: - DELEGATE -
extension  EventsViewController {
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        switch cell.reuseIdentifier {
        case "eventDateCell"?:
            let popWindow:WPPopWindow = WPPopWindow.init(type:WindowType.dataPicker, sourceView:cell, currentValue:nil)
            popWindow.valueBlackForBlock = {
                (value:String)->Void in
                cell.detailTextLabel?.text = value
                self.eventsDetailsModel.eventTime = value
                tableView.reloadRows(at: [indexPath], with:.automatic)
            }
            self.present(popWindow, animated: true)
            break
        case "eventRepeatCell"?:
            let popWindow:WPPopWindow = WPPopWindow.init(type:WindowType.listView, sourceView:cell, currentValue:nil)
            popWindow.valueBlackForBlock = {
                (value:String)->Void in
                 var weeks:[String] = []
                for tu:(String,Bool) in popWindow.repeatDataSource {
                    if tu.1 {
                        weeks.append(tu.0)
                    }
                }
                cell.detailTextLabel?.text = weeks.description
                self.eventsDetailsModel.eventsRepeat = weeks.description
                tableView.reloadRows(at: [indexPath], with:.automatic)

            }
            self.present(popWindow, animated: true)
            break
        case "eventRemarkCell"?:
            let popWindow:WPPopWindow = WPPopWindow.init(type:WindowType.textView, sourceView:cell, currentValue:nil)
            popWindow.valueBlackForBlock = {
                (value:String)->Void in
                cell.detailTextLabel?.text = value
                self.eventsDetailsModel.eventsRemarks = value
                tableView.reloadRows(at: [indexPath], with:.automatic)

            }
            self.present(popWindow, animated: true) 
            break
        default: break
            
        }
   
    }
}
//MARK: - DATASOURCE -
extension EventsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
            
        }else if section == 1 {
            return 3
        }else if section == 2 {
            return Int(opencellRowCount)
        }
        
        return 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return 45
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            
            let cell:CustomStoryBoardCell = tableView.dequeueReusableCell(withIdentifier: "eventNameCell")! as! CustomStoryBoardCell
            cell.eventsTitleFiled.text  = self.eventsDetailsModel.eventsName
            cell.cellBlockValue = {
                (value:String) in
                self.eventsDetailsModel.eventsName = value
                
            }
            return cell
            
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier:"eventDateCell")!
                cell.detailTextLabel?.text = self.eventsDetailsModel.eventTime
                return cell
            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier:"eventRepeatCell")!
                cell.detailTextLabel?.text = self.eventsDetailsModel.eventsRepeat
                return cell
             
            }else if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier:"eventRemarkCell")!
                cell.detailTextLabel?.text = self.eventsDetailsModel.eventsRemarks
                return cell
            }
            
        }else if indexPath.section == 2 {
            if indexPath.row == 0 {
                
                let cell:CustomStoryBoardCell = tableView.dequeueReusableCell(withIdentifier: "openCell")! as! CustomStoryBoardCell
                cell.publicSwitch.isOn = self.opencellRowCount == 2 ? true : false
                return cell
            }else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier:"locationCell")!
                 cell.textLabel?.text = self.eventsDetailsModel.eventsAddress
                return cell
                
            }
        }
        
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "标题"
        }else if  section == 1 {
            return "详情"
        }else if  section == 2 {
            return "配置详情"
        }
        return ""
    }
}
