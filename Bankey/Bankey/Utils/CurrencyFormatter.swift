//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/30.
//
import Foundation
import UIKit

class CurrencyFormatter {
    func makeBalanceAmountText(balance: Decimal) -> NSAttributedString {
        let dallarCents = breakDollarsIntoCents(balnce: balance)
        let dallars = dallarCents.0
        let cents = dallarCents.1
        return makeBalanceAmountText(dollars: dallars, cents: cents)
    }
    
    func breakDollarsIntoCents(balnce: Decimal) -> (String, String) {
        let balnceDouble = NSDecimalNumber(decimal: balnce).doubleValue
        
        let modfMoney = modf(balnceDouble)
        
        let dollars = convertDollar(modfMoney.0)
        let cents = convertCents(modfMoney.1)
        
        return (dollars, cents)
    }
    
    func convertDollar(_ dallar: Double) -> String {
        let formattedDallar = formatDallar(dallar)
        var result = formattedDallar.split(separator: ".")[0]
        result.removeFirst()
        return String(result)
    }
    
    func convertCents(_ cents: Double) -> String {
        let result: String
        if cents == 0 {
            result = "00"
        } else {
            result = String(format: "%.0f", cents * 100)
        }
        return result
    }
    
    func formatDallar(_ dallar: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dallar as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAmountText(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarsSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarsSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}
