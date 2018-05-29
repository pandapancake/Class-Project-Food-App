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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func exploreIngredient(category: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=category"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get Explore Ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: C\(json)") // serialized json response
                    self.categories = Categories(JSON: json as! [String:Any])
                    print(self.categories)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell

        cell.exploreImage.image = UIImage(named: "\(categoriesItems[indexPath.item].image)")
        cell.exploreName.text = categoriesItems[indexPath.item].name
    
        return cell
    }

    
}
