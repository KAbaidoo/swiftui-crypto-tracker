//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by kobby on 18/04/2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject private var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
       _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                
            } else if vm.isLoading {
                ProgressView()
            }
            else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
            
        }
       
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
