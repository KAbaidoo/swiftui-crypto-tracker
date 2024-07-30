//
//  HomeView.swift
//  CryptoTracker
//
//  Created by kobby on 05/06/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                TabView{
                    NavigationStack{
                        PorfolioView()
                    }
                    .tabItem { Label("Portfolio", systemImage: "chart.pie.fill") }
                    
                    NavigationStack{
                        MarketView()
                    }
                    .tabItem { Label("Market", systemImage: "chart.bar.xaxis") }
                    
                }
        
            }
         
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
        .environmentObject(dev.homeVM)
    }
}
