//
//  RecipeSettingsViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 11/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var eggAllergySwitch: UISwitch!
    @IBOutlet weak var glutenAllergySwitch: UISwitch!
    @IBOutlet weak var peanutAllergySwitch: UISwitch!
    
    private var eggAllergy = "397^Egg-Free"
    private var glutenAllergy = "393^Gluten-Free"
    private var peanutAllergy = "394^Peanut-Free"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateAnySwitch()
    }
    
    // MARK: - Choice allergy with switch
    
    private func switchEggAllergy() {
        guard eggAllergySwitch.isOn else {
           return SettingService.eggAllergy = ""
            
        }
        SettingService.eggAllergy = eggAllergy
    }
    
    private func switchGlutenAllergy() {
        guard glutenAllergySwitch.isOn else {
            return SettingService.glutenAllergy = ""
        }
        SettingService.glutenAllergy = glutenAllergy
    }
    
    private func switchPeanutAllergy() {
        guard peanutAllergySwitch.isOn else {
          return SettingService.peanutAllergy = ""
        }
        SettingService.peanutAllergy = peanutAllergy
    }
    
    // MARK: - Update status of switch every time the view appears with allergy saved
    
    private func allergySwitchState(allergySaved: String, allergyValue: String, selectSwitch: UISwitch) {
        guard allergySaved == allergyValue else {
           return selectSwitch.isOn = false
        }
        selectSwitch.isOn = true
    }
    
    private func updateAnySwitch() {
        allergySwitchState(allergySaved: SettingService.eggAllergy, allergyValue: eggAllergy, selectSwitch: eggAllergySwitch)
        allergySwitchState(allergySaved: SettingService.glutenAllergy, allergyValue: glutenAllergy, selectSwitch: glutenAllergySwitch)
        allergySwitchState(allergySaved: SettingService.peanutAllergy, allergyValue: peanutAllergy, selectSwitch: peanutAllergySwitch)
    }
    
    @IBAction func switchedEggAllergySwitch(_ sender: UISwitch) {
        switchEggAllergy()
    }
    
    @IBAction func switchedGlutenAllergySwitch(_ sender: Any) {
        switchGlutenAllergy()
    }
    
    @IBAction func switchedPeanutAllergySwitch(_ sender: Any) {
        switchPeanutAllergy()
    }
    
    @IBAction func tapDissmissAllergyButton() {
        dismiss(animated: true, completion: nil)
    }
}
