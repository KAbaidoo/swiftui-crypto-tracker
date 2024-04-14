//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by kobby on 13/04/2024.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    @Published var coins: [CoinModel] = []
    @Published var portfolio: [CoinModel] = []
    
    init () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.coins.append(DeveloperPreview.instance.coin)
            self.portfolio.append(DeveloperPreview.instance.coin)
        }
    }
    
}
