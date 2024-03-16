//
//  SettingsController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 4/3/24.
//

import UIKit

protocol SettingsControllerProtocol: AnyObject {
    func onDeleteNotes()
    
    func onSuccessDelete()
    
    func onFailureDelete()
}

class SettingsController: SettingsControllerProtocol {
    
    var view: SettingsViewProtocol?
    var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
    
    func onDeleteNotes() {
        model?.deleteNotes()
    }
    
    func onSuccessDelete() {
        view?.successDeleteNotes()
    }
    
    func onFailureDelete() {
        view?.failureDeleteNotes()
    }
    
}
