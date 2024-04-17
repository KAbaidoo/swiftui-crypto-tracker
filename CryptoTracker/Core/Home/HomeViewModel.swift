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
    
    private let dataServices = CoinDataService()
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
        dataServices.$coins
            .sink{ [weak self] (coins) in
                self?.coins = coins
            }.store(in: &cancellables)
        
    }

    
}
