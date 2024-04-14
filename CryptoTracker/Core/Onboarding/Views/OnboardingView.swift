//
//  OnboardingView.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI


struct OnboardingView: View {

    @AppStorage("new_user") var isNewUser:Bool?
    
    
    @State var selctedTab:Int = 0
    @State var tabs:[Int] = [
        0,
        1,
        2
    ]
    @State var index:Int = 0
    
    
    var body: some View {
        
        ZStack{
            
            
            
            VStack{
                
                TabView(
                    selection: $selctedTab
                ){
                    OnboardingTabView(
                        item:  OnboardingModel(
                            title: "Track your cryptocurrency portfolio in realtime",
                            description: "Keep track of your profits, losses and portfolio valuation in one place."
                        )
                    )
                    .tag(
                        0
                    )
                    
                    OnboardingTabView(
                        item:  OnboardingModel(
                            title: "Keep up-to-date with market trends",
                            description: "SwiftCoin lets you track over 1000+ cryptocurrencies"
                        )
                    )
                    .tag(
                        1
                    )
                    
                    OnboardingTabView(
                        item:  OnboardingModel(
                            title: "Get notifications on significant market events.",
                            description: "Set alarms for price movements which are important to your portfolio."
                        )
                    )
                    .tag(
                        2
                    )
                }
                .tabViewStyle(
                    .page(
                        indexDisplayMode: .always
                    )
                )
                
                
            }
            .onAppear{
                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.accent
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
                
                Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { (Timer) in
                                        withAnimation(
                                            Animation
                                                .easeInOut(
                                                    duration: 2.0
                                                ).repeatForever()
                                        ){
                                            next()
                                        }
                }
                }
            
            VStack{
                Spacer()
                
                Image(
                    "crypto_guru"
                )
                .resizable()
                .aspectRatio(
                    contentMode: .fit
                )
                .frame(
                    maxWidth: 300,
                    maxHeight: 300
                )
                .padding(
                    20
                )
                .padding(
                    .bottom,
                    200
                )

                
                Button(action: {
                    isNewUser = false
                },
                       label: {
                    Text(
                        "Get Started"
                    )
                    .frame(
                        maxWidth: 150
                    )
                    .font(
                        .headline
                    )
                    .fontWeight(
                        .bold
                    )
                    .foregroundColor(
                        .white
                    )
                    .padding()
                    .padding(
                        .horizontal,
                        20
                    )
                    .background(
                        Capsule()
                    )
                })
                .padding(
                    .bottom,
                    50
                )
            }
 
            }
        
    }
    
    func next() {
        index += 1
        if index == tabs.count {
            index = 0
        }
        selctedTab = index
    }
}

#Preview {
    OnboardingView()
}
