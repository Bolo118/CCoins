//
//  CoinModel.swift
//  CCoins
//
//  Created by Adithep on 7/30/20.
//  Copyright © 2020 Adithep. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency: Double
    let unit: String
    
    var currencyString: String {
        return String(format: "%.2f", currency)
    }
}
