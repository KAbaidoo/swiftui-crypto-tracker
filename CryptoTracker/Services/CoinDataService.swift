//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by kobby on 17/04/2024.
//

import Foundation
import Combine


class CoinDataService{
    @Published var coins: [CoinModel] = []
    
    var subscription: AnyCancellable?
    
    init(){
        getCoins()
    }
    
    func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        subscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return output.data
            })
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink{ (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] (coins) in
                self?.coins = coins
                self?.subscription?.cancel()
            }
    }
}
