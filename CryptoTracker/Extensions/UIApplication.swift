//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by kobby on 29/12/2024.
//
import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
