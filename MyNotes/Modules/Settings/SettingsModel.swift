//
//  SettingsList.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 29/2/24.
//

import UIKit

protocol SettingsModelProtocol {
    func deleteNotes()
}

class SettingsModel: SettingsModelProtocol {
    weak var controller: SettingsControllerProtocol?
    private let coreDataService = CoreDataService.shared
    
    init(controller: SettingsControllerProtocol){
        self.controller = controller
    }
    
    func deleteNotes() {
        coreDataService.deleteNotes { response in
            if response == .success {
                self.controller?.onSuccessDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
    }
}
