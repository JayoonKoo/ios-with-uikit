//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/29.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    let balanceVStack = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    var account: AccountSummaryCellData? = nil {
        didSet {
            if let account = account {
                configure(account: account)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AccountSummaryCell {
    func style() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.adjustsFontSizeToFitWidth = true
        
        balanceVStack.translatesAutoresizingMaskIntoConstraints = false
        balanceVStack.axis = .vertical
        balanceVStack.alignment = .trailing
        balanceVStack.setContentHuggingPriority(UILayoutPriority(500), for: .horizontal)
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.adjustsFontForContentSizeCategory = true
        balanceLabel.adjustsFontSizeToFitWidth = true
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
    }
    
    func layout() {
        contentView.addSubViews([typeLabel, underlineView, nameLabel, balanceVStack, chevronImageView])
        balanceVStack.addArrangedSubViews([balanceLabel, balanceAmountLabel])
        // typeLabel
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
        ])
        // underlineView
        NSLayoutConstraint.activate([
            underlineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
        ])
        // balanceVStack
        NSLayoutConstraint.activate([
            balanceVStack.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            balanceVStack.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceVStack.trailingAnchor, multiplier: 4),
        ])
        // chevronImageView
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.topAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1),
        ])
    }
    
    func configure(account: AccountSummaryCellData) {
        typeLabel.text = account.accountType
        underlineView.backgroundColor = account.accountColor
        nameLabel.text = account.accountName
        balanceLabel.text = account.balanceText
        balanceAmountLabel.attributedText = account.balnce
    }
    
}

struct AccountSummaryCellData {
    let accountType: String
    let accountName: String
    let accountColor: UIColor
    let balnce: NSAttributedString
    let balanceText: String
}
