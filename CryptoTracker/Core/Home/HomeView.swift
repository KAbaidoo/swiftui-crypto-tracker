//
//  ContentView.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
        
  
    }
}

#Preview {
    HomeView()
}
