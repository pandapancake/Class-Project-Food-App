//
//  ViewController.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/20/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    var ingredient: Ingredient!
    var ingredientItem: [Ingredient] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Seperate this into its own function for cleaner code
    func setupUI(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        ingredientTextField.delegate = self
        //Whenever you add a target, it should be done when the view loads.
        searchButton.addTarget(self, action: #selector(MainViewController.searchButton(_:)), for: .touchUpInside)
    }
    
    @objc func searchButton(_ sender: Any){
        let text: String = ingredientTextField.text!
        let escapedString = ingredientTextField.text!.replacingOccurrences(of: " ", with: "%20")
        
        searchIngredient(ingredient: escapedString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTextField {
            textField.resignFirstResponder()
        }
        return true
    }

    func searchIngredient(ingredient: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: C\(json)") // serialized json response
                    self.ingredient = Ingredient(JSON: json as! [String:Any])
                    //                    print(weather?.name as Any)

                }
            case .failure(let error):
                print(error)
            }
        }
        
        //Why is this here?
//        searchButton.addTarget(self, action: #selector(MainViewController.searchButton(_:)), for: .touchUpInside)

    }
    
  
    
}

