//
//  BrandProductViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 12/05/22.
//

import UIKit

class BrandProductViewController: UIViewController {

    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var brandProductCollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetAreaApi()
        brandNameLabel.text = brandName
    }
    var brand: String = ""
    var brandName: String = ""
    var arrMakeUp: [mackUpDataResponse] = []
    var noInRow = 2
    var inset: UIEdgeInsets = UIEdgeInsets(top: 50, left: 10, bottom: 200, right: 10)
    var selectedCellindex:Int = -1
   
    public func callGetAreaApi() {
        switch brand {
        case "cargo cosmetics": brand = "cargo%20cosmetics"
        case "pure anada": brand = "pure%20anada"
        case "burt's bees": brand = "burt%27s%20bees"
        case "lotus cosmetics usa": brand = "lotus%20cosmetics%20usa"
        default: ""
        }
        var urlRequest = URLRequest(url: URL(string: "https://makeup-api.herokuapp.com/api/v1/products.json?brand=\(brand)")!)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let sesion = URLSession.shared
            let task = sesion.dataTask(with: urlRequest, completionHandler:  { (data, response, error) -> Void in
                let decoder = JSONDecoder()
                guard let responsedata = data else { return }
                do {
                    let responseObject = try decoder.decode([mackUpDataResponse].self, from: responsedata)
                    dump(responseObject.count)
                    self.arrMakeUp = responseObject
                    DispatchQueue.main.async {
                        self.brandProductCollectionview.reloadData()
                    }
                } catch {
                    print("API response decode failed")
                }
            })
            task.resume()
        }
}
extension BrandProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMakeUp.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = brandProductCollectionview.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrandProductCollectionViewCell
        cell.productImage.downloaded(from: arrMakeUp[indexPath.row].imageLink!)
        cell.nameLabel.text = arrMakeUp[indexPath.row].name
        if arrMakeUp[indexPath.row].price == "0.0" {
            cell.priceLabel.text = "17.5"
        }
        cell.priceLabel.text = arrMakeUp[indexPath.row].price

        cell.layer.borderColor = selectedCellindex == indexPath.row ? UIColor(red:0.804, green:0.396, blue:0.475, alpha: 1).cgColor : UIColor(red:0.804, green:0.396, blue:0.475, alpha: 0.5).cgColor
       
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
        print(arrMakeUp.count)
        let detail = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        detail.productDetail = arrMakeUp[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
        selectedCellindex = indexPath.row
        collectionView.reloadData()
    }
}
