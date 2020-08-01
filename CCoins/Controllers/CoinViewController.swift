//
//  ViewController.swift
//  CCoins
//
//  Created by Adithep on 7/30/20.
//  Copyright © 2020 Adithep. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    var coinManager = CoinManager()
    var coinName = ""
    
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        currencyPicker.setValue(#colorLiteral(red: 0.9984455705, green: 0.9411713481, blue: 0.6099827886, alpha: 1), forKey: "textColor")
    }
    
}

//MARK: - UIPickerViewDelegate and DataSource
extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return coinManager.coinArray.count
        } else {
            return coinManager.currencyArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return coinManager.coinArray[row]
        } else {
            return coinManager.currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let coinIndex = pickerView.selectedRow(inComponent: 0)
        let currencyIndex = pickerView.selectedRow(inComponent: 1)
        let currencySelected = coinManager.currencyArray[currencyIndex]
        coinName = coinManager.coinArray[coinIndex]
        
        coinManager.getCoinPrice(coin: coinName, currency: currencySelected)
    }
}

//MARK: - CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.coinLabel.text = coin.currencyString
            self.currencyLabel.text = coin.unit
            self.coinNameLabel.text = coinManager.showCoinName(name: self.coinName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
