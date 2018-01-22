//
//  WPPopWindow.swift
//  DOIT
//
//  Created by WANG on 2018/1/14.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit
typealias blockString = (String)->Void
enum WindowType:String {
    case dataPicker
    case listView
    case textView
}

class WPPopWindow: UIViewController,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    
    
    
    var valueBlackForBlock:blockString?
    var repeatDataSource:[(String,Bool)] = [("星期一",false),
                                          ("星期二",false),
                                          ("星期三",false),
                                          ("星期四",false),
                                          ("星期五",false),
                                          ("星期六",false),
                                          ("星期天",false)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    init(type:WindowType,sourceView:UIView,currentValue:String?) {
      super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.sourceView = sourceView
        self.popoverPresentationController?.sourceRect = CGRect.init(x:50, y:sourceView.bounds.size.height/2, width: 10, height: 10)
        self.popoverPresentationController?.delegate = self
        self.popoverPresentationController?.permittedArrowDirections = .left
        if type == .dataPicker  {
            self.preferredContentSize = CGSize.init(width: UIScreen.main.bounds.size.width - 80, height:UIScreen.main.bounds.size.height/3)
            let datePicker:UIDatePicker = UIDatePicker.init(frame:CGRect.init(x: 0, y: 0, width: self.preferredContentSize.width, height: self.preferredContentSize.height))
            datePicker.datePickerMode = .time
            datePicker.setValue(MAINREDCOLOR, forKeyPath: "textColor")
            datePicker.addTarget(self, action: #selector(datePicker_ValueChange(_ :)), for: .valueChanged)
            self.view.addSubview(datePicker)
        }else if type == .listView {
            self.preferredContentSize = CGSize.init(width: UIScreen.main.bounds.size.width - 80, height:UIScreen.main.bounds.size.height/3)
            let repeatlistView:UITableView = UITableView.init(frame: CGRect.init(origin: CGPoint.zero, size: self.preferredContentSize))
            repeatlistView.delegate = self
            repeatlistView.dataSource = self
            repeatlistView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            self.view.addSubview(repeatlistView)
        }else{
            self.preferredContentSize = CGSize.init(width: UIScreen.main.bounds.size.width - 80, height:UIScreen.main.bounds.size.height/2)
            let textView:UITextView = UITextView.init(frame: CGRect.init(origin: CGPoint.zero, size: self.preferredContentSize))
            textView.font = UIFont.boldSystemFont(ofSize: 13)
            textView.delegate = self
            textView.text = currentValue
            textView.textColor = MAINREDCOLOR
            self.view.addSubview(textView)
            
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repeatDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let indexValue:(String,Bool) = self.repeatDataSource[indexPath.row]
        cell.accessoryType = indexValue.1 ? .checkmark : .none
        cell.textLabel?.text = indexValue.0
        cell.textLabel?.textColor = MAINREDCOLOR
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        cell.tintColor = MAINREDCOLOR
        cell.selectionStyle = .none
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        
        if selectCell.accessoryType == .checkmark {
            self.repeatDataSource[indexPath.row].1 = false
            selectCell.accessoryType = .none
            self.valueBlackForBlock!((selectCell.textLabel?.text!)!)
        }else{
            self.repeatDataSource[indexPath.row].1 = true
             selectCell.accessoryType = .checkmark
            self.valueBlackForBlock!((selectCell.textLabel?.text!)!)
        }
    }
    
    @objc func datePicker_ValueChange(_ sender:UIDatePicker) {
        let dateFrametr:DateFormatter = DateFormatter()
        dateFrametr.dateFormat = "HH:mm"
        let timeString:String = dateFrametr.string(from: sender.date)
        self.valueBlackForBlock!(timeString)
        
    }
    func textViewDidChange(_ textView: UITextView) {
        
      self.valueBlackForBlock!(textView.text)
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  


}
class WeekCell: UICollectionViewCell {
    
    var textLabel:UILabel = UILabel()
    
    
    func load(text:String) {
        textLabel = UILabel.init(frame: self.bounds)
        textLabel.text = text
        textLabel.textColor = UIColor.white
        textLabel.font = UIFont.boldSystemFont(ofSize: 15)
        textLabel.backgroundColor = MAINREDCOLOR
        textLabel.textAlignment = .center
        self.addSubview(textLabel)
        
    }
  
    
}
