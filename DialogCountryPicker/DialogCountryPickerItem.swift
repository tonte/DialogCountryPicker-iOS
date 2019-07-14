//
//  CountryPickerItem.swift
//  Payplux
//
//  Created by Tonte Owuso on 5/22/19.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
class DialogCountryPickerItem:NSObject{
    @objc var name:String = ""
    var flag:String = ""
    @objc var dialCode:String = ""
    var countryCode:String = ""
    
    init(name:String,flag:String,dialCode:String,countryCode:String) {
        self.name = name
        self.flag = flag
        self.dialCode = dialCode
        self.countryCode = countryCode
    }
}
