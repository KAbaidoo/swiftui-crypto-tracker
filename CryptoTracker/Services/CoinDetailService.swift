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
    
    var subscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        subscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.subscription?.cancel()
            }
    }
    
   
    
}
