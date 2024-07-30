//
//  MarketView.swift
//  CryptoTracker
//
//  Created by kobby on 01/06/2024.
//

import SwiftUI

struct MarketView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
       
            ZStack{
//                backround layer
                Color.theme.background
                    .ignoresSafeArea()
               
                VStack{
                    SearchBarView(searchText: $vm.searchText)
                    coinListLabel
                List {
                    ForEach(vm.coins){ coin in
                        CoinRowView(coin:coin)
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                }
                
            }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension MarketView {
    private var coinListLabel: some View{
        HStack{
            Text("Holdings")
            Spacer()
            Text("Value (Change)")
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal,30)
    }
}
