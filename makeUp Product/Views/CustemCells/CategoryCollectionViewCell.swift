//
//  CategoryCollectionViewCell.swift
//  makeUp Product
//
//  Created by Jaydip on 04/05/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var shadowView: UIView!
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var CategoryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.cornerRadius = 10
        shadowView.layer.masksToBounds = true
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.50
        shadowView.layer.shadowRadius = 4
        
//        shadowView.layer.shadowOffset = CGSize(width: 5, height: 5)
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOpacity = 0.10
//        shadowView.layer.shadowRadius = 2
//        shadowView.layer.cornerRadius = 12
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
}
