//
//  MarketView.swift
//  CryptoTracker
//
//  Created by kobby on 01/06/2024.
//

import SwiftUI

struct MarketView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
       
            ZStack{
//                backround layer
                Color.theme.background
                    .ignoresSafeArea()
               
                VStack{
                    SearchBarView(searchText: $viewModel.searchText)
                    coinListLabel
                List {
                    ForEach(viewModel.coins){ coin in
                        NavigationLink(destination: DetailView(coin: coin)) {
                            CoinRowView(coin: coin, showHoldings: false)
                        }
                    }
                }
                .listStyle(PlainListStyle())
               
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
                
            }
            .navigationTitle("Markets")
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MarketView()
        }
        .environmentObject(dev.homeVM)
    }
}

extension MarketView {
    private var coinListLabel: some View{
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()

            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button(action: {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            }, label: {
                Image(systemName: "goforward")
            })
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal,30)
    }
}
