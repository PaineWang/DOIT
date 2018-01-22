//
//  MainViewController.swift
//  DOIT
//
//  Created by WANG on 2018/1/12.
//  Copyright © 2018年 WANG. All rights reserved.

import UIKit


class WPNavigationController: UINavigationController {
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.navigationBar.tintColor = MAINREDCOLOR
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class MainViewController: UIViewController,UICollectionViewDelegate,UITableViewDelegate {

    var mainCollectionView:WPCollectionView?
    
    var eventsTableView:WPEventTabelView?
   
    var currentDay:String = "今天"
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = MAINREDCOLOR
        loadWarningTitle()
        createCollectionView()
        createEventsTableView()
    }
      func loadWarningTitle() {
       
        let warning:WPWarningView = WPWarningView.loadWarningTitleView()
        warning.frame = CGRect.init(x: 0, y:20, width: UIScreen.main.bounds.size.width, height:45)
        self.view.addSubview(warning)
        WPRequest.shared.get(requestInterface:.GetDateInfo, data:EventsModel()) { (vlaue:Array) in

            DispatchQueue.main.async {
                 warning.updateWarningValue(vlaue[0] as! [String:Any])
            }
            
           
            


        }
        
    }
    func createCollectionView() {
        self.mainCollectionView = WPCollectionView(datasource:["今天","明天","后天"])
        self.mainCollectionView?.collectionView?.delegate = self
        self.view.addSubview(self.mainCollectionView!)
        
    }
    
    
    func createEventsTableView() {
        let rect:CGRect = CGRect.init(x: 0, y:UIScreen.main.bounds.size.height/3+65, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 240)
        eventsTableView = WPEventTabelView.init(frame: rect)
        eventsTableView?.tabelView.delegate = self
        self.view.addSubview(eventsTableView!)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.currentDay = (cell as! WPCollectionViewCell).eventsTitleLabel.text!
        let model:EventsModel = EventsModel()
        model.eventsDay = self.currentDay
        WPRequest.shared.get(requestInterface:.GetEventList, data:model) { (value:Array) in
            
            self.eventsTableView?.eventsDataSourcue.removeAll()
            let values:Array = value
            if values.count != 0 {
                for dict:[String:Any] in values as! [[String:Any]] {
                    self.eventsTableView?.eventsDataSourcue.append(EventsModel.dataToModel(dict))
                }
            }
            DispatchQueue.main.async {
                self.eventsTableView?.tabelView.reloadData()
            }
            
        }
    }
    @objc func refreshData(_ refesh:UIRefreshControl){
        let model:EventsModel = EventsModel()
        model.eventsDay = self.currentDay
        WPRequest.shared.get(requestInterface: .GetEventList, data:model) { (value) in
            DispatchQueue.main.async {
                refesh.endRefreshing()
            }
            self.eventsTableView?.eventsDataSourcue.removeAll()
            let values:Array = value
            if values.count != 0 {
                for dict:[String:Any] in values as! [[String:Any]] {
                    self.eventsTableView?.eventsDataSourcue.append(EventsModel.dataToModel(dict))
                }
            }
            DispatchQueue.main.async {
                self.eventsTableView?.tabelView.reloadData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let stroyboard:UIStoryboard = UIStoryboard.init(name: "Events", bundle:nil)
        let eventVC:EventsViewController = stroyboard.instantiateViewController(withIdentifier: "EventsID") as! EventsViewController
        let navi:WPNavigationController = WPNavigationController.init(rootViewController: eventVC)
        let cell:WPCollectionViewCell = collectionView.cellForItem(at: indexPath) as! WPCollectionViewCell
        eventVC.eventsDetailsModel.eventsDay = cell.eventsTitleLabel.text!
        eventVC.eventsDetailsModel.eventsDaydate = Date().getCurrentDate()
         self.present(navi, animated:true, completion: nil)
        
       
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let stroyboard:UIStoryboard = UIStoryboard.init(name: "Events", bundle:nil)
        let eventVC:EventsViewController = stroyboard.instantiateViewController(withIdentifier: "EventsID") as! EventsViewController
        let cell:WPEventsCell = tableView.cellForRow(at: indexPath) as! WPEventsCell
        eventVC.eventsDetailsModel = cell.cellModel!
        self.navigationController?.pushViewController(eventVC, animated: true)
    }
    
}

