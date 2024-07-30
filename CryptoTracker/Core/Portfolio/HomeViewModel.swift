//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by kobby on 13/04/2024.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var coins: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataServices = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init () {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//            self.coins.append(DeveloperPreview.instance.coin)
//            self.portfolio.append(DeveloperPreview.instance.coin)
//        }
//        
        //subscrip to publishers.
        addSubscribers()
    }
    
    func addSubscribers(){
        coinDataServices.$coins
            .sink{ [weak self] (coins) in
                self?.coins = coins
            }.store(in: &cancellables)
        
        $searchText
            .combineLatest(coinDataServices.$coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink{[weak self] (returnedCoins) in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
        
    }
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
        }
    }

    
}
