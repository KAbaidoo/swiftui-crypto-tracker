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
    init(coin: CoinModel){
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
