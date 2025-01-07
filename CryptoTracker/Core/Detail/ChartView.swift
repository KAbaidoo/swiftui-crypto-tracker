//
//  ChartView.swift
//  CryptoTracker
//
//  Created by kobby on 25/12/2024.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    
    private let startDate: Date
    private let endDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel){
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        endDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    
    var body: some View {
        VStack{
            
            chartView
                .padding(5)
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
                
             
            
            chartDateLabels
                .padding(.horizontal, 4)
            
        }.font(.caption)
            .foregroundColor(Color.white.opacity(0.5))
            .padding(.vertical)
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                .fill(
                    LinearGradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 260)
                )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.linear(duration: 2.0)) {
                        percentage = 1.0
                    }
                }
            }
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
             
            }
            .trim(from: 0, to: percentage)
            .stroke(Color.white.opacity(0.8), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
 
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }

}
