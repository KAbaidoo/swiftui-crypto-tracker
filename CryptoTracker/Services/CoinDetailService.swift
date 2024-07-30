//
//  CoinDetailService.swift
//  CryptoTracker
//
//  Created by kobby on 29/07/2024.
//

import Foundation
import Combine

class CoinDetailService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
    
}
