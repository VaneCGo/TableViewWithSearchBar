//
//  TVSBMainTableViewController.swift
//  TableViewWithSearchBar
//
//  Created by Vanessa Cantero Gómez on 02/06/15.
//  Copyright (c) 2015 VCG. All rights reserved.
//

import Foundation
import UIKit

class TVSBMainTableViewController: UITableViewController {
    private let mainContent: [String] = ["SearchBar in NavigationBar", "SearchBar in HeaderView"]
    private let kCellIdentifier: String = "cell"

    override func viewDidLoad() {
        navigationItem.title = "SearchBar — Tutorial"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainContent.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = mainContent[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let searchBarNavController = TVSBTableViewController()
        searchBarNavController.searchBarInNavController = indexPath.row == 0 ? true : false
        navigationController?.pushViewController(searchBarNavController, animated: true)
    }
}
