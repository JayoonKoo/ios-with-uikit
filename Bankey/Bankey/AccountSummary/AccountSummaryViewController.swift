//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by 구자윤 on 2022/09/29.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    let tableView = UITableView()
    
    var viewModel: AccountViewModel? = nil
    
    init(viewModel: AccountViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension AccountSummaryViewController {
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        
        setTableViewHeader()
        setupTable()
        viewModel?.fetchData()
    }
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = appColor
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    private func setTableViewHeader() {
        let header = AccountSummaryHeaderView()
        header.frame.size.height = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        tableView.tableHeaderView = header
    }
    
    private func setupTable() {
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
    }
}

// MARK: tableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let account = viewModel?.getAccountSummaryCellData(by: indexPath) else {return}
        print(account.accountName)
    }
}

// MARK: talbeBiewDatasource
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as? AccountSummaryCell else {
            return UITableViewCell()
        }
        cell.account = viewModel.getAccountSummaryCellData(by: indexPath)
        return cell
    }
}

