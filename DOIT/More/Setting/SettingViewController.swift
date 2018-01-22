//
//  SettingViewController.swift
//  DOIT
//
//  Created by pow on 2018/1/16.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDataSource ,UITableViewDelegate{
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "设置"

         self.navigationController?.navigationBar.tintColor = MAINREDCOLOR
        
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return  tableView.dequeueReusableCell(withIdentifier: "NotOpenCell")!
        }
        
        return UITableViewCell()
        
    }
    @IBAction func switchUploadEvents_Action(_ sender: UISwitch) {
        
        
        print("关闭上传")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
