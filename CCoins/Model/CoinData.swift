//
//  CoinData.swift
//  CCoins
//
//  Created by Adithep on 7/30/20.
//  Copyright © 2020 Adithep. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let rate: Double
    let asset_id_quote: String
}
