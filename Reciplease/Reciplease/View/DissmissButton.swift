//
//  DissmissButton.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 26/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class DissmissButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }
    
    private func addCornerRadius() {
        layer.cornerRadius = bounds.width / 2
    }
}
