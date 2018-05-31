//
//  FoodSearch.swift
//  Simple Ingredient
//
//  Created by Pan Lin on 5/21/18.
//  Copyright © 2018 Pan Lin. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireImage

class Ingredient: Mappable {
    var name: String?
    var imageURL: String?
    var image: UIImage?
    var id: String?
    var country: String?
    var instructions: String?
    var ingredient: String?
    var measure: String?
    var link: String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["meals.strMeal"]
        imageURL        <- map["meals.strMealThumb"]
        id              <- map["meals.idMeal"]
        country         <- map["meals.strArea"]
        instructions    <- map["meals.strInstructions"]
        ingredient      <- map["meals.strIngredient1"]
        measure         <- map["meals.strMeasure6"]
        link            <- map["meals.strYoutube"]
    }
}

class Categories: Mappable {
    var name: String?
    var imageURL: String?
    var image: UIImage?
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["strCategory"]   //already did in i for item to get to the second level
        imageURL           <- map["strCategoryThumb"]
    }
}


