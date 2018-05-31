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

class ExploreViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var exploreCollectionView: UICollectionView!
    var categories: Categories!
    var categoriesItems: [Categories] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        exploreIngredient()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func exploreIngredient() {
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get Explore Ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: C\(json)") // serialized json response
                    let foodType = json["categories"] as Array<Dictionary<String, String>>
                    self.categories = Categories(JSON: json as! [String:Any])
                    self.categoriesItems.append(self.categories)
                    self.exploreCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(categoriesItems.count)
        return categoriesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell

        cell.exploreImage.image = UIImage(named: "\(categoriesItems[indexPath.item].image)")
        cell.exploreName.text = categoriesItems[indexPath.item].name
    
        return cell
    }

    
}
