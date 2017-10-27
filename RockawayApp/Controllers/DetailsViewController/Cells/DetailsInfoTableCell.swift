//
//  DetailsInfoTableCell.swift
//  Rockaway
//
//  Created by Sergey Shatunov on 10/26/17.
//  Copyright © 2017 SHS. All rights reserved.
//

import UIKit
import AlamofireImage
class DetailsInfoTableCell: UITableViewCell {

    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    let placeholderImage = UIImage(named: "placeholder")

    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImage.image = placeholderImage
        self.bioLabel.text = ""
    }

    func fill(title: String, photoUrl: String?) {
        if title.isEmpty {
            self.bioLabel.text = "no description"
        } else {
            self.bioLabel.text = title
        }

        if let photo = photoUrl, let url = URL(string: photo) {
            self.avatarImage.image = placeholderImage
            self.avatarImage.af_setImage(withURL: url)
        } else {
            self.avatarImage.image = placeholderImage
        }

    }

}
