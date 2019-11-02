//
//  Helpers.swift
//  gameballSDK
//
//  Created by Martin Sorsok on 5/14/19.
//

import UIKit

class Helpers {
    
    func  getTransactionTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let transactionTime = formatter.string(from: date)
        return transactionTime
    }
    func  getBodyHashed (playerUniqueID: String , amount: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmmss"
        let transactionTime = formatter.string(from: date)
        return  (playerUniqueID + ":" + transactionTime + ":" + amount + ":" + transactionkey).sha1()
        
    }
    func dPrint(_ message:Any) {
       // print(message)
    }
    
}
