//
//  SettingService.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 11/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation

class SettingService {
    private struct Keys {
        static let eggAllergy = "eggAllergy"
        static let glutenAllergy = "glutenAllergy"
        static let peanutAllergy = "peanutAllergy"
    }
    
    static var eggAllergy: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.eggAllergy) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.eggAllergy)
        }
    }
    
    static var glutenAllergy: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.glutenAllergy) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.glutenAllergy)
        }
    }
    
    static var peanutAllergy: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.peanutAllergy) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.peanutAllergy)
        }
    }
}
