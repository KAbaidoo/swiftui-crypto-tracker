//
//  OnboardingScreen.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI

struct OnboardingScreen: View {
    
    let item: OnboardingModel
    
    var body: some View {

            
        VStack(spacing:20){
            Spacer()
            Text(
                item.title
            )
            .fontWeight(.semibold)
            .font(.title)
            
            Text(
                item.description
            )
            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.gray)
            .padding(.bottom, 100)
            }
        .padding(30)
    }
}


#Preview {
    OnboardingScreen(
        item: OnboardingModel(
            title: "Track your cryptocurrency portfolio in realtime",
            description: "All your cryptocurrency investments in one place with realtime market price. "
        )
    )
}
