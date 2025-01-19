//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by kobby on 12/04/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldings: Bool
    var body: some View {
        HStack{
            coinWithHoldings
            Spacer()
            if showHoldings {
                holdingsWithValue
            }
            Spacer()
            valueWithChange
        }
    }
}


struct CoinRowView_Preview: PreviewProvider{
    static var previews: some View{
        CoinRowView(coin: dev.coin, showHoldings: true)
    }
}

extension CoinRowView{
    
    private var coinWithHoldings:some View{
        HStack{
            CoinImageView(coin: coin)
                .frame(width: 40, height:40)
            
            VStack(alignment: .leading){
                Text(coin.symbol.uppercased())
                    .font(.headline)
                
            }
        }
    }
    private var holdingsWithValue:some View{
      
            VStack(alignment: .leading){
                Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                    .font(.headline)
                
                HStack{
                    Text("\((coin.currentHoldings ?? 0.0).asNumberString()) \(coin.symbol.uppercased())")
                        .font(.caption)
                        .foregroundColor(Color.theme.secondaryText)
                }.font(.caption)
                    .foregroundColor((coin.priceChangePercentage24H ?? 0 >= 0) ?
                        Color.theme.green :
                         Color.theme.red
                     )
            }
        
    }
        
        private var valueWithChange:some View{
          
                VStack(alignment: .trailing){
                    Text("\(coin.currentPrice.asCurrencyWith2Decimals())")
                        .font(.headline)
                    HStack{
                        Text("\((coin.priceChange24H ?? 0.0).asCurrencyWith2Decimals())")
                        Text("\((coin.priceChangePercentage24H ?? 0.0).asPercentString())")
                            
                    }.font(.caption)
                        .foregroundColor((coin.priceChangePercentage24H ?? 0 >= 0) ?
                            Color.theme.green :
                             Color.theme.red
                         )
                }
            
        }
    
}
