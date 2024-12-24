//
//  PortfolioDdataService.swift
//  CryptoTracker
//
//  Created by kobby on 02/09/2024.
//

import Foundation
import CoreData

class PortfolioDdataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
//            self.getPortfolio()
        }
    }
    
//    private func getPortfolio() {
//        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
//        do {
//            savedEntities = try container.viewContext.fetch(request)
//        } catch let error {
//            print("Error fetching Portfolio Entities. \(error)")
//        }
//    }
}
