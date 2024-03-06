//
//  SettingsList.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit

protocol SettingsModelProtocol {
    
}

struct SettingsModel {
    weak var controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol){
        self.controller = controller
    }
    
}

extension SettingsModel: SettingsModelProtocol {
    
}
