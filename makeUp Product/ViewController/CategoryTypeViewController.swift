//
//  CategoryTypeViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 06/05/22.
//

import UIKit
struct dataRespomse: Codable {
    var mackUp: [mackUpDataResponse]
}
struct mackUpDataResponse: Codable {
    let id: Int
    let brand: String?
    let name:  String!
    let price: String?
    let imageLink: String?
    let productLink: String
    let websiteLink: String
    let welcomeDescription: String?
    let rating: Float?
    let category: String?
    let productType: String
    let createdAt, updatedAt: String?
    let productAPIURL: String?
    let apiFeaturedImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, brand, name, price
        case imageLink = "image_link"
        case productLink = "product_link"
        case websiteLink = "website_link"
        case welcomeDescription = "description"
        case rating
        case category
        case productType = "product_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case productAPIURL = "product_api_url"
        case apiFeaturedImage = "api_featured_image"
    }
}

class CategoryTypeViewController: UIViewController {

    @IBOutlet var categorynameLabel: UILabel!
    var productType: String = ""
    var categoryName: String = ""
    var noInRow = 2
    var inset: UIEdgeInsets = UIEdgeInsets(top: 50, left: 10, bottom: 200, right: 10)
    var selectedCellindex:Int = -1
    var arrMakeUp: [mackUpDataResponse] = []
    @IBOutlet var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categorynameLabel.text = productType
        callGetAreaApi()
    }
    public func callGetAreaApi() {
    //
          var urlRequest = URLRequest(url: URL(string: "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=\(categoryName)")!)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let sesion = URLSession.shared
            let task = sesion.dataTask(with: urlRequest, completionHandler:  { (data, response, error) -> Void in
                let decoder = JSONDecoder()
                guard let responsedata = data else { return }
                do {
                    let responseObject = try decoder.decode([mackUpDataResponse].self, from: responsedata)
                    dump(responseObject)
                    self.arrMakeUp = responseObject
                    DispatchQueue.main.async {
                        self.productCollectionView.reloadData()
                    }
                } catch {
                    print("API response decode failed")
                }
            })
            task.resume()
        }
}
extension CategoryTypeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMakeUp.count
//        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryProductCollectionViewCell
        cell.productImage.downloaded(from: arrMakeUp[indexPath.row].imageLink!)
        cell.nameLabel.text = arrMakeUp[indexPath.row].name
        cell.priceLabel.text = arrMakeUp[indexPath.row].price
        if arrMakeUp[indexPath.row].price == "0.0" {
            cell.priceLabel.text = "$ 17.0"
        }
        cell.layer.borderColor = selectedCellindex == indexPath.row ? UIColor(red:0.804, green:0.396, blue:0.475, alpha: 1).cgColor : UIColor(red:0.804, green:0.396, blue:0.475, alpha: 0.25).cgColor
       
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 3
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let paddingSpace = inset.left * CGFloat(noInRow + 1) //24
        let availableWidth = width - paddingSpace  //width - 23
        let cellWidth = availableWidth/CGFloat(noInRow)
        let cellSize: CGSize = CGSize(width: cellWidth, height: 252)
        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return inset
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellindex = indexPath.row
        let buyProduct = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        buyProduct.productDetail = arrMakeUp[indexPath.row]
            navigationController?.pushViewController(buyProduct, animated: true)
        collectionView.reloadData()
    }
}
