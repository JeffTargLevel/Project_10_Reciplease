//
//  DissmissAllergyButton.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 11/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import UIKit

class DissmissAllergyButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }
    
    private func addCornerRadius() {
        layer.cornerRadius = bounds.width / 2
    }
}
