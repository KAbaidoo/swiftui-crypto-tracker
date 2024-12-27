//
//  DetailLoadingView.swift
//  CryptoTracker
//
//  Created by kobby on 29/07/2024.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

struct DetailView:View {
    
    @StateObject var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 20
    
    init(coin: CoinModel){
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        ScrollView{
            VStack {
               
                VStack(spacing: 20) {
                    ChartView(coin: viewModel.coin)
                    Divider()
                    overviewGrid
                    Divider()
                    additionalGrid
                }
                .padding()
            }
            
        }
        .background(
            Color.theme.background
                .ignoresSafeArea()
        )
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
         
            }
        }
    }
}


extension DetailView {
 
    private var navigationBarTrailingItem: some View {
        Button(action: {}) {
            Text("Add to Portfolio")
                .font(.headline)
                .foregroundColor(Color.theme.primaryText)
        }
    }
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.secondaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    
}



