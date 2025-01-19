//
//  ChartView.swift
//  CryptoTracker
//
//  Created by kobby on 14/01/2025.
//
import Charts
import SwiftUI

struct PieChartView: View {
    
    let portfolio: [CoinModel]
    
    var body: some View {
 
        Chart(portfolio, id: \.symbol){ item in
                SectorMark(
                    angle: .value("Value", item.currentHoldingsValue),
                    innerRadius: .ratio(0.65),
                    angularInset: 2
                )
                .cornerRadius(8)
                .foregroundStyle(Color.background.opacity(0.6))
                .annotation(position: .overlay) {
                    Text(item.symbol)
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
    
//    PieChartView(portfolio: portfolio)
}
