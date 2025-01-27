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
    
    @StateObject var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    @State private var showEditPortfolio: Bool = false
    @State private var selectedCoin: CoinModel
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 20
    
    init(coin: CoinModel){
        selectedCoin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView{
            VStack {
               
                VStack(spacing: 20) {
                    ChartView(coin: vm.coin)
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
        .sheet(isPresented: $showEditPortfolio) {
            EditPorfolioView(selectedCoin: selectedCoin, showEditPortfolio: $showEditPortfolio)
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
         
            }
        }
    }
}


extension DetailView {
 
    private var navigationBarTrailingItem: some View {
        Button(action: {
            showEditPortfolio.toggle()
        }) {
            Text("Add to Portfolio")
                .font(.headline)
                .foregroundColor(Color.theme.primaryText)
        }
    }
    

    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(vm.overviewStatistics) { stat in
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
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
        })
    }
    
    
}



