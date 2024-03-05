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
    
    var image: UIImage?
    var settingsName: String
    var settingsButton: String
    
    weak var controller: SettingsControllerProtocol?
    
//    init(controller: SettingsControllerProtocol){
//        self.controller = controller
//    }
    
}

extension SettingsModel: SettingsModelProtocol {
    
}
