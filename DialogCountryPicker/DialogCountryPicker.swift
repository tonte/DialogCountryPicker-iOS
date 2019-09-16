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
        guard let resourcePath = Bundle(for: DialogCountryPickerView.classForCoder()).path(forResource: "Resources", ofType: "bundle"),
            let bundle = Bundle(path: resourcePath) else {
                return
        }
        guard let vc = UIStoryboard(name: "Main", bundle: bundle).instantiateInitialViewController() as? DialogCountryPickerView else {
            return
        }
        vc.setup(delegate: delegate)
        vc.showDialCode = showDialCode
        viewControllerToPresentOn.present(vc, animated: true, completion: nil)
    }
    
    
}
