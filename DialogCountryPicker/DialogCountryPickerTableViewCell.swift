//
//  CountryPickerTableViewCell.swift
//  Payplux
//
//  Created by Tonte Owuso on 5/22/19.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class DialogCountryPickerTableViewCell: UITableViewCell {
    @IBOutlet weak var flagView: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var dialCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setup(flag:String,name:String,dialCode:String){
        self.flagView.image = UIImage(named: flag)
        self.countryName.text = name
        self.dialCodeLabel.text = dialCode
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
