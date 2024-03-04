//
//  SettingsController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 4/3/24.
//

import UIKit

protocol SettingsControllerProtocol: AnyObject {
    
}

class SettingsController {
    var view: SettingsViewProtocol?
    var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        //self.model = SettingsModel(controller: self)
    }
}

extension SettingsController: SettingsControllerProtocol {
    
}
