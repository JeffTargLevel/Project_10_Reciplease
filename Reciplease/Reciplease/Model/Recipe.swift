//
//  Ingredients.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 05/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import UIKit

protocol Recipe {
    var name: String { get }
    var ingredients: String { get }
    var totalTime: String { get }
    var rating: String { get }
    var recipeImage: UIImage { get }
}
