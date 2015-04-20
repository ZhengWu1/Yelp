//
//  SwitchCell.swift
//  Yelp
//
//  Created by Zheng Wu on 4/17/15.
//  Copyright (c) 2015 Zheng Wu. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell(switchCell:SwitchCell, didChangeValue value:Bool);
}

class SwitchCell: UITableViewCell {

    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    var delegate:SwitchCellDelegate?
    var on: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchFlipped(sender: UISwitch) {
        delegate?.switchCell(self, didChangeValue: sender.on)
    }
    
    func setOn(onVal: Bool) {
        self.setOn(onVal, animated: false)
    }
    
    func setOn(onVal: Bool, animated: Bool) {
        on = onVal
        self.settingSwitch.setOn(onVal, animated: animated)
    }
}
