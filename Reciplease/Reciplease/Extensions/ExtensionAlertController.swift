//
//  ExtensionAlertController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 12/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String, dissmiss: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
            if dissmiss {
               self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
