//
//  ViewController.swift
//  DialogCountryPickerExample
//
//  Created by Tonte Owuso on 7/16/19.
//  Copyright © 2019 Tonte. All rights reserved.
//

import UIKit
import DialogCountryPicker
class ViewController: UIViewController,DialogCountryPickerDelegate {
    @IBOutlet weak var selectedCountryView: UIStackView!
    @IBOutlet weak var countryFlagView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryDialCodeLabel: UILabel!
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func touchMeButtonClicked(_ sender: Any) {
        showPicker()
    }
    
    func didSelectCountry(name: String, dialCode: String, countryCode: String, flag: UIImage) {
        selectedCountryView.isHidden = false
        countryNameLabel.text = name
        countryDialCodeLabel.text = dialCode
        countryFlagView.image = flag
    }
   
    
    func showPicker(){
        let picker = DialogCountryPicker()
        picker.display(delegate: self, viewControllerToPresentOn: self,showDialCode: true)
    }
    
}

