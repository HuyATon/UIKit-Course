//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Huy Ton Anh on 28/11/2024.
//

import UIKit


class AccountSummaryViewController: UIViewController {
    
    // Request Models
    var profile: Profile?
    
    // ViewModel
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessange: "Welcome", name: "", date: Date())
    
    
    var accounts = [AccountSummaryCell.ViewModel]()
    var tableView = UITableView()
    var headerView = AccountSummaryHeaderView(frame: .zero)

    
    lazy var logoutButtonItem: UIBarButtonItem = {
        
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .systemRed
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
}

extension AccountSummaryViewController {
    
    private func setup() {
        
        setUpTableView()
        setUpTableHeaderView()
//        fetchAccounts()
        fetchDataAndLoadViews()
    }
    
    private func setUpTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = self.logoutButtonItem
        
    }
    
    private func setUpTableHeaderView() {
        
        
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
}

extension AccountSummaryViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        
        cell.configure(with: accounts[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)
    }
}

extension AccountSummaryViewController {
    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .banking,
                                                            accountName: "Basic Savings",
                                                        balance: 929466.23)
        let chequing = AccountSummaryCell.ViewModel(accountType: .banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = AccountSummaryCell.ViewModel(accountType: .creditCard,
                                                       accountName: "Visa Avion Card",
                                                       balance: 412.83)
        let masterCard = AccountSummaryCell.ViewModel(accountType: .creditCard,
                                                       accountName: "Student Mastercard",
                                                       balance: 50.83)
        let investment1 = AccountSummaryCell.ViewModel(accountType: .investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = AccountSummaryCell.ViewModel(accountType: .investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}

extension AccountSummaryViewController {
    
    @objc func logoutTapped(sender: UIButton) {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}


extension AccountSummaryViewController {
    
    private func fetchDataAndLoadViews() {
        
        fetchProfile(forUserId: "1") { result in
            switch result {
                case .success(let profile):
                    self.profile = profile
                    self.configureTableHeaderViews(with: profile)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableHeaderViews(with profile: Profile) {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessange: "Good evening", name: profile.firstName, date: Date())
        
        headerView.configure(viewModel: vm)
    }
}
