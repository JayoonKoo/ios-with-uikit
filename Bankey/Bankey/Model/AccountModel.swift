//
//  AccountModel.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/30.
//

import Foundation

struct AccountModel {
    enum AccountType {
        case Banking
        case CreditCard
        case Investment
    }
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
}
