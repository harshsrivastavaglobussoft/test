//
//  PriceTableViewCell.swift
//  DropDownMenu
//
//  Created by Sumit Ghosh on 05/12/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit
protocol UpdateMaxPrice{
    func  updateMaxPrice(maxValue:String) -> Void
}
class PriceTableViewCell: UITableViewCell {
    var delegate:UpdateMaxPrice?
    @IBOutlet var Slider: UISlider!
    
    @IBOutlet var minValue: UILabel!
    @IBOutlet var maxValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func sliderAction(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        maxValue.text = "\(currentValue)"
        
        self.delegate?.updateMaxPrice(maxValue: maxValue.text!)
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
