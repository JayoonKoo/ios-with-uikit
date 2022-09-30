//
//  AccountViewModel.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/30.
//

import Foundation
import UIKit


class AccountViewModel {
    let formatter = CurrencyFormatter()
    var accounts: [AccountModel] = []
    var count: Int {
        return accounts.count
    }
    
    func fetchData() {
        let savings = AccountModel(accountType: .Banking, accountName: "Basic Savings", balance: 929466.23)
        let chequing = AccountModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 17562.44)
        let visa = AccountModel(accountType: .CreditCard, accountName: "Visa Avion Card", balance: 412.83)
        let masterCard = AccountModel(accountType: .CreditCard, accountName: "Student Mastercard", balance: 50.83)
        let investment1 = AccountModel(accountType: .Investment, accountName: "Tax-Free Saver", balance: 2000.00)
        let investment2 = AccountModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)
        
        accounts = [savings, chequing, visa, masterCard, investment1, investment2]
    }
    
    func getAccountSummaryCellData(by indexPath: IndexPath) -> AccountSummaryCellData {
        let account = accounts[indexPath.row]
        let accountType: String
        let accountColor: UIColor
        let balnce = formatter.makeBalanceAmountText(balance: account.balance)
        let balnceText: String
        switch account.accountType {
            case .Banking:
                accountType = "Banking"
                accountColor = appColor
                balnceText = "Current balance"
            case .CreditCard:
                accountType = "CreditCard"
                accountColor = .systemCyan
                balnceText = "Current balance"
            case .Investment:
                accountType = "Investment"
                accountColor = .systemPink
                balnceText = "Value"
        }
        
        return AccountSummaryCellData(
            accountType: accountType,
            accountName: account.accountName,
            accountColor: accountColor,
            balnce: balnce, balanceText: balnceText)
    }
    
}
