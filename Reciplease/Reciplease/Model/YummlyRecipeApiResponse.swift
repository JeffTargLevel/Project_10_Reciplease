//
//  YummlyApiResponse.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 14/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation

struct YummlyRecipeApiResponse: Codable {
    let matches: [Match]
}

struct Match: Codable {
    let imageUrlsBySize: ImageUrlsBySize
    let ingredients: [String]
    let id: String
    let recipeName: String
    let totalTimeInSeconds: Int?
    let rating: Int
}

struct ImageUrlsBySize: Codable {
    let the90: String
    
    enum CodingKeys: String, CodingKey {
       case the90 = "90"
    }
}
