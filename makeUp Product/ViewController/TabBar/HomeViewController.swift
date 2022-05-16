//
//  ViewController.swift
//  makeUp Product
//
//  Created by Jaydip on 04/05/22.
//
import UIKit

class HomeViewController: UIViewController {
    
    struct Category {
        var name: String
        var productName: String
        var image: String
    }
    struct Brand {
        var name: String
        var brandName: String
        var image: String
    }
  var categories: [Category] = [Category(name: "Bronzer", productName: "bronzer", image: "bronzer"),
                              Category(name: "Blush", productName: "blush", image: "blush"),
                              Category(name: "Eyebrow", productName: "eyebrow", image: "eyebrow"),
                              Category(name: "Eyeliner", productName: "eyeliner", image: "eyeliner"),
                              Category(name: "Eyeshadow", productName: "eyeshadow", image: "eyeshadow"),
                              Category(name: "Foundation", productName: "foundation", image: "foundation"),
                              Category(name: "Lip Liner", productName: "lip_liner", image: "lip_liner"),
                              Category(name: "Mascara", productName: "mascara", image: "mascara"),
                              Category(name: "Lipstick", productName: "lipstick", image: "lipstick"),
                              Category(name: "Nail Polish", productName: "nail_polish", image: "nail_polish")]
    //MARK: -Variable
    var selectedCellindex: Int = -1
    var brands: [Brand] = [Brand(name: "Cargo", brandName: "cargo cosmetics",image: "1"),
                           Brand(name: "Revlon", brandName: "revlon", image: "2"),
                           Brand(name: "Pure anada", brandName: "pure anada", image: "3"),
                           Brand(name: "burt's bees", brandName: "burt's bees", image: "4"),
                           Brand(name: "Milani", brandName: "milani", image: "5"),
                           Brand(name: "Almay", brandName: "almay", image: "6"),
                           Brand(name: "Lotus", brandName: "lotus cosmetics usa", image: "7")]
    
    var noInRow = 1
    var inset: UIEdgeInsets = UIEdgeInsets(top: 50, left: 10, bottom: 200, right: 10)
    var arrMakeUp: [mackUpDataResponse] = []

    //MARK: -IBOutlets
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var brandCollectionView: UICollectionView!
    @IBOutlet var bestProductTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        callGetAreaApi()
    }
    public func callGetAreaApi() {
         var urlRequest = URLRequest(url: URL(string: "https://makeup-api.herokuapp.com/api/v1/products.json?price_greater_than=40")!)
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
                        self.bestProductTableView.reloadData()
                    }
                } catch {
                    print("API response decode failed")
                }
            })
            task.resume()
        }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandCollectionView {
            return brands.count
        }
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCollectionViewCell
        cell.categoryImage.image = UIImage(named: categories[indexPath.row].image)
        cell.CategoryName.text = categories[indexPath.row].name
        cell.layer.borderColor = selectedCellindex == indexPath.row ? UIColor(red:0.804, green:0.396, blue:0.475, alpha: 1).cgColor : UIColor(red:0.804, green:0.396, blue:0.475, alpha: 0.5).cgColor
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2

        if collectionView == brandCollectionView {
            let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BrandCollectionViewCell
            cell.brandImage.image = UIImage(named: brands[indexPath.row].image)
            cell.layer.borderColor = selectedCellindex == indexPath.row ? UIColor(red:0.898, green:0.616, blue:0.475, alpha: 1).cgColor : UIColor(red:0.898, green:0.616, blue:0.475, alpha: 0).cgColor
            cell.layer.cornerRadius = 25
            cell.layer.borderWidth = 3
            return cell
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGSize = CGSize(width: 108, height: 108)
        if collectionView == brandCollectionView {
            let cellSize: CGSize = CGSize(width: 240, height: 160)
            return cellSize
        }

        return cellSize
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if collectionView == categoryCollectionView {
            print(categories[indexPath.row].productName)
            let category = storyboard?.instantiateViewController(withIdentifier: "CategoryTypeViewController") as! CategoryTypeViewController
            category.categoryName = self.categories[indexPath.row].productName
            category.productType = self.categories[indexPath.row].name
            navigationController?.pushViewController(category, animated: true)
        }
        if collectionView == brandCollectionView {
            print(brands[indexPath.row].brandName)
            let category = storyboard?.instantiateViewController(withIdentifier: "BrandProductViewController") as! BrandProductViewController
            category.brand = self.brands[indexPath.row].brandName
            category.brandName = self.brands[indexPath.row].name
                   navigationController?.pushViewController(category, animated: true)
        }
        selectedCellindex = indexPath.row
        collectionView.reloadData()
    }
}
//MARK: - Tableview Delegate And Datasourse
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return arrMakeUp.count}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TopProductTableViewCell
        cell.priceLabel.text = "$ \(arrMakeUp[indexPath.row].price ?? "")"
        cell.productNameLabel.text = arrMakeUp[indexPath.row].name
        cell.productImage.downloaded(from: arrMakeUp[indexPath.row].imageLink!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buyProduct = storyboard?.instantiateViewController(withIdentifier: "BuyProductViewController") as! BuyProductViewController
        buyProduct.productDetail = arrMakeUp[indexPath.row]
            navigationController?.pushViewController(buyProduct, animated: true)
        tableView.reloadData()
    }
}

