//
//  WPEventsCell.swift
//  DOIT
//
//  Created by WANG on 2018/1/14.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPEventsCell: UITableViewCell{
    
    
   
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UITextField!
    var cellModel:EventsModel?
    
    func loadDataForModel(model:EventsModel) {
        self.cellModel = model
        self.eventNameLabel.text = model.eventsName
        self.timeLabel.text = model.eventTime
       
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
}



