//
//  ContentView.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI

struct PorfolioView: View {
    @AppStorage("new_user") var isNewUser:Bool?
    @EnvironmentObject private var vm: HomeViewModel
    
    @State var selectedCoin: CoinModel? = nil
    @State var showEditPortfolio: Bool = false
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
              
                PortfolioCardView()
                coinListLabel
                List {
                    ForEach(vm.portfolio){ coin in
                        NavigationLink(destination: EditPorfolioView(selectedCoin: coin, showEditPortfolio: .constant(false))) {
                            CoinRowView(coin:coin, showHoldings: true)
                        }
                      
                    
                           
                    }
                }
                .listStyle(PlainListStyle())
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            
            
        }
        .navigationTitle("Portfolio")
    }
}

struct PorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PorfolioView()
        }
        .environmentObject(dev.homeVM)
    }
}

extension PorfolioView {
    private var coinListLabel: some View{
        HStack{
            Text("Coin")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .leading)
            Text("Holdings (Value)")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .center)
            Text("Price (Change)")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }.font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal,30)
    }
}




struct PortfolioCardView: View {
    let portfolio: [PortfolioAmount] = [
        .init(coin: "BTC", amount: 79),
        .init(coin: "XRP", amount: 73),
        .init(coin: "DOGE", amount: 58),
        .init(coin: "LTC", amount: 15),
        .init(coin: "ETH", amount: 9),
    ]
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text("balance")
                        .font(.callout)
                    Text("USD")
                        .font(.headline)
                        .fontWeight(.bold)
                    Image(systemName: "chevron.down")
                        .font(.callout)
                }
                Spacer()
                Text("$15,0000")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Text("$5,986")
                    .font(.caption)
            }
            .padding(.vertical)
            .foregroundColor(Color.background.opacity(0.8))
      
            Spacer()
            PieChartView(portfolio: portfolio)
                .frame(width: 150)
        }
        .padding()
        .frame(height: 250)
        .frame(maxWidth: .infinity)
        .background( RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
            .fill(
                LinearGradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding(20)
      
    }
}
