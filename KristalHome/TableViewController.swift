//
//  TableViewController.swift
//  KristalHome
//
//  Created by Prince Mathew on 08/11/19.
//  Copyright © 2019 Prince Mathew. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    

    enum EndPoint: String {
        case getCountryName = "https://restcountries-v1.p.rapidapi.com/name/"
    }
    private var countries:[Country]?
    private var delayTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsSearchResultsController = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "countryCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _countries = countries else {
            return 0
        }
        return _countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _countries = countries,
            indexPath.row < _countries.count else {
                return UITableViewCell()
        }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "countryCell")
        cell.textLabel?.text = _countries[indexPath.row].name
        cell.detailTextLabel?.text = _countries[indexPath.row].capital
        return cell
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        delayTimer?.invalidate()
        guard let searchTerm = searchController.searchBar.text else {
            return
        }
        delayTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {[weak self] (timer) in
            self?.fetchResults(for: searchTerm)
        })
    }
    
    func fetchResults(for searchTerm: String) {
        guard searchTerm.count > 0,
            let url = URL(string: EndPoint.getCountryName.rawValue.appending(searchTerm)) else {
                countries = nil
                refreshContents()
                return
        }
        NetworkHandler.shared.makeRequest(to: url, with: [Country].self, httpMethod: "GET") {[weak self] (_result, _countries, _error) in
            self?.countries = _countries
            self?.refreshContents()
        }
    }
    
    private func refreshContents() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
