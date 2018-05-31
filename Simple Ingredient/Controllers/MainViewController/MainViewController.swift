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
        ingredientTextField.delegate = self
        transparentNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func transparentNavBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        //Whenever you add a target, it should be done when the view loads.
        searchButton.addTarget(self, action: #selector(MainViewController.searchButton(_:)), for: .touchUpInside)
    }
    
    @objc func searchButton(_ sender: Any){
        let text: String = ingredientTextField.text!
        let escapedString = ingredientTextField.text!.replacingOccurrences(of: " ", with: "%20")
        
        searchIngredient(name: escapedString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTextField {
            textField.resignFirstResponder()
        }
        return true
    }

    func searchIngredient(name: String) {
        let url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(name)"
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Get ingredient Successful")
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                    self.ingredient = Ingredient(JSON: json as! [String:Any])
                    print(self.ingredient.name)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

//    func creatAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
//            alert.dismiss(animated: true, completion: nil)}))
//
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "ingredientSegue"){
//            let vc = segue.destination as? MainPageOneViewController
//            vc?.ingredientItem = itemName
//            
//        }
//    }
}

