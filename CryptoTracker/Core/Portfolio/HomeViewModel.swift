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
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataServices = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init () {
        //subscribe to publishers.
        addSubscribers()
    }
    
    func reloadData() {
        isLoading = true
        coinDataServices.getCoins()
        HapticManager.notification(type: .success)
    }
    
    func addSubscribers(){
        
        func reloadData() {
            isLoading = true
            coinDataServices.getCoins()
            HapticManager.notification(type: .success)
        }
        
        coinDataServices.$allCoins
            .sink{ [weak self] (coins) in
                self?.coins = coins
            }.store(in: &cancellables)
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataServices.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
        
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
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
