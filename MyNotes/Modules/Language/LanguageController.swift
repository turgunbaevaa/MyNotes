//
//  LanguageController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 22/3/24.
//

import UIKit

protocol LanguageControllerProtocol {
    func onSelectLanguage()
    
    func onSuccessSelectLanguage()
    
    func onFailureSelectLanguage()
}

class LanguageController: LanguageControllerProtocol {
    
    var view: LanguageViewProtocol?
    var model: LanguageModelProtocol?
    
    init(view: LanguageViewProtocol) {
        self.view = view
        self.model = LanguageModel(controller: self)
    }
    
    func onSelectLanguage() {
        
    }
    
    func onSuccessSelectLanguage() {
        
    }
    
    func onFailureSelectLanguage() {
        
    }
    
    
}
