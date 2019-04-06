//
//  YummlyRecipeDetailApiResponse.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 04/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation

struct YummlyRecipeDetailApiResponse: Codable {
    let nutritionEstimates: [NutritionEstimate]
    let images: [Image]
    let ingredientLines: [String]
    let attribution: Attribution
}

struct Attribution: Codable {
    let url: String
}

struct NutritionEstimate: Codable {}

struct Image: Codable {
    let hostedSmallURL, hostedMediumURL, hostedLargeURL: String
    let imageUrlsBySize: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case hostedSmallURL = "hostedSmallUrl"
        case hostedMediumURL = "hostedMediumUrl"
        case hostedLargeURL = "hostedLargeUrl"
        case imageUrlsBySize
    }
}
