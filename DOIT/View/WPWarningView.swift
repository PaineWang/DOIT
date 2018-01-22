//
//  WPWarningView.swift
//  DOIT
//
//  Created by WANG on 2018/1/13.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPWarningView: UIView {

    
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var monthDayCount: UILabel!
    @IBOutlet weak var yearDayCount: UILabel!
    class func loadWarningTitleView() -> WPWarningView{
    
    let warning:WPWarningView = UINib.init(nibName: "View", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! WPWarningView
    
        return warning
        
    }
    
    func updateWarningValue(_ value:[String:Any]) {
        
        self.yearDayCount.text = value["yearDayCount"] as? String
        self.monthDayCount.text = value["mothDayCount"] as? String
        self.currentMonth.text = Date().getCurrentMonth()
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
