//
//  ExploreViewController.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/21/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireImage

class ExploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var exploreCollectionView: UICollectionView!
    var categories: Categories!
    var categoriesItems: [Categories] = []
    var typeFood: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        exploreIngredient()
        transparentNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        let layout = self.exploreCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(6, 6, 0, 6)
        layout.minimumInteritemSpacing = 6
        layout.itemSize = CGSize(width: (self.exploreCollectionView.frame.size.width - 24)/2, height: self.exploreCollectionView.frame.size.height/4)
    }
    
    func exploreIngredient() {
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get Explore Ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: C\(json)") // serialized json response
                    let jsonData = json as! [String:Any]
                    let foodType = jsonData["categories"] as! Array<Dictionary<String, String>>
                    for item in foodType {
                        let type = Categories(JSON: item as [String:Any])
                        self.getPhoto(type: type!) //type: name,imageURL
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhoto (type: Categories) {
        Alamofire.request(type.imageURL!).responseImage { response in
//            debugPrint(response)
//            print(response.request)
//            print(response.response)
//            debugPrint(response.result)
            if let image = response.result.value {
                print("image downloaded: \(image)")

                type.image = image
                self.categoriesItems.append(type) //how many image
                self.exploreCollectionView.reloadData()
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell

        cell.exploreImage.image = categoriesItems[indexPath.item].image
        cell.exploreName.text = categoriesItems[indexPath.item].name
    
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 6
        
        typeFood = categoriesItems[indexPath.item].name
        performSegue(withIdentifier: "foodType", sender: self)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "foodType"){
            let vc = segue.destination as? ExplorePageOneViewController
            vc?.typeFood = typeFood
            
            print(typeFood)
        }
    }
}
