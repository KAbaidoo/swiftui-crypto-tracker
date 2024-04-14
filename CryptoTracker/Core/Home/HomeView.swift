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



