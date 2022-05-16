//
//  BuyProductViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 05/05/22.
//

import UIKit

class BuyProductViewController: UIViewController {

    @IBOutlet var shadowView: UIView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var discriptionlabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
    var productDetail: mackUpDataResponse = mackUpDataResponse(id: 0, brand: "", name: "", price: "", imageLink: "", productLink: "", websiteLink: "", welcomeDescription: "", rating: 0.0, category: "", productType: "", createdAt: "", updatedAt: "", productAPIURL: "", apiFeaturedImage: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.downloaded(from: productDetail.imageLink!)
        productNameLabel.text = productDetail.name
        priceLabel.text = "$ \(productDetail.price ?? "")"
        discriptionlabel.text = productDetail.welcomeDescription
//        rateLabel.text = "(\String(productDetail.rating))"
        
//        shadowView.layer.cornerRadius = 10
//        shadowView.layer.masksToBounds = true
//        shadowView.layer.shadowOffset = .zero
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOpacity = 0.50
//        shadowView.layer.shadowRadius = 4
    }
}
