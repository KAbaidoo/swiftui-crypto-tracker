//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by kobby on 07/04/2024.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    
    @AppStorage("new_user") var isNewUser:Bool = true
    @StateObject var vm = HomeViewModel()
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
       
    var body: some Scene {
            
            WindowGroup {
                NavigationView {
                if !isNewUser {
                        HomeView()
                            .transition(transition)
                    } else {
                        OnboardingView()
                    }
                }.environmentObject(vm)
                }
            
        }
    
}

