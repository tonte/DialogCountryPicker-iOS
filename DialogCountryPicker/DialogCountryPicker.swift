//
//  PopupCountryPicker.swift
//  PopupCountryPicker
//
//  Created by Tonte Owuso on 7/12/19.
//  Copyright © 2019 Tonte. All rights reserved.
//
import UIKit

open class DialogCountryPicker{
    
    public init() {
    }
    public func display(delegate:DialogCountryPickerDelegate, viewControllerToPresentOn:UIViewController,showDialCode:Bool = true){
         let bundle = Bundle(for: DialogCountryPickerView.classForCoder())
        guard let vc = UIStoryboard(name: "Main", bundle: bundle).instantiateInitialViewController() as? DialogCountryPickerView else {
            return
        }
        vc.setup(delegate: delegate)
        vc.showDialCode = showDialCode
        viewControllerToPresentOn.present(vc, animated: true, completion: nil)
    }
    
    
}
