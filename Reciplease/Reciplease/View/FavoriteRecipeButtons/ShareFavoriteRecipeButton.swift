//
//  ShareFavoriteRecipeButton.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 06/04/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import UIKit

class ShareFavoriteRecipeButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }
    
    private func addCornerRadius() {
        layer.cornerRadius = bounds.width / 2
    }
}
