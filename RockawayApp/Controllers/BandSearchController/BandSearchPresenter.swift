//
//  BandSearchPresenter.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

final class BandSearchPresenter {

    private var network: NetworkService
    private var autocomplete: BandAutocompleteService
    private var storage: ResultStorage
    private weak var view: BandSearchView?

    init(network: NetworkService, storage: ResultStorage, view: BandSearchView) {
        self.network = network
        self.view = view
        self.storage = storage
        self.autocomplete = BandAutocompleteService(network: network)
    }

    func viewDidLoad() {
        storage.get { [weak self] (oldResult) in
            self?.view?.setSearchTitle(text: oldResult.data.query)
            self?.view?.show(result: oldResult.data.searchResult)
        }
    }

    func search(query: String?) {
        if let searchText = query, searchText.characters.count > 0 {
            self.view?.showLoadingIndicator()
            autocomplete.getBandSearchRequest(query: searchText, successful: { [weak self] (result) in
                self?.view?.hideLoadingIndicator()
                self?.view?.show(result: result.data.searchResult)
                self?.storage.save(item: result)
            }) { [weak self] (_) in
                self?.view?.hideLoadingIndicator()
            }
        } else {
            self.view?.show(result: [])
        }

    }
}
