//
//  EditPortfolio.swift
//  CryptoTracker
//
//  Created by kobby on 29/12/2024.
//

import SwiftUI
import Foundation


struct EditPorfolioView: View {
    
    @State private var selectedCoin: CoinModel
    @Binding private var showEditPortfolio: Bool
    @State private var showCheckmark: Bool = false
    @State private var quantityText: String = ""
  
    @EnvironmentObject private var vm: HomeViewModel
    
    init(selectedCoin: CoinModel, showEditPortfolio: Binding<Bool>) {
        self.selectedCoin = selectedCoin
        self._showEditPortfolio = showEditPortfolio
    }

    var body: some View {
        NavigationView {
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                        portfolioInputSection
                }
            }
            .onAppear {
                updateSelectedCoin()
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                if showEditPortfolio {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showEditPortfolio.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        }
                    }
                }
           
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            })
        }
 
    }
}

struct EditPorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPorfolioView(selectedCoin: dev.coin, showEditPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}

extension EditPorfolioView {
    
    private func updateSelectedCoin() {
        
        if let portfolioCoin = vm.portfolioCoins.first(where: {
            
           return $0.id == selectedCoin.id
        }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin.symbol.uppercased()):")
                Spacer()
                Text(selectedCoin.currentPrice.asCurrencyWith6Decimals())
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin.currentHoldings != Double(quantityText)) ?
                    1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard
            let amount = Double(quantityText)
            else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: selectedCoin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin.currentPrice)
        }
        return 0
    }
}
