//
//  ViewController.swift
//  CryptoActual
//
//  Created by Leandro Meneguel on 6/10/18.
//  Copyright © 2018 Leandro Meneguel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    
    let bitcoinURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let litecoinURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/LTC"
    let ethereumURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETH"
    let zcashURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ZEC"
    let rippleURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XRP"
    let moneroURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XRM"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let currencySymbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    var currencySelected = ""
    
    var finalURL = ""
    
    @IBOutlet weak var bitecoinLabel: UILabel!
    @IBOutlet weak var litecoinLabel: UILabel!
    @IBOutlet weak var ethereumLabel: UILabel!
    @IBOutlet weak var zcashLabel: UILabel!
    @IBOutlet weak var rippleLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    
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
        
        currencySelected = currencySymbolArray[row]
        
        getCryptoCoinData(urlBit: bitcoinURL + currencyArray[row])
        getCryptoCoinDataLite(urlLite: litecoinURL + currencyArray[row])
        getCryptoCoinDataEther(urlEther: ethereumURL + currencyArray[row])
        getCryptoCoinDataZcash(urlZcash: zcashURL + currencyArray[row])
        getCryptoCoinDataRupple(urlRipple: rippleURL + currencyArray[row])
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bitecoinLabel.layer.borderWidth = 1.0
//        bitecoinLabel.layer.cornerRadius = 15
//        bitecoinLabel.layer.masksToBounds = true
//
//        litecoinLabel.layer.borderWidth = 1.0
//        litecoinLabel.layer.cornerRadius = 15
//        litecoinLabel.layer.masksToBounds = true
//
//        ethereumLabel.layer.borderWidth = 1.0
//        ethereumLabel.layer.cornerRadius = 15
//        ethereumLabel.layer.masksToBounds = true
//
//        zcashLabel.layer.borderWidth = 1.0
//        zcashLabel.layer.cornerRadius = 15
//        zcashLabel.layer.masksToBounds = true
//
//        rippleLabel.layer.borderWidth = 1.0
//        rippleLabel.layer.cornerRadius = 15
//        rippleLabel.layer.masksToBounds = true
//
            currencyPicker.delegate = self
            currencyPicker.dataSource = self
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCryptoCoinData(urlBit: String) {
        
        Alamofire.request(urlBit, method: .get).responseJSON { response in if response.result.isSuccess {
            
            let bitcoinJSON : JSON = JSON(response.result.value ?? "")
            
            self.updateBitcoinData(json: bitcoinJSON)
            
        } else {
            print("Error: \(String(describing: response.result.error))")
            self.bitecoinLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func getCryptoCoinDataLite(urlLite: String) {
        
        Alamofire.request(urlLite, method: .get).responseJSON { response in if response.result.isSuccess {
            
            let litecoinJSON: JSON = JSON(response.result.value ?? "")
            
            self.updateLitecoinData(json: litecoinJSON)
            
        } else {
            print("Error: \(String(describing: response.result.error))")
            self.litecoinLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func getCryptoCoinDataEther(urlEther: String) {
        
        Alamofire.request(urlEther, method: .get).responseJSON { response in if response.result.isSuccess {
            
            let ethercoinJSON: JSON = JSON(response.result.value ?? "")
            
            self.updateEthercoinData(json: ethercoinJSON)
            
        } else {
            print("Error: \(String(describing: response.result.error))")
            self.ethereumLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func getCryptoCoinDataZcash(urlZcash: String) {
        
        Alamofire.request(urlZcash, method: .get).responseJSON { response in if response.result.isSuccess {
            
            let zcashcoinJSON : JSON = JSON(response.result.value ?? "")
            
            self.updateZcashcoinData(json: zcashcoinJSON)
            
        } else {
            print("Error: \(String(describing: response.result.error))")
            self.zcashLabel.text = "Connection Issues"
            }
        }
        
    }
    
    func getCryptoCoinDataRupple(urlRipple: String) {
        
        Alamofire.request(urlRipple, method: .get).responseJSON { response in if response.result.isSuccess {
            
            let ripplecoinJSON : JSON = JSON(response.result.value ?? "")
            
            self.updateRipplecoinData(json: ripplecoinJSON)
            
        } else {
            print("Error: \(String(describing: response.result.error))")
            self.rippleLabel.text = "Connection Issues"
            }
        }
        
    }
    
    //##########################################################
    
    func updateBitcoinData(json : JSON) {
        
        if let bitcoinResult = json["ask"].double {
            
            bitecoinLabel.text = currencySelected + String(bitcoinResult)
            
        } else {
            bitecoinLabel.text = "Price unavailable"
        }
        
        if let bitcoinNow = json["ask"].double {
            let bitcoinLast = json["last"].double
            let result = bitcoinNow - bitcoinLast!
            if result > 0 {
                
                bitecoinLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
                
            } else if result < 0 {
                
                bitecoinLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
                
                
            } else {bitecoinLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)}
            
        }
        
    }
    
    func updateLitecoinData(json: JSON) {
        
        if let litecoinResult = json["ask"].double {
            let litecoinResult2 = Double(round(100*litecoinResult)/100)
            litecoinLabel.text = currencySelected + String(litecoinResult2)
            
            
        } else {
            litecoinLabel.text = "Unavailable"
        }
        
        if let litecoinNow = json["ask"].double {
            let litecoinLast = json["last"].double
            let result = litecoinNow - litecoinLast!
            if result > 0 {
                
                litecoinLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
                
            } else if result < 0 {
                
                litecoinLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
                
                
            } else {litecoinLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)}
            
        }
        
    }
    
    func updateEthercoinData(json: JSON) {
        
        if let ethereumResult = json["ask"].double {
            let ethereumResult2 = Double(round(100*ethereumResult)/100)
            ethereumLabel.text = currencySelected + String(ethereumResult2)
            
            
        } else {
            ethereumLabel.text = "Unavailable"
        }
        
        if let ethercoinNow = json["ask"].double {
            let ethercoinLast = json["last"].double
            let result = ethercoinNow - ethercoinLast!
            if result > 0 {
                
                ethereumLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
                
            } else if result < 0 {
                
                ethereumLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
                
                
            } else {ethereumLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)}
            
        }
        
        
        
    }
    
    func updateZcashcoinData(json: JSON) {
        
        if let zcashcoinResult = json["ask"].double {
            let zcashcoinResult2 = Double(round(100*zcashcoinResult)/100)
            zcashLabel.text = currencySelected + String(zcashcoinResult2)
            
            
        } else {
            zcashLabel.text = "Unavailable"
        }
        
        if let zcashcoinNow = json["ask"].double {
            let zcashcoinLast = json["last"].double
            let result = zcashcoinNow - zcashcoinLast!
            if result > 0 {
                
                zcashLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
                
            } else if result < 0 {
                
                zcashLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
                
                
            } else {zcashLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)}
            
        }
        
    }
    
    
    func updateRipplecoinData(json : JSON) {
        
        if let ripplecoinResult = json["ask"].double {
            let ripplecoinResult2 = Double(round(100*ripplecoinResult)/100)
            rippleLabel.text = currencySelected + String(ripplecoinResult2)
            
        } else {
            rippleLabel.text = "Price unavailable"
        }
        
        if let ripplecoinNow = json["ask"].double {
            let ripplecoinLast = json["last"].double
            let result = ripplecoinNow - ripplecoinLast!
            if result > 0 {
                
                rippleLabel.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
                
            } else if result < 0 {
                
                rippleLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
                
            } else {rippleLabel.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)}
            
            
        }
    }
}
