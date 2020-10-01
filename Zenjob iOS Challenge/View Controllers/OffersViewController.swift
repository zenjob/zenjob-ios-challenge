//
//  OffersViewController.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

class OffersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let refreshControl = UIRefreshControl()
    let emptyStateMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No available offers. Pull to refresh"
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        return label
    }()
    
    var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .white
        tb.register(SingleShiftCell.self, forCellReuseIdentifier: "singleCell")
        tb.register(MultipleShiftsCell.self, forCellReuseIdentifier: "multipleCell")
        return tb
    }()
    
    
    var dispatcher: Dispatcher
    var user: User
    var offers: [Offer] = []
    var offersTask: GetOffersTask
    
    init(dispatcher: Dispatcher, user: User) {
        self.dispatcher = dispatcher
        self.user = user
        self.offersTask = GetOffersTask(offset: "0", token: user.accessToken)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupRefreshControl()
        tableView.dataSource = self
        tableView.delegate = self
        fetchOffers(completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    
    // MARK: Subviews
    private func addSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func setupRefreshControl() {
        refreshControl.tintColor = UIColor(red: 0.290, green: 0.149, blue: 0.592, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(refreshOffers), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Offers")
    }
    
    @objc func refreshOffers() {
        fetchOffers(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        })
    }
    
    func fetchOffers(offset: String = "0", completion: @escaping () -> Void) {
        offersTask.offset = offset
        offersTask.execute(in: dispatcher) { (offers, error) in
            
            if let error = error {
                self.showAlert(error: error)
                print("offersTask error: \(error.localizedDescription)")
            }
            
            if let offers = offers {
                if offset == "0" {
                    self.offers.removeAll()
                }
                self.offers += offers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            completion()
        }
    }
    
    func showAlert(error: Error) {
        let controller = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == offers[indexPath.row].shifts.count - 1 {
            fetchOffers(completion: { } )
        }
        
        if offers[indexPath.row].shifts.count > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "multipleCell", for: indexPath) as! MultipleShiftsCell
            cell.populate(offer: offers[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath) as! SingleShiftCell
            cell.populate(offer: offers[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if offers[indexPath.row].shifts.count > 1 {
            return 400.0
        }
        return 300.0
    }
}
