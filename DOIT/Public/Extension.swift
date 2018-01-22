//
//  WPDate.swift
//  DOIT
//
//  Created by pow on 2018/1/15.
//  Copyright © 2018年 WANG. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
class CustomStoryBoardCell: UITableViewCell,UITextFieldDelegate {
    
    // 更多界面 用户信息 事件个数
    @IBOutlet weak var moreUserInfoEventsCountLabel: UIButton!
    @IBOutlet weak var publicSwitch: UISwitch!
    
    @IBOutlet weak var moreCloseFlowSwitch: UISwitch!
    
    @IBOutlet weak var moreUserNameLabel: UILabel!
    @IBOutlet weak var moreUserIconButton: UIButton!
    
    @IBOutlet weak var eventsTitleFiled: UITextField!
    
    var cellBlockValue:blockString?
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.cellBlockValue!(textField.text!)
        
        return true
    }
    
}

extension UIColor {
    
   class func getRGB(_ rgb:(CGFloat,CGFloat,CGFloat),A:CGFloat) -> UIColor {
        return UIColor.init(red:rgb.0/255.0, green:rgb.1/255.0 , blue: rgb.2/255.0, alpha: A)
    }
 
}
let BACKGARYCOLOR:UIColor = UIColor.groupTableViewBackground
let MAINREDCOLOR:UIColor = UIColor.getRGB((237, 36, 76), A: 1)
extension Date {
    
    
    
    
    func getCurrentMonth() -> String{
        
        let dateFromter:DateFormatter = DateFormatter()
        dateFromter.dateFormat = "M月"
        let dateString:String = dateFromter.string(from:self)
        return dateString
    }
    
    
    func getCurrentDate() -> String{
        
        let dateFromter:DateFormatter = DateFormatter()
        dateFromter.dateFormat = "M 月 dd 日"
        let dateString:String = dateFromter.string(from:self)
      return dateString
    }
    
    func getCurrentTime() ->String{
        
        let dateFromter:DateFormatter = DateFormatter()
        dateFromter.dateFormat = "HH:mm"
        let dateString:String = dateFromter.string(from:self)
        return dateString
        
    }
    
    func getCurrentWeek() -> String {
        
        let weekDays = [NSNull.init(),"星期日","星期一","星期二","星期三","星期四","星期五","星期六"] as [Any]
       
        var calendar = Calendar.init(identifier: .chinese)
        
        let timeZone = TimeZone.init(identifier: "Asia/Shanghai")
        
        calendar.timeZone = timeZone!
        
        let calendarUnit = Calendar.Component.weekday
        
        let theComponents = calendar.component(calendarUnit, from: self)
     
        return weekDays[theComponents] as! String
  
    }
    
    
}




class WPLocation: NSObject ,CLLocationManagerDelegate{
    
    static let shared:WPLocation = WPLocation()
    
    var locationManager:CLLocationManager = CLLocationManager.init()
    
    var locationBlock:blockString?
    
    
    
    
    private override init() {
        super.init()
    }
    
    func start() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy  = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.startUpdatingLocation()
        }
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loc:CLLocation = locations[0]
        
        stop()
        let gecoder:CLGeocoder = CLGeocoder.init()
        
        gecoder.reverseGeocodeLocation(loc) { (placs, err) in
            if let plac = placs{
                for  mark in plac {
                    self.locationBlock!(mark.thoroughfare!+mark.name!)
                }
            }
            
       
        }
  
    }
  
    
    func stop() {
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    
    
    
}

class AssistViewController: UIViewController {
    
    
    var type:WindowType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
}











