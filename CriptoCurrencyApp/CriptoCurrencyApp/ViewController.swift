//
//  ViewController.swift
//  CriptoCurrencyApp
//
//  Created by Shivam Ghai on 2020-03-13.
//  Copyright © 2020 Shivam Ghai. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var countryCode: UIPickerView!
    var downloader = Downloader()
    var result : Double!
    
    @IBOutlet weak var lblating: UILabel!
    let currencyArray = ["JPY", "CNY", "SDG", "RON", "MKD", "MXN", "CAD",
    "ZAR", "AUD", "NOK", "ILS", "ISK", "SYP", "LYD", "UYU", "YER", "CSD",
    "EEK", "THB", "IDR", "LBP", "AED", "BOB", "QAR", "BHD", "HNL", "HRK",
    "COP", "ALL", "DKK", "MYR", "SEK", "RSD", "BGN", "DOP", "KRW", "LVL",
    "VEF", "CZK", "TND", "KWD", "VND", "JOD", "NZD", "PAB", "CLP", "PEN",
    "GBP", "DZD", "CHF", "RUB", "UAH", "ARS", "SAR", "EGP", "INR", "PYG",
    "TWD", "TRY", "BAM", "OMR", "SGD", "MAD", "BYR", "NIO", "HKD", "LTL",
    "SKK", "GTQ", "BRL", "EUR", "HUF", "IQD", "CRC", "PHP", "SVC", "PLN",
    "USD"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let currCode=currencyArray[row]
        
        downloader.download(text: currCode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryCode.dataSource=self
        countryCode.delegate=self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTheTable), name: Notification.Name("WepAPIIsReady"), object: nil)
        
        let currCode=currencyArray[0]
        
        downloader.download(text: currCode) //for by default selecting the first item
        
        #selector(reloadTheTable)
    }
    
    @objc func reloadTheTable()  {
        
    result = downloader.results
        lblating.text="\(result!)"
    }

}

