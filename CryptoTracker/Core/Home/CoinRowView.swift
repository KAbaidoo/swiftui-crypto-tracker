//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by kobby on 12/04/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    var body: some View {
        HStack{
            coinWithHoldings
            Spacer()
            holdingValueWithChange
        }
    }
}


struct CoinRowView_Preview: PreviewProvider{
    static var previews: some View{
        CoinRowView(coin: dev.coin)
    }
}

extension CoinRowView{
    
    private var coinWithHoldings:some View{
        HStack{
            Circle()
                .frame(width: 40, height:40)
            
            // Coin and holdings
            VStack(alignment: .leading){
                Text(coin.name)
                    .font(.headline)
                Text("\((coin.currentHoldings ?? 0.0).asNumberString()) \(coin.symbol.uppercased())")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
        
        private var holdingValueWithChange:some View{
          
                VStack(alignment: .trailing){
                    Text("\(coin.currentHoldingsValue.asCurrencyWith2Decimals())")
                        .font(.headline)
                    HStack{
                        Text("\(coin.currentHoldingsValueChange.asCurrencyWith2Decimals())")
                        Text("\((coin.priceChangePercentage24H ?? 0.0).asPercentString())")
                            
                    }.font(.caption)
                        .foregroundColor((coin.priceChangePercentage24H ?? 0 >= 0) ?
                            Color.theme.green :
                             Color.theme.red
                         )
                }
            
        }
    
}
