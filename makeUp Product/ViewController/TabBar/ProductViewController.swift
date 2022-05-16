//
//  ProductViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 04/05/22.
//

import UIKit
class ProductViewController: UIViewController {
    
    let topProducturl = "http://makeup-api.herokuapp.com/api/v1/products.json?"
    var arrMakeUp: [mackUpDataResponse] = []
    let obj = HomeViewController()
    var noInRow = 2
    var inset: UIEdgeInsets = UIEdgeInsets(top: 50, left: 10, bottom: 200, right: 10)
    var selectedCellindex:Int = -1
   
    @IBOutlet var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetAreaApi(url: topProducturl)
//        getApiCall()

    }
    func navigation(index:Int){
            let web = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
            navigationController?.pushViewController(web, animated: true)
        }
    public func callGetAreaApi(url: String) {
            let baseString: String = url
            var urlRequest = URLRequest(url: URL(string: baseString)!)
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
                        self.productCollectionView.reloadData()
                    }
                } catch {
                    print("API response decode failed")
                }
            })
            task.resume()
        }
}
 //MARK: - collectionView delegate and datasourse, delegateFlowLayout
extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMakeUp.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AllProductCollectionViewCell
        cell.productimage.downloaded(from: arrMakeUp[indexPath.row].imageLink!)
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
