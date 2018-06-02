//
//  MealService.swift
//  Simple Ingredient
//
//  Created by Benny on 6/2/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

//MealService.sharedInstance.getCategories()
class MealService: NSObject {
    static let sharedInstance = MealService()    
    
    func getCategories(completion:@escaping(String, [Categories]) -> Void)  {
        let url = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get Explore Ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: C\(json)") // serialized json response
                    var categoriesItems:[Categories] = []
                    let jsonData = json as! [String:Any]
                    let foodType = jsonData["categories"] as! Array<Dictionary<String, String>>
                    for item in foodType {
                        let type = Categories(JSON: item as [String:Any])
                        categoriesItems.append(type!) //how many image
                        
                        
                        //                        self.getPhoto(type: type!) //type: name,imageURL
                    }
                    completion("success", categoriesItems)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    
//    func getCategoryImages() -> Void{
//        Alamofire.request(type.imageURL!).responseImage { response in
//            //            debugPrint(response)
//            //            print(response.request)
//            //            print(response.response)
//            //            debugPrint(response.result)
//            if let image = response.result.value {
//                print("image downloaded: \(image)")
//                
//                type.image = image
//                self.categoriesItems.append(type) //how many image
//                self.exploreCollectionView.reloadData()
//            }
//        }
//    }
    
}




