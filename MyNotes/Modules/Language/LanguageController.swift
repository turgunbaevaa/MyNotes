//
//  LanguageController.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 22/3/24.
//

import UIKit

protocol LanguageControllerProtocol {
    func onSelectLanguage(language: LanguageType)
    
    func onSuccessSelectLanguage(language: LanguageType)
}

class LanguageController: LanguageControllerProtocol {
    
    var view: LanguageViewProtocol?
    var model: LanguageModelProtocol?
    
    init(view: LanguageViewProtocol) {
        self.view = view
        self.model = LanguageModel(controller: self)
    }
    
    func onSelectLanguage(language: LanguageType) {
        model?.selectLanguage(language: language) { response in
        }
    }
    
    func onSuccessSelectLanguage(language: LanguageType) {
        view?.successSelectedLanguage(language: language)
    }
}
