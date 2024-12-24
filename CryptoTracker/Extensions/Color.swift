//
//  Color.swift
//  CryptoTracker
//
//  Created by kobby on 13/04/2024.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
}

struct ColorTheme{
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let primaryText = Color("PrimaryTextColor")
    let secondaryText = Color("SecondaryTextColor")
}
