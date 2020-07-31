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

extension CoinViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}

extension CoinViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.coinLabel.text = coin.currencyString
            self.currencyLabel.text = coin.unit
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
