//
//  TVSBTableViewController.swift
//  TableViewWithSearchBar
//
//  Created by Vanessa Cantero Gómez on 02/06/15.
//  Copyright (c) 2015 VCG. All rights reserved.
//

import UIKit
import Foundation


class TVSBTableViewResult: UITableViewController {
    private var filteredProducts: [String] = [String]()
    private let kCellIdentifier: String = "cell"

    override func viewDidLoad() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = filteredProducts[indexPath.row]

        return cell
    }
}

class TVSBTableViewController: UITableViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

    private let dataModel: [String] = ["Hello", "Bye", "Meh", "Wowo", "Bored", "Borked", "Vanessa"]
    private let kCellIdentifier: String = "cell"
    internal var searchBarInNavController: Bool = false

    lazy var resultsTableController: TVSBTableViewResult = {
        let rResult = TVSBTableViewResult()
        return rResult
    }()

    lazy var searchController: UISearchController = {
        let sController = UISearchController(searchResultsController: self.resultsTableController)
        sController.searchBar.placeholder = "Search something"
        sController.searchResultsUpdater = self
        sController.searchBar.sizeToFit()
        sController.searchBar.searchBarStyle = .Default
        return sController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "This is funny"
        navigationController?.navigationBar.topItem?.title = ""

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)

        if searchBarInNavController {
            searchController.hidesNavigationBarDuringPresentation = false
            navigationItem.titleView = searchController.searchBar
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }

        resultsTableController.tableView.delegate = self

        searchController.delegate = self
        searchController.searchBar.delegate = self

        definesPresentationContext = true
    }

    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = dataModel[indexPath.row]

        return cell
    }

    // MARK: UISearchResultsUpdating

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTableController: TVSBTableViewResult = searchController.searchResultsController as! TVSBTableViewResult

        searchTableController.filteredProducts = dataModel.filter({ $0.uppercaseString.rangeOfString(searchController.searchBar.text.uppercaseString) != nil })
        searchTableController.tableView.reloadData()
    }

    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
