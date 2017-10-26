//
//  BandItemTableViewCell.swift
//  RockawayApp
//
//  Created by Sergey Shatunov on 10/25/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

class BandItemTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }

    func fill(item: BandResultDataSearchResult) {
        self.textLabel?.text = item.name
        self.detailTextLabel?.text = item.genre
    }

}
