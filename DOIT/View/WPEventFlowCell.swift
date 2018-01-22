//
//  WPEventFlowCell.swift
//  DOIT
//
//  Created by pow on 2018/1/16.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

class WPEventFlowCell: UITableViewCell {

    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventOwnerIcon: UIButton!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDateWeek: UILabel!
    @IBOutlet weak var eventRemarks: UITextView!
    @IBOutlet weak var eventAddress: UILabel!
    @IBOutlet weak var doerCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadDataToCell(_ model:EventsModel)  {
       
        self.eventName.text = model.eventsName
        self.eventTime.text = model.eventTime
        self.eventAddress.text = model.eventsAddress
        self.eventRemarks.text = model.eventsRemarks
        self.eventDateWeek.text = model.eventsDate.appending( model.eventWeek)
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
