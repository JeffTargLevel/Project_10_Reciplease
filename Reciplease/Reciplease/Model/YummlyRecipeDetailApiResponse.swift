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
    let totalTime: String
    let images: [Image]
    let name: String
    let source: Source
    let id: String
    let ingredientLines: [String]
    let attribution: Attribution
    let numberOfServings, totalTimeInSeconds: Int
    let attributes: Attributes
    let flavors: Flavors
    let rating: Int
}

struct NutritionEstimate: Codable {
    let attribute: String
    let description: String?
    let value: Double
    let unit: Unit
}

struct Attributes: Codable {
    let course: [String]
}

struct Attribution: Codable {
    let html: String
    let url: String
    let text: String
    let logo: String
}

struct Flavors: Codable {
}

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

struct Source: Codable {
    let sourceDisplayName, sourceSiteURL: String
    let sourceRecipeURL: String
    
    enum CodingKeys: String, CodingKey {
        case sourceDisplayName
        case sourceSiteURL = "sourceSiteUrl"
        case sourceRecipeURL = "sourceRecipeUrl"
    }
}

struct Unit: Codable {
    let id: String
    let name: Name
    let abbreviation: Abbreviation
    let plural: Plural
    let pluralAbbreviation: Abbreviation
    let decimal: Bool
}

enum Abbreviation: String, Codable {
    case g = "g"
    case grams = "grams"
    case iu = "IU"
    case kcal = "kcal"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}

enum Name: String, Codable {
    case calorie = "calorie"
    case gram = "gram"
    case iu = "IU"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}

enum Plural: String, Codable {
    case calories = "calories"
    case grams = "grams"
    case iu = "IU"
    case mcgDFE = "mcg_DFE"
    case mcgRAE = "mcg_RAE"
}


