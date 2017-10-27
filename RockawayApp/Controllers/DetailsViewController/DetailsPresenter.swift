//
//  DetailsPresenter.swift
//  Rockaway
//
//  Created by Sergey Shatunov on 10/26/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

final class DetailsPresenter {

    private var bandToShow: BandResultDataSearchResult!
    private var network: NetworkService!
    private weak var view: DetailsView?

    init(bandToShow: BandResultDataSearchResult, network: NetworkService, view: DetailsView) {
        self.bandToShow = bandToShow
        self.network = network
        self.view = view
    }

    func viewDidLoad() {
        view?.showLoadingIndicator()
        view?.setProfileTitle(title: bandToShow.name)
        network.getBandProfile(itemId: bandToShow!.itemId, successful: { [weak self] (result) in
            self?.view?.show(profile: result)
            self?.view?.hideLoadingIndicator()
        }) { [weak self] (err) in
            self?.view?.show(error: err)
            self?.view?.hideLoadingIndicator()
        }
    }
}
