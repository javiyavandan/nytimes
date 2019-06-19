//
//  ArticleCell.swift
//  NYTImes
//
//  Created by Vihaa on 6/18/19.
//  Copyright © 2019 VIHAA. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPublishedBy: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewImage: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
