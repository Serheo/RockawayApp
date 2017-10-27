//
//  ViewController.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import CoreData

protocol BandSearchView: class {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func show(result: [BandResultDataSearchResult])
    func setSearchTitle(text: String)
}

class BandSearchController: UITableViewController,
    UISearchControllerDelegate,
    UISearchBarDelegate,
    BandSearchView {

    private var result: [BandResultDataSearchResult] = []
    var presenter: BandSearchPresenter!

    @IBOutlet weak var searchBar: UISearchBar!
    private var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingIndicator)

        self.tableView.registerNibCell(nibClass: BandItemTableViewCell.self)

        self.title = "Search"
        self.presenter.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(className: BandItemTableViewCell.self, for: indexPath)
        let item = result[indexPath.row]
        cell.fill(item: item)
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = result[indexPath.row]

        let cnt = UIStoryboard.main.instantiateViewController(className: DetailsViewController.self)
        let presenter = DetailsPresenter(bandToShow: item, network: self.presenter.network, view: cnt)
        cnt.presenter = presenter
        self.navigationController?.pushViewController(cnt, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.search(query: searchBar.text)
    }
}

extension BandSearchController {
    func show(result: [BandResultDataSearchResult]) {
        self.result = result
        self.tableView.reloadData()
    }

    func showLoadingIndicator() {
        self.loadingIndicator.startAnimating()
    }

    func hideLoadingIndicator() {
        self.loadingIndicator.stopAnimating()
    }

    func setSearchTitle(text: String) {
        self.searchBar.text = text
    }
}
