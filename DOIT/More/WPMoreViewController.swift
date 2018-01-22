//
//  WPMoreViewController.swift
//  DOIT
//
//  Created by pow on 2018/1/16.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPMoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var dateTitleLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.dateTitleLable.text = Date().getCurrentDate() + "  " + Date().getCurrentWeek()
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 2
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  indexPath.section == 0{
            let cell:CustomStoryBoardCell = tableView.dequeueReusableCell(withIdentifier: "UserCell")! as! CustomStoryBoardCell
            cell.moreUserNameLabel.text = UserDefaults.standard.value(forKey: UserDefaults_KEY.UserName.rawValue) as? String
          return cell
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                return tableView.dequeueReusableCell(withIdentifier: "SettingCell")!

            }else{
                return tableView.dequeueReusableCell(withIdentifier: "SwitchFlowCell")!

            }
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 45
        }else if indexPath.section == 1 {
            return 45
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            let stroyboard:UIStoryboard = UIStoryboard.init(name: "User", bundle:nil)
            let settingVC:UIViewController = stroyboard.instantiateViewController(withIdentifier: "UserID")
            self.navigationController?.pushViewController(settingVC, animated: true)
            
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let stroyboard:UIStoryboard = UIStoryboard.init(name: "Setting", bundle:nil)
                let settingVC:UIViewController = stroyboard.instantiateViewController(withIdentifier: "SettingID")
                self.navigationController?.pushViewController(settingVC, animated: true)
                
            }
           
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
           return "资料"
        }else if  section == 1 {
            return "配置"
        }
        return ""
        
    }
}
