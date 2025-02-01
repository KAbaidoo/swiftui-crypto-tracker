//
//  HomeView.swift
//  CryptoTracker
//
//  Created by kobby on 05/06/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTab:Int = 0
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
                
                VStack{
                    TabView(selection: $selectedTab){
                        PorfolioView(selectedTab: $selectedTab)
                            .tabItem { Label("Portfolio", systemImage: "chart.pie.fill") }
                            .tag(0)
                        
                        MarketView()
                            .tabItem { Label("Market", systemImage: "chart.bar.xaxis") }
                            .tag(1)
                    }
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
