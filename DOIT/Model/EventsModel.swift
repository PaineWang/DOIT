//
//  EventsModel.swift
//  DOIT
//
//  Created by WANG on 2018/1/12.
//  Copyright © 2018年 WANG. All rights reserved.
//

import Foundation
import UIKit


enum UserDefaults_KEY:String {
    case UserID
    case UserName
    case UserImg
    case DeviceID
    case closeFlow
    case isOpen
    
}


class EventsModel: NSObject {
  
    var eventsDate:String = ""  // date of events
    
    var eventsRemarks:String = "" // details of events
    
    var eventsRepeat:String = ""
    
    var eventsFinishCount:String = ""
    
    var eventsName:String = ""
  
    var eventsID:String = ""
    
    var eventsDay:String = ""
    
    var eventsDaydate:String = ""
    
    var userID:String = UserDefaults.standard.value(forKey:UserDefaults_KEY.UserID.rawValue) == nil ? "" :UserDefaults.standard.value(forKey: UserDefaults_KEY.UserID.rawValue) as! String
    
    var deviceID:String = (UIDevice.current.identifierForVendor?.uuidString)!
    
    var userName:String = UserDefaults.standard.value(forKey:UserDefaults_KEY.UserName.rawValue) == nil ? "" : UserDefaults.standard.value(forKey: UserDefaults_KEY.UserName.rawValue) as! String
    
    var eventTime:String = ""
    
    var eventWeek:String = ""
    
    var eventOwnerID:String = ""
    
    var isOpen:String = "0"
    
    var eventsAddress:String = ""
    
    
  
    
    
    
    
    
    static func dataToModel(_ dictionary:[String:Any]) -> EventsModel {
       
        let model:EventsModel = EventsModel()
        model.eventsRemarks = (dictionary["EventsRemark"] as? String)!
        model.eventsName = (dictionary["EventsName"] as? String)!
        model.eventTime = (dictionary["EventsTime"] as? String)!
        model.eventsRepeat = (dictionary["EventsRepeat"] as? String)!
        model.eventsID = "\(dictionary["EventsId"] as! Int)"
        return model
    }
}

