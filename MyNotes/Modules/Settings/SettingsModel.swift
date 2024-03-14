//
//  SettingsList.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit

protocol SettingsModelProtocol {
    func deleteNotes(indexPath: IndexPath)
}

class SettingsModel: SettingsModelProtocol {
    weak var controller: SettingsControllerProtocol?
    private let coreDataService = CoreDataService.shared
    
    init(controller: SettingsControllerProtocol){
        self.controller = controller
    }
    
    func deleteNotes(indexPath: IndexPath) {
        if indexPath.row == 2 {
            //TODO: change after (alert with confirmation)
            coreDataService.deleteNotes()
        }
    }
}
