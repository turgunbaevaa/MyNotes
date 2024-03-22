//
//  LanguageModel.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 22/3/24.
//

import UIKit

protocol LanguageModelProtocol {
    func selectLanguage()
}

class LanguageModel: LanguageModelProtocol {
    
    var controller: LanguageControllerProtocol?
    private let appLanguageManager = AppLanguageManager.shared
    
    init(controller: LanguageControllerProtocol){
        self.controller = controller
    }
    
    func selectLanguage() {
        
    }
}
