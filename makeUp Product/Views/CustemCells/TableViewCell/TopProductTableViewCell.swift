//
//  PeoductTableViewCell.swift
//  makeUp Product
//
//  Created by Jaydip on 11/05/22.
//

import UIKit

class TopProductTableViewCell: UITableViewCell {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.cornerRadius = 10
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.15
        shadowView.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
