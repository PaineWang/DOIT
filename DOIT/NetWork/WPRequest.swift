//
//  WPRequest.swift
//  DOIT
//
//  Created by pow on 2018/1/15.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit
enum RequestInterface:String {
    case AddEvents
    case GetEventList
    case RemoveEvents
    case UpdateEvent
    case GetDateInfo
    case SetNewUser
    case GetEventsFlowList

}

let networkAddress:String = "http://61.129.51.83:8080/NewWeb/"

class WPRequest: NSObject {

    static let shared:WPRequest = WPRequest()
    
    private override init() {
        super.init()
    }
    
//    http://116.62.168.251:8080/NewWeb/GetEventList?EventsName=1&EventsDate=&EventsRepeat=&EventsRemarks=
    func post(requestInterface:RequestInterface,data:EventsModel,responder:@escaping (_ value:Any)->()) {
        
        let urlString:String = networkAddress+requestInterface.rawValue+"?"
        var request:URLRequest = URLRequest.init(url:URL(string: urlString)!)
        var body :String = ""
        if requestInterface == .AddEvents {
            body = "EventsName="+data.eventsName+"&EventsDate="+data.eventsDate+"&EventsRepeat="+data.eventsRepeat+"&EventsRemarks="+data.eventsRemarks+"&EventsDay="+data.eventsDay+"&EventsDaydate="+data.eventsDaydate+"&EventsTime="+data.eventTime+"&EventsWeek"+data.eventWeek+"&userId="+data.userID+"&ownerId="+data.eventOwnerID+"&isOpen="+data.isOpen+"&EventsAddress="+data.eventsAddress
        }else if requestInterface == .RemoveEvents {
            body = "EventsId="+data.eventsID
        }else if requestInterface == .UpdateEvent {
            
        }
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        //响应对象
        //响应对象
        let session:URLSession = URLSession.shared
        let dataTask = session.dataTask(with:request, completionHandler: { (data, resp, err) in
            
            if let data = data {
                let result =  String(data:data, encoding: String.Encoding.utf8)
                responder(result!)
            }else {
                print(err!)
            }
            
            
        })
        dataTask.resume()
    }
    
    func get(requestInterface:RequestInterface,data:EventsModel,responder:@escaping (_ value:Array<Any>)->()) {
        
        let urlString:String = networkAddress+requestInterface.rawValue+"?"
        var request:URLRequest = URLRequest.init(url:URL(string: urlString)!)
        var body :String = ""
        if requestInterface == .GetEventList {
            body = "userId="+data.userID+"&EventsDay="+data.eventsDay+"&EventsDaydate="+data.eventsDaydate
        }else if requestInterface == .GetDateInfo {
            
            body = ""
            
        }else if requestInterface == .SetNewUser {
            body = "deviceId="+data.deviceID
        }
        
        //编码POST数据
        let postData = body.data(using: String.Encoding.utf8)
        //保用 POST 提交
        request.httpMethod = "POST"
        request.httpBody = postData
        //响应对象
        let session:URLSession = URLSession.shared
        let dataTask = session.dataTask(with:request, completionHandler: { (data, resp, err) in
            
        if let data = data {
                
        do {
                    
            let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        
            responder(result as! Array)
            
            }catch let error as NSError {
             
                print(error.code)
            }
                
        }
            
        })
        dataTask.resume()
    }
    
    
}
