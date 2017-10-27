//
//  DetailsTableViewCell.swift
//  Rockaway
//
//  Created by Sergey Shatunov on 10/26/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
    }

    func fill(title: String, subtitle: String) {
        self.textLabel?.text = title
        self.detailTextLabel?.text = subtitle
    }

}
