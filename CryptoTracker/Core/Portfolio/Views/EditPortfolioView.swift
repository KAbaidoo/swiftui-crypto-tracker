//
//  EditPortfolio.swift
//  CryptoTracker
//
//  Created by kobby on 29/12/2024.
//

import SwiftUI
import Foundation


struct EditPorfolioView: View {
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var showCheckmark: Bool = false
    @State private var quantityText: String = ""
  
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
       
            ZStack{
                Color.theme.background
                    .ignoresSafeArea()
        
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavBarButtons
                }
            })
    }
}

struct EditPorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPorfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension EditPorfolioView {
    
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
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ?
                    1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
//            removeSelectedCoin()
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
}
