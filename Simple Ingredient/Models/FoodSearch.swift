//
//  FoodSearch.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/21/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import Foundation
import ObjectMapper

class Ingredient: Mappable {
    var name: String?
    var photo: String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["meals.strMeal"]
        photo           <- map["meals.strMealThumb"]
    }
}

class Categories: Mappable {
    var name: String?
    var image: String?
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["categories.strCategory"]
        image           <- map["categories.strCategoryThumb"]
    }
}


