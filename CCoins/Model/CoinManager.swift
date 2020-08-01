//
//  CoinManager.swift
//  CCoins
//
//  Created by Adithep on 7/30/20.
//  Copyright © 2020 Adithep. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","EUR","GBP","HKD","IDR","INR","JPY","MXN","NZD","PLN","RUB","SGD","USD","ZAR"]
    
    let coinArray = ["BTC","ETH","NEO","XRP","LTC","DOGE"]
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "A1693F4A-8CDC-4BF9-B08C-F92897C3FBE5"
    
    func getCoinPrice(coin: String, currency: String) {
        let urlString = "\(baseURL)/\(coin)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let currency = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, coin: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    // JSON parsing to turn the json data that we get back from API into a real swift object
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            let unit = decodedData.asset_id_quote
            
            let coinPrice = CoinModel(currency: lastPrice, unit: unit)
            return coinPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func showCoinName(name: String) -> String {
        switch name {
        case "ETH":
            return "Ethereum"
        case "NEO":
            return "Neo"
        case "XRP":
            return "XRP"
        case "LTC":
            return "Litecoin"
        case "DOGE":
            return "Dogecoin"
        default:
            return "Bitcoin"
        }
    }
}
