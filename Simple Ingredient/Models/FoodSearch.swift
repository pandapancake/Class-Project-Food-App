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
        link            <- map["me als.strYoutube"]
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

class Meal: Mappable {
    
    /*
     "publisher": "All Recipes",
     "f2f_url": "http://food2fork.com/view/11332",
     "title": "Dessert Crepes",
     "source_url": "http://allrecipes.com/Recipe/Dessert-Crepes/Detail.aspx",
     "recipe_id": "11332",
     "image_url": "http://static.food2fork.com/42741693ad.jpg",
     "social_rank": 99.9999999998884,
     "publisher_url": "http://allrecipes.com"
 */
    var name: String?
    var imageURL: String?
    var image: UIImage?
    var id: String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name            <- map["strMeal"]
        imageURL        <- map["strMealThumb"]
        id              <- map["idMeal"]
    }
}

/*
 Recipe
 "publisher": "All Recipes",
 "f2f_url": "http://food2fork.com/view/11332",
 "ingredients": [
 "4 eggs, lightly beaten",
 "1 1/3 cups milk",
 "2 tablespoons butter, melted",
 "1 cup all-purpose flour",
 "2 tablespoons white sugar",
 "1/2 teaspoon salt"
 ],
 "source_url": "http://allrecipes.com/Recipe/Dessert-Crepes/Detail.aspx",
 "recipe_id": "11332",
 "image_url": "http://static.food2fork.com/42741693ad.jpg",
 "social_rank": 99.9999999998884,
 "publisher_url": "http://allrecipes.com",
 "title": "Dessert Crepes"
*/




