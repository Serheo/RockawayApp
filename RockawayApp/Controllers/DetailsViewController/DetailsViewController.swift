//
//  DetailsViewController.swift
//  Rockaway
//
//  Created by Sergey Shatunov on 10/26/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

protocol DetailsView: class {
    func show(profile: BandProfileResult)
    func show(error: Error?)
    func setProfileTitle(title: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class DetailsViewController: UITableViewController, DetailsView {

    enum Sections: Int {
        case bio
        case info
        case discography

        static func count() -> Int {
            return 3
        }
    }

    enum SectionInfo: Int {
        case years
        case genre
        case country

        static func count() -> Int {
            return 3
        }
    }

    private var loadingIndicator: UIActivityIndicatorView!
    private var profile: BandProfileResult!

    var presenter: DetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingIndicator.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingIndicator)

        self.tableView.registerNibCell(nibClass: DetailsTableViewCell.self)
        self.tableView.registerNibCell(nibClass: DetailsInfoTableCell.self)

        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        presenter.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.count()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if profile == nil {
            return 0
        }
        guard let sectionItem = Sections(rawValue: section) else {
            return 0
        }

        switch sectionItem {
        case .bio:
            return profile.data.hasInfoSection() ? 1 : 0
        case .info:
            return SectionInfo.count()
        case .discography:
            return profile.data.discography.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let sectionItem = Sections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch sectionItem {
        case .discography:
            let cell = tableView.dequeueReusableCell(className: DetailsTableViewCell.self, for: indexPath)
            let disk = profile.data.discography[indexPath.row]
            cell.fill(title: disk.year, subtitle: disk.title)
            return cell
        case .bio:
            let cell = tableView.dequeueReusableCell(className: DetailsInfoTableCell.self, for: indexPath)
            cell.fill(title: profile.data.bio, photoUrl: profile.data.photo)
            return cell
        case .info:
            return infoSectionCellForRowAt(indexPath: indexPath, in: tableView)
        }

    }

    func infoSectionCellForRowAt(indexPath: IndexPath, in table: UITableView) -> UITableViewCell {

        guard let sectionItem = SectionInfo(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        switch sectionItem {
        case .years:
            let cell = tableView.dequeueReusableCell(className: DetailsTableViewCell.self, for: indexPath)
            cell.fill(title: "Year", subtitle: profile.data.details.yearActive)
            return cell
        case .genre:
            let cell = tableView.dequeueReusableCell(className: DetailsTableViewCell.self, for: indexPath)
            cell.fill(title: "Genre", subtitle: profile.data.details.genre)
            return cell
        case .country:
            let cell = tableView.dequeueReusableCell(className: DetailsTableViewCell.self, for: indexPath)
            cell.fill(title: "Country", subtitle: profile.data.details.countryOfOrigin)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionItem = Sections(rawValue: section), profile != nil else {
            return nil
        }

        if sectionItem.rawValue == Sections.discography.rawValue && profile.data.discography.count > 0 {
            return "Discography"
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func show(profile: BandProfileResult) {
        self.profile = profile
        self.tableView.reloadData()
    }

    func show(error: Error?) {
        let cnt = UIAlertController(title: "Error", message: "Something went wrong", preferredStyle: .alert)
        cnt.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
        })

        self.present(cnt, animated: true, completion: nil
        )
    }

    func showLoadingIndicator() {
        loadingIndicator?.startAnimating()
    }

    func hideLoadingIndicator() {
        loadingIndicator?.stopAnimating()
    }

    func setProfileTitle(title: String) {
        self.title = title
    }

}
