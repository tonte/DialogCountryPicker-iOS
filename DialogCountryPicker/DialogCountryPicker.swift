//
//  PopupCountryPicker.swift
//  PopupCountryPicker
//
//  Created by Tonte Owuso on 7/12/19.
//  Copyright © 2019 Tonte. All rights reserved.
//
import UIKit
public protocol DialogCountryPickerDelegate:class {
    func didSelectCountry(name:String,dialCode:String,countryCode:String)
}

open class DialogCountryPicker:UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countryTableView: UITableView!
    var countries:[DialogCountryPickerItem] = []
    var filteredCountries:[DialogCountryPickerItem] = []
    open weak var delegate: DialogCountryPickerDelegate?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupCountries()
        setupDelegates()
        
    }
    func setupDelegates(){
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.reloadData()
    }
    func setupCountries(){
        let locale = Locale.current
        let CallingCodes = { () -> [[String: String]] in
            let resourceBundle = Bundle(for: DialogCountryPicker.classForCoder())
            guard let path = resourceBundle.path(forResource: "CallingCodes", ofType: "plist") else { return [] }
            return NSArray(contentsOfFile: path) as! [[String: String]]
        }()
        for countryCode in Locale.isoRegionCodes {
                let displayName = (locale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
                let countryData = CallingCodes.filter { $0["code"] == countryCode }
                if countryData.count > 0, let dialCode = countryData[0]["dial_code"] {
                    let country = DialogCountryPickerItem(name: displayName!, flag: countryCode.lowercased(), dialCode: dialCode, countryCode: countryCode)
                    countries.append(country)
                }
            }
        filteredCountries = countries
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        filterText(searchText: sender.text!)
    }
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCountries.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cellNib = Bundle.main.loadNibNamed("customCells", owner: nil, options: nil) else {return UITableViewCell()}
        guard let cell = cellNib[5] as? DialogCountryPickerTableViewCell else {return UITableViewCell()}
        let country = filteredCountries[index]
        cell.setup(flag: country.flag, name: country.name, dialCode: country.dialCode)
        return cell
    }
    func filterText(searchText: String){
        let searchResults = countries
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchText.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            var searchItemsPredicate = [NSPredicate]()
            let titleExpression = NSExpression(forKeyPath: "name")
            let searchStringExpression = NSExpression(forConstantValue: searchString)
            let titleSearchComparisonPredicate = NSComparisonPredicate(leftExpression: titleExpression, rightExpression: searchStringExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
            searchItemsPredicate.append(titleSearchComparisonPredicate)
            
            let serviceNameExpression = NSExpression(forKeyPath: "dialCode")
            let serviceNameSearchComparisonPredicate = NSComparisonPredicate(leftExpression: serviceNameExpression, rightExpression: searchStringExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
            searchItemsPredicate.append(serviceNameSearchComparisonPredicate)
            
            let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
            return orMatchPredicate
        }
        // Match up the fields of the Product object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        if strippedString.isEmpty == false{
            filteredCountries = filteredResults
            countryTableView.allowsSelection = true
        }
        else{
            filteredCountries = countries
            countryTableView.allowsSelection = true
        }
        countryTableView.reloadData()
    }
    
    
    private func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedCountryItem = filteredCountries[indexPath.row]
        delegate?.didSelectCountry(name: selectedCountryItem.name, dialCode: selectedCountryItem.dialCode, countryCode: selectedCountryItem.countryCode)
        self.dismiss(animated: true, completion: nil)
        return nil
    }
    
    
    
    
}
