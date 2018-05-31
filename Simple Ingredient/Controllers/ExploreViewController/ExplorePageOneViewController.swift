//
//  ExplorePageOneViewController.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/26/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireImage


class ExplorePageOneViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
    @IBOutlet weak var explorePageOneCollectionView: UICollectionView!
    var ingredient: Ingredient!
    var ingredientItem: [Ingredient] = []
    var typeFood: String?
    var foodID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explorePageOneCollectionView.dataSource = self
        explorePageOneCollectionView.delegate = self
        searchTypeFood()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchTypeFood() {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(typeFood)"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get typeFood Successful")
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    let ingredient = Ingredient(JSON: json as! [String:Any])
                    self.getPhoto(type: ingredient!)
                    print(self.ingredientItem)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhoto (type: Ingredient) {
        Alamofire.request(type.imageURL!).responseImage { response in
            //            debugPrint(response)
            //            print(response.request)
            //            print(response.response)
            //            debugPrint(response.result)
            if let image = response.result.value {
                print("image downloaded: \(image)")
                
                type.image = image
                self.ingredientItem.append(type)
                self.explorePageOneCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typeFoodCell", for: indexPath) as! ExplorePageOne
        
        cell.exploreRecipeImage.image = ingredientItem[indexPath.item].image
        cell.exploreRecipeLabel.text = ingredientItem[indexPath.item].name
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 6
        
        foodID = ingredientItem[indexPath.item].id
        performSegue(withIdentifier: "typeFoodCell", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "foodType"){
            let vc = segue.destination as? ExplorePageOneViewController
            vc?.foodID = foodID
            
            print(foodID)
        }
    }
    
    
    
    
}
