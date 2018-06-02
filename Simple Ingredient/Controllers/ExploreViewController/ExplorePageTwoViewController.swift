//
//  ExploreRecipesDetailViewController.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/26/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ExplorePageTwoViewController: UIViewController {

    @IBOutlet weak var pageTwoImage: UIImageView!
    @IBOutlet weak var pageTwoLabel: UILabel!
    var ingredient: Meal!
    var foodID: String?

    override func viewDidLoad() {
        detailTypeFood()
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func detailTypeFood() {
        let url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(foodID!)"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get foodID Successful")
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    let meal = Meal(JSON: json as! [String:Any])
                    self.getPhoto(type: meal!)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPhoto (type: Meal) {
        Alamofire.request(type.imageURL!).responseImage { response in
            //            debugPrint(response)
            //            print(response.request)
            //            print(response.response)
            //            debugPrint(response.result)
            if let image = response.result.value {
                print("image downloaded: \(image)")
                
                type.image = image
            }
        }
    }
    
    
}
