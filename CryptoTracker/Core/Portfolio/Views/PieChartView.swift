//
//  ChartView.swift
//  CryptoTracker
//
//  Created by kobby on 14/01/2025.
//
import Charts
import SwiftUI

struct PieChartView: View {
    
    let portfolio: [PortfolioAmount]
    
    var body: some View {
 
            Chart(portfolio, id: \.coin){ item in
                SectorMark(
                    angle: .value("Count", item.amount),
                    innerRadius: .ratio(0.65),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(Color.background.opacity(0.6))
                .annotation(position: .overlay) {
                    Text(item.coin)
                        .foregroundStyle(Color.secondary)
                        .font(.caption)
                }
                
            }
            .scaledToFit()
        

    }
}

struct PortfolioAmount{
    var coin:String
    var amount:Int
}

#Preview {
    let portfolio: [PortfolioAmount] = [
        .init(coin: "BTC", amount: 79),
        .init(coin: "XRP", amount: 73),
        .init(coin: "DOGE", amount: 58),
        .init(coin: "LTC", amount: 15),
        .init(coin: "ETH", amount: 9),
    ]
    PieChartView(portfolio: portfolio)
}
