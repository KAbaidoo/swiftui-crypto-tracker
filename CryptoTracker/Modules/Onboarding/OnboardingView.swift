//
//  OnboardingView.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI


struct OnboardingView: View {
    
    @State var onboardingState:Int = 0
    
    var body: some View {
        
        
            ZStack{
                VStack{
                    Spacer()

                Image("crypto_guru")
                    .resizable()
                    .aspectRatio(contentMode: .fit )
                    .frame(maxWidth: 300, maxHeight: 300)
                    .padding(20)
                    .padding(.bottom,200)
               
        
                Button(action: {
                  
                }, label: {
                    Text("Get Started")
                        .frame(maxWidth: 150)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,20)
                        .background(
                            Capsule()
                        )
                })
                .padding(.bottom, 50)
                }
                
                
                VStack{
                   
                    TabView{
                        OnboardingScreen(item:  OnboardingItem(
                                            title: "Track your cryptocurrency portfolio in realtime",
                                            description: "Keep track of your profits, losses and portfolio valuation in one place."
                                        ))
                        
                        OnboardingScreen(item:  OnboardingItem(title: "Keep up-to-date with market trends",
                                                               description: "SwiftCoin lets you track over 1000+ cryptocurrencies"))
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    
                }
                .onAppear{
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.accent
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
                    
                }
                
             
            }

        
    }
}

#Preview {
    OnboardingView()
}
