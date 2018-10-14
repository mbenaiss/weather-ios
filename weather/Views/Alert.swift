//
//  Alert.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 14/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import UIKit


extension UIViewController{
    func ShowAlert(){
        let alertController = UIAlertController(title: "Warning", message:
            "Please check your connections!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

