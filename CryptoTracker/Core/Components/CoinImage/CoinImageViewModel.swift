//
//  CoinImageViewModel.swift
//  CryptoTracker
//
//  Created by kobby on 18/04/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject{
    
@Published  var image: UIImage? = nil
@Published  var isLoading: Bool = false
    
    private let coin:CoinModel
    private let coinService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin:CoinModel){
        self.coin = coin
        self.coinService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    func addSubscribers(){
        
        coinService.$image.sink { [weak self] (_) in
            self?.isLoading = false
        } receiveValue: { [weak self] (image) in
            self?.image = image
        }.store(in: &cancellables)

        
    }
    
}
