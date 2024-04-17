//
//  ContentView.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @AppStorage("new_user") var isNewUser:Bool?
    
    var body: some View {
       
            ZStack{
//                backround layer
                Color.theme.background
                    .ignoresSafeArea()
                VStack{
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
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



