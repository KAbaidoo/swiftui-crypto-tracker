//
//  String.swift
//  CryptoTracker
//
//  Created by kobby on 29/07/2024.
//

import Foundation
extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
